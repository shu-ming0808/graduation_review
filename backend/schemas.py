from typing import Any, Dict, List, Optional, Tuple
from pydantic import BaseModel

#前端傳送的資料格式
class Request(BaseModel):
    entry_year: str         #入學年度
    transfer_grade: int = 0 #轉入年級
    waiver_credits: int = 0 #抵免學分
    courses: List[Dict[str, Any]] #課業學習JSON

#後端回傳的資料格式，每個陣列有四個值
#第一個為已修的學分數，第二個為要求的最低學分數，第三個為還需學分數，第四個為是否通過(可為空)
class Response(BaseModel):
    total:      Tuple[int, int, int, Optional[bool]]
    total_ge:   Tuple[int, int, int, Optional[bool]]
    elec:       Tuple[int, int, int, Optional[bool]]
    c_c_e:      Tuple[int, int, int, Optional[bool]]
    c_req:      Tuple[int, int, int, Optional[bool]]
    d_c_e:      Tuple[int, int, int, Optional[bool]]
    d_req:      Tuple[int, int, int, Optional[bool]]
    ge_ch:      Tuple[int, int, int, Optional[bool]]
    ge_fl:      Tuple[int, int, int, Optional[bool]]
    ge_hum:     Tuple[int, int, int, Optional[bool]]
    ge_it:      Tuple[int, int, int, Optional[bool]]
    ge_nat:     Tuple[int, int, int, Optional[bool]]
    ge_rc:      Tuple[int, int, int, Optional[bool]]
    ge_soc:     Tuple[int, int, int, Optional[bool]]
    pe:         Tuple[int, int, int, Optional[bool]]