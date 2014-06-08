USE `information_schema`;
SELECT COLUMN_NAME
FROM COLUMNS
WHERE TABLE_SCHEMA='mcmmo'
AND TABLE_NAME='mcmmo_skills'
AND COLUMN_NAME!='user_id';
