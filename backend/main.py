from fastapi import Depends, FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from sqlalchemy import select
from sqlalchemy.orm import Session
import os

from backend.database import get_db
from backend.models import GraduationRule, RuleCondition, WaiverLimitRule, Course, Department, Category
from backend.schemas import Request, Response

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# 掛載靜態檔案 (圖片等)
# 這樣存取 /static/下載.png 就會對應到 frontend/下載.png
app.mount("/static", StaticFiles(directory="frontend"), name="static")

@app.get("/")
def read_root():
    # 直接回傳前端 index.html
    return FileResponse("frontend/index.html")

@app.get("/下載.png")
def get_logo():
    # 確保圖片在根目錄也能被抓到
    return FileResponse("frontend/下載.png")

@app.post("/api/check", response_model=Response)
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
    
    total_passed_all = 0 # 用來儲存絕對總學分 (應為 137)

    for condition in conditions:
        min_credits = condition.min_credits
        if min_credits is None:
            min_credits = condition.min_courses
        response[condition.category_id] = [0, min_credits]

    # 將課程分類並統計學分
    for course in courses:
        # ... (前方的過濾邏輯保持不變)
        code = course.get("courseCode")
        remark = course.get("remark")
        score_val = course.get("score")
        
        if score_val in ["停修", "不通過", "不及格", "W", "成績未到或無成績", "尚未有成績"]:
            continue
        try:
            score_num = float(score_val)
            if score_num < 60: continue
        except:
            if "未到" in str(score_val) or "無成績" in str(score_val): continue
        
        credits = int(float(course.get("credit")))
        total_passed_all += credits # 只要及格，就計入畢業總學分

        # 1. 體育判定
        if code.startswith("002"):
            response["pe"][0] += 1
        # 2. 中文判定
        elif code.startswith("031"):
            response["ge_ch"][0] += credits
        # 3. 外語判定
        elif code.startswith("032"):
            response["ge_fl"][0] += credits
        # 4. 書院通識判定
        elif code.startswith("045"):
            response["ge_rc"][0] += credits
        # 5. 資訊通識判定 (雙重保險：代碼 046 或 備註包含「資訊通」)
        elif code.startswith("046") or (remark and "資訊通" in remark):
            response["ge_it"][0] += credits
        # 6. 人文/社會/自然判定 (從備註字樣抓取)
        elif remark and "人文" in remark:
            response["ge_hum"][0] += credits
        elif remark and "社會" in remark:
            response["ge_soc"][0] += credits
        elif remark and "自然" in remark:
            response["ge_nat"][0] += credits
        # 7. 必修/選修判定
        else:
            found = False
            for required_course in required_courses:
                if code[:6] == required_course.course_id[:6]:
                    response[required_course.category_id][0] += credits
                    found = True
                    break
            if not found:
                response["elec"][0] += credits

    # 處理學分上限 (僅用於顯示該類別是否達成)
    for condition in conditions:
        category = condition.category_id
        if category == "pe":
            response["pe"][0] = min(response["pe"][0], 4)
        else:
            max_credits = condition.max_credits
            
            if category.startswith("ge_"):
                if max_credits:
                    response[category][1] = max_credits
                # 統計通識總分時才截斷上限
                single_ge_capped = min(response[category][0], max_credits) if max_credits else response[category][0]
                response["total_ge"][0] += single_ge_capped

    # 通識總計截斷
    response["total_ge"][0] = min(response["total_ge"][0], rule.total_ge_credits)

    # 畢業總學分採用「絕對加總」，確保數據為 137
    response["total"][0] = total_passed_all
    
    # 加上抵免學分
    if transfer_grade >= 1:
        response["total"][0] += min(waiver_credits, max_waiver_credits)

    # 計算還需學分與是否通過 (針對不同類別給予不同判斷)
    final_response = {}
    for key, val in response.items():
        current = val[0]
        threshold = val[1]
        
        if key == "elec":
            # 選修：不判斷是否達成，顯示已修
            final_response[key] = (current, 0, 0, None)
        elif key.startswith("ge_"):
            # 通識：計算尚可修習 (上限 - 已修)
            remaining_to_max = max(0, threshold - current)
            final_response[key] = (current, threshold, remaining_to_max, None)
        else:
            # 其他：計算還需 (門檻 - 已修)
            need = max(0, threshold - current)
            is_ok = current >= threshold
            final_response[key] = (current, threshold, need, is_ok)

    return final_response
