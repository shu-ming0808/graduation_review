簡介
- 後端以 FastAPI + SQLAlchemy 建構，提供一個 POST API 來檢核學生修課資料是否符合畢業規則。

檔案說明
- `database.py`：建立 SQLAlchemy 引擎與 `SessionLocal`，並提供 `get_db()` 供依賴注入使用。DB 設定由環境變數讀取（`DB_HOST`、`DB_PORT`、`DB_USER`、`DB_PASSWORD`、`DB_NAME`）。
- `models.py`：使用 `automap_base()` 自動映射資料庫表成 ORM 類別（例如 `Course`、`GraduationRule`、`RuleCondition` 等）。
- `schemas.py`：使用 Pydantic 定義輸入 (`Request`) 與輸出 (`Response`) 的資料模型，方便驗證與文件化。
- `main.py`：FastAPI 應用程式，實作一個 `POST /` 路由，接收前端提供的修課 JSON，查資料庫並回傳各類別已修學分與需求下限。

資料庫與先備作業
1. 安裝 MySQL

2. 將 schema 與資料匯入（專案根目錄有 `schema_2.sql` 與 `data_2.sql`）

3. 修改資料庫連線資訊：
- 請複製專案根目錄的 `.env.example` 為 `.env`，再依照本機 MySQL 設定修改 `DB_HOST`、`DB_PORT`、`DB_USER`、`DB_PASSWORD`、`DB_NAME`。

安裝 Python 相依套件

```bash
pip install fastapi uvicorn sqlalchemy pymysql pydantic
```

啟動後端

```bash
# 在專案根目錄執行
uvicorn backend.main:app --reload
```

API 使用說明（前端如何互動）
- 路由：`POST /`（根目錄）
- 請求格式：JSON，符合 `Request` schema。主要欄位包含：
  - `entry_year` (string)
  - `transfer_grade` (int)：可沒有或填 0
  - `waiver_credits` (int)：可沒有或填 0
  - `courses` (array)：全人系統提供的 `課業學習` JSON檔案。

- 回傳格式：JSON，符合 `Response` schema。每個欄位為長度為 2 的陣列，第一個為已修學分、第二個為最低要求學分。

前端（fetch）範例

```javascript
fetch('http://localhost:8000/', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(payload)
})
  .then(r => r.json())
  .then(data => console.log(data))
