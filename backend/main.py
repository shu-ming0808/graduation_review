from fastapi import Depends, FastAPI
from sqlalchemy import select
from sqlalchemy.orm import Session

from backend.database import get_db
from backend.models import *
from backend.schemas import Request, Response

app = FastAPI()


@app.post("/", response_model=Response)
def graduation_review(data: Request, db: Session = Depends(get_db)):

    entry_year = data.entry_year
    transfer_grade = data.transfer_grade
    waiver_credits = data.waiver_credits if transfer_grade >= 1 else 0

    stmt = select(GraduationRule).where(GraduationRule.entry_year == entry_year)
    rule = db.scalars(stmt).one_or_none()

    stmt = select(RuleCondition).where(RuleCondition.rule_id == rule.rule_id)
    conditions = db.scalars(stmt).all()

    if transfer_grade >= 1:
        stmt = select(WaiverLimitRule.max_waiver_credits).where(
            WaiverLimitRule.transfer_entry_level == transfer_grade
        )
        max_waiver_credits = db.scalars(stmt).one_or_none()

    course_ids = []
    for year in data.courses[0].get("課業學習").get("gradeRecordList"):
        for course in year.get("GradeRecords"):
            course_ids.append(course.get("courseCode"))

    stmt = select(Course).where(Course.course_id.in_(course_ids))
    courses = db.scalars(stmt).all()

    dept_col = {}
    stmt = select(Department)
    departments = db.scalars(stmt).all()
    for department in departments:
        dept_col[department.department_id] = department.college_id

    stmt = select(Category.category_id).where(Category.category_name != "Elective")
    categories = db.scalars(stmt).all()

    response = {
        "total": [0, rule.total_credits_min],
        "total_ge": [0, rule.total_ge_credits],
    }
    for condition in conditions:
        min_credits = condition.min_credits
        if min_credits is None:
            min_credits = condition.min_courses
        response[condition.category_id] = [0, min_credits]

    for course in courses:
        category = course.category_id
        for condition in conditions:
            if category == condition.category_id:
                if (
                    condition.restrict_dept_id
                    and course.department_id != condition.restrict_dept_id
                ):
                    break
                if (
                    condition.restrict_college_id
                    and dept_col[course.department_id] != condition.restrict_college_id
                ):
                    break
                response[category][0] += course.credits if category != "pe" else 1
        if category == "elec":
            response["total"][0] += course.credits

    for condition in conditions:
        category = condition.category_id
        if category == "pe":
            response["pe"][0] = min(response["pe"][0], 4)
        else:
            max_credits = condition.max_credits
            if max_credits:
                response[category][0] = min(response[category][0], max_credits)
            if category.startswith("ge_"):
                response["total_ge"][0] += response[category][0]

    for category in categories:
        if not category.startswith("ge_"):
            response["total"][0] += response[category][0]

    response["total"][0] += response["total_ge"][0]
    if transfer_grade >= 1:
        response["total"][0] += min(waiver_credits, max_waiver_credits)

    return response
