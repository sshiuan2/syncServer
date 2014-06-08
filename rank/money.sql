SET @id=0;
SET @max=(SELECT MAX(`balance`) FROM `iConomy`.`iConomy`);
SELECT @id := @id +1 AS money_id,t2.`user`,ROUND(t1.`balance`/@max*10000) AS money
FROM `iConomy`.`iConomy` AS t1
INNER JOIN `mcmmo`.`mcmmo_users` AS t2
WHERE t1.`username` NOT LIKE 'up9cloud%'
AND t1.`username`=t2.`user`
ORDER BY t1.`balance` DESC
LIMIT 10
