from typing import Any, Dict, List
from pydantic import BaseModel

#前端傳送的資料格式
class Request(BaseModel):
    entry_year: str         #入學年度
    transfer_grade: int = 0 #轉入年級
    waiver_credits: int = 0 #抵免學分
    courses: List[Dict[str, Any]] #課業學習JSON

#後端回傳的資料格式，每個陣列有兩個值，第一個為已修的學分數，第二個為要求的最低學分數
class Response(BaseModel):
    total:      List[int]
    total_ge:   List[int]
    c_c_e:      List[int]
    c_req:      List[int]
    d_c_e:      List[int]
    d_req:      List[int]
    ge_ch:      List[int]
    ge_fl:      List[int]
    ge_hum:     List[int]
    ge_it:      List[int]
    ge_nat:     List[int]
    ge_rc:      List[int]
    ge_soc:     List[int]
    pe:         List[int]