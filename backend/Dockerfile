FROM python:3.9-slim

WORKDIR /app

# 安裝基礎依賴，避免編譯錯誤
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# 預先安裝套件 (這部分之後不常變動)
RUN pip install --no-cache-dir fastapi uvicorn sqlalchemy pymysql pydantic

# 暴露埠號
EXPOSE 8000

# 啟動指令：注意這裡設定為 0.0.0.0 才能讓外面連進去
# 使用 --reload 讓你在外面改 code 裡面會自動更新
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
