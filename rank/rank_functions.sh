#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
varPath="$DIR/../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit 2;fi

generate_sql_skills(){
local f=$DIR/${FUNCNAME: -6}.sql
local dbname='information_schema'
local skill_db_name='mcmmo'
local skill_tbl_name="mcmmo_skills"
cat >$f <<EOL
USE \`$dbname\`;
SELECT COLUMN_NAME
FROM COLUMNS
WHERE TABLE_SCHEMA='$skill_db_name'
AND TABLE_NAME='$skill_tbl_name'
AND COLUMN_NAME!='user_id';
EOL
}

get_skills(){
query=$(<$DIR/${FUNCNAME: -6}.sql)
skills=$(mysql -h$host -u$user -p$password -se"$query")
}

generate_sql_skill(){
local file=$DIR/$1.sql
local skill=$1
local skill_db_name=mcmmo
local user_tbl_name=mcmmo_users
local skill_tbl_name=mcmmo_skills
local limit=10

cat >$file <<EOL
USE \`$skill_db_name\`;
SET @id=0;
SELECT @id := @id +1 AS id,t1.\`user\`,t2.\`$skill\` AS level
FROM \`$user_tbl_name\` AS t1
INNER JOIN \`$skill_tbl_name\` AS t2
WHERE t2.\`$skill\`>0
AND t1.\`id\`=t2.\`user_id\`
ORDER BY t2.\`$skill\` DESC
LIMIT $limit
EOL
}

generate_sql_skill_total(){
local file=$DIR/${FUNCNAME: -5}.sql
local skill_db_name=mcmmo
local user_tbl_name=mcmmo_users
local skill_tbl_name=mcmmo_skills
local limit=10

cat >$file <<EOL
USE \`$skill_db_name\`;
SET @id=0;
SELECT @id := @id +1 AS id,t1.\`user\`,
(
EOL

local s
for s in $skills;do
echo -n "t2.\`$s\` + " >>$file
done

cat >>$file <<EOL
0) AS total
FROM \`$user_tbl_name\` AS t1
INNER JOIN \`$skill_tbl_name\` AS t2
WHERE t1.\`id\`=t2.\`user_id\`
ORDER BY total DESC
LIMIT $limit
EOL
}

generate_sql_money(){
local f=$DIR/${FUNCNAME: -5}.sql
local db1='iConomy'
local t1="iConomy"
local db2='mcmmo'
local t2='mcmmo_users'
local except='up9cloud%'
cat >$f <<EOL
SET @id=0;
SET @max=(SELECT MAX(\`balance\`) FROM \`$db1\`.\`$t1\`);
SELECT @id := @id +1 AS money_id,t2.\`user\`,ROUND(t1.\`balance\`/@max*10000) AS money
FROM \`$db1\`.\`$t1\` AS t1
INNER JOIN \`$db2\`.\`$t2\` AS t2
WHERE t1.\`username\` NOT LIKE '$except'
AND t1.\`username\`=t2.\`user\`
ORDER BY t1.\`balance\` DESC
LIMIT 10
EOL
}

generate_xml(){
local query=$(<$1)
local to="/var/www/public/rank"
local fname=$(basename $1)
local f="$to/${fname%.*}.xml"
if [ ! -d $to ];then
mkdir -p $to && chown www-data:www-data $to
fi
mysql -h$host -u$user -p$password -se"$query" -X > $f

#remvoe statement content
sed -i '/<resultset /,/>/ {s/>/>\n<resultset>/}' $f
sed -i "/<resultset /,/>/ {s/.*//g}" $f
}
