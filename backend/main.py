from fastapi import FastAPI
from sqlalchemy import select

from .database import get_db
from .models import *
from .schemas import Request, Response

app = FastAPI()

@app.post("/", response_model=Response)
def graduation_review(data: Request):

    db = get_db()

    pass

    return {}