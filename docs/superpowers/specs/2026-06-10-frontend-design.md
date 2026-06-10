# 畢業學分檢核系統前端設計

## 概述
純前端網站，上傳學生 JSON 檔案後按學期顯示課程與成績。

## 功能

### 1. 檔案上傳
- 支援拖放或點擊選擇 `exportStudentData.json`
- 前端解析 JSON，不需後端

### 2. 學生資訊摘要
顯示：
- 姓名（中英文）
- 學號
- 系級
- 總修得學分

### 3. 學期卡片總覽
- 每個學期一張卡片
- 卡片內列出該學期所有課程
- 每門課顯示：課名、學分、成績

### 4. 成績標示
- 不及格（<60）：紅色
- 停修 / 成績未到：灰色
- 及格：正常顏色

## 技術
- 純 HTML + CSS + JavaScript
- 不使用任何框架
- 單一 `index.html` 檔案

## 資料結構
從 JSON 的 `課業學習.gradeRecordList` 取得學期與課程資料：
```
gradeRecordList[].AcademicYear + semester → 學期
gradeRecordList[].GradeRecords[] → 課程列表
  - courseName
  - credit
  - score
```
