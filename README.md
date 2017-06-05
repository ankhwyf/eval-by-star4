# 教师考核平台

## MongoDB配置

```bash
mongoimport --db eval --collection auditor --drop --file mongodb/auditor.json
mongoimport --db eval --collection college_admin --drop --file mongodb/college_admin.json
mongoimport --db eval --collection eval_admin --drop --file mongodb/eval_admin.json
mongoimport --db eval --collection teacher --drop --file mongodb/teacher.json
```
