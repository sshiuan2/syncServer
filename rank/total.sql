USE `mcmmo`;
SET @id=0;
SELECT @id := @id +1 AS id,t1.`user`,
(
t2.`taming` + t2.`mining` + t2.`woodcutting` + t2.`repair` + t2.`unarmed` + t2.`herbalism` + t2.`excavation` + t2.`archery` + t2.`swords` + t2.`axes` + t2.`acrobatics` + t2.`fishing` + t2.`alchemy` + 0) AS total
FROM `mcmmo_users` AS t1
INNER JOIN `mcmmo_skills` AS t2
WHERE t1.`id`=t2.`user_id`
ORDER BY total DESC
LIMIT 10
