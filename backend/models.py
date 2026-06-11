import time
import os
from sqlalchemy import inspect
from sqlalchemy.ext.automap import automap_base
from backend.database import engine

Base = automap_base()

def init_models():
    print(f"Attempting to connect to: {engine.url}")
    for i in range(15):  # 增加到 15 次
        try:
            # 嘗試反映資料庫
            Base.prepare(autoload_with=engine)
            
            # 列出發現的所有表格，方便偵錯
            inspector = inspect(engine)
            tables = inspector.get_table_names()
            print(f"Tables found in database: {tables}")
            
            if 'category' in Base.classes:
                print("Database tables reflected successfully!")
                return True
            else:
                print(f"Connection OK, but tables not found yet... ({i+1}/15)")
        except Exception as e:
            print(f"Database not ready or connection error: {e}")
            print(f"Retrying in 3 seconds... ({i+1}/15)")
        time.sleep(3)
    return False

# 初始化
success = init_models()

if not success:
    # 如果失敗了，我們至少不要讓整個 App 直接崩潰在啟動階段
    # 提供空類別避免 AttributeError
    class MockClass: pass
    Category = College = Course = CreditWaiver = Department = \
    GraduationRule = RuleCondition = WaiverLimitRule = MockClass
    print("CRITICAL: Failed to load models. API will not work correctly.")
else:
    # 映射表格類別
    Category = Base.classes.category
    College = Base.classes.college
    Course = Base.classes.course
    CreditWaiver = Base.classes.credit_waiver
    Department = Base.classes.department
    GraduationRule = Base.classes.graduation_rule
    RuleCondition = Base.classes.rule_condition
    WaiverLimitRule = Base.classes.waiver_limit_rule
