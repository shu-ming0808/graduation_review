from typing import Any, Dict
from pydantic import BaseModel

#前端傳送的資料格式
class Request(BaseModel):
    entry_year: str         #入學年度
    transfer_grade: int = 0 #轉入年級
    waiver_credits: int = 0 #抵免學分
    courses: Dict[str, Any] #課業學習JSON

#後端回傳的資料格式
class Response(BaseModel):
    pass