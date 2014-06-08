#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
file="$DIR/rank_functions.sh"
if [ -f $file ];then source $file;
else echo "source $file failed!";exit 2;fi

host=$databaseIp
user=rank
password=knar

generate_sql_skills
get_skills

for s in $skills;do
generate_sql_skill $s
generate_xml $DIR/$s.sql
done

generate_sql_skill_total
generate_xml $DIR/total.sql

generate_sql_money
generate_xml $DIR/money.sql
