USE `mcmmo`;
SET @id=0;
SELECT @id := @id +1 AS id,t1.`user`,t2.`herbalism` AS level
FROM `mcmmo_users` AS t1
INNER JOIN `mcmmo_skills` AS t2
WHERE t2.`herbalism`>0
AND t1.`id`=t2.`user_id`
ORDER BY t2.`herbalism` DESC
LIMIT 10
