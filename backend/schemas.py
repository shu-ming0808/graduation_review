from typing import Any, Dict, List
from pydantic import BaseModel

#前端傳送的資料格式
class Request(BaseModel):
    entry_year: str         #入學年度
    transfer_grade: int = 0 #轉入年級
    waiver_credits: int = 0 #抵免學分
    courses: List[Dict[str, Any]] #課業學習JSON

#後端回傳的資料格式，每個陣列有四個值
#第一個為已修的學分數，第二個為要求的最低學分數，第三個為還需學分數，第四個為是否通過
class Response(BaseModel):
    total:      tuple[int, int, int, bool]
    total_ge:   tuple[int, int, int, bool]
    elec:       tuple[int, int, int, bool]
    c_c_e:      tuple[int, int, int, bool]
    c_req:      tuple[int, int, int, bool]
    d_c_e:      tuple[int, int, int, bool]
    d_req:      tuple[int, int, int, bool]
    ge_ch:      tuple[int, int, int, bool]
    ge_fl:      tuple[int, int, int, bool]
    ge_hum:     tuple[int, int, int, bool]
    ge_it:      tuple[int, int, int, bool]
    ge_nat:     tuple[int, int, int, bool]
    ge_rc:      tuple[int, int, int, bool]
    ge_soc:     tuple[int, int, int, bool]
    pe:         tuple[int, int, int, bool]