USE `mcmmo`;
SET @id=0;
SELECT @id := @id +1 AS id,t1.`user`,t2.`unarmed` AS level
FROM `mcmmo_users` AS t1
INNER JOIN `mcmmo_skills` AS t2
WHERE t2.`unarmed`>0
AND t1.`id`=t2.`user_id`
ORDER BY t2.`unarmed` DESC
LIMIT 10
