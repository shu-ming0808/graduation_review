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

    # 查詢入學年對應規則
    stmt = select(GraduationRule).where(GraduationRule.entry_year == entry_year)
    rule = db.scalars(stmt).one_or_none()

    # 查詢規則中所有條件
    stmt = select(RuleCondition).where(RuleCondition.rule_id == rule.rule_id)
    conditions = db.scalars(stmt).all()

    # 若是轉系生，查詢抵免最高學分限制
    if transfer_grade >= 1:
        stmt = select(WaiverLimitRule.max_waiver_credits).where(
            WaiverLimitRule.transfer_entry_level == transfer_grade
        )
        max_waiver_credits = db.scalars(stmt).one_or_none()

    # 從JSON中取得已修課程
    courses = []
    for year in data.courses[0].get("課業學習").get("gradeRecordList"):
        for course in year.get("GradeRecords"):
            courses.append(course)

    # 查詢必修與群修課程資訊
    required_categories = ["c_c_e", "c_req", "d_c_e", "d_req"]
    stmt = select(Course).where(Course.category_id.in_(required_categories))
    required_courses = db.scalars(stmt).all()

    # 查詢課程類別
    stmt = select(Category.category_id)
    categories = db.scalars(stmt).all()

    # 填入各類別最低學分數
    response = {
        "total": [0, rule.total_credits_min],
        "total_ge": [0, rule.total_ge_credits],
        "elec": [0, 0],
    }
    for condition in conditions:
        min_credits = condition.min_credits
        if min_credits is None:
            min_credits = condition.min_courses
        response[condition.category_id] = [0, min_credits]

    # 將課程分類並統計學分
    for course in courses:
        code = course.get("courseCode")
        remark = course.get("remark")
        credits = int(float(course.get("credit")))
        if code.startswith("002"):
            response["pe"][0] += credits
        elif code.startswith("031"):
            response["ge_ch"][0] += credits
        elif code.startswith("032"):
            response["ge_fl"][0] += credits
        elif code.startswith("045"):
            response["ge_rc"][0] += credits
        elif code.startswith("046"):
            response["ge_it"][0] += credits
        elif remark.startswith("人文"):
            response["ge_hum"][0] += credits
        elif remark.startswith("社會"):
            response["ge_soc"][0] += credits
        elif remark.startswith("自然"):
            response["ge_nat"][0] += credits
        else:
            found = False
            for required_course in required_courses:
                if code[:6] == required_course.course_id[:6]:
                    response[required_course.category_id][0] += credits
                    found = True
                    break
            if not found:
                response["elec"][0] += credits

    # 將超過學分上限的類別改為學分上限，並統計通識總學分
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
    response["total_ge"][0] = min(response["total_ge"])

    # 統計總學分
    for category in categories:
        if not category.startswith("ge_"):
            response["total"][0] += response[category][0]
    response["total"][0] += response["total_ge"][0]
    # 加上抵免學分
    if transfer_grade >= 1:
        response["total"][0] += min(waiver_credits, max_waiver_credits)

    # 計算還需學分與是否通過
    for list in response.values():
        list.append(list[1] - list[0])
        if list[2] <= 0:
            list[2] = 0
            list.append(True)
        else:
            list.append(False)

    return response
