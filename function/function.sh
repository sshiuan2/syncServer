#!/bin/bash
f1ge2(){
	local a=$1;
		local b=$2;
	echo -n "float compare: ";
	echo -n "$1 >= $2 ? ";
	if [ "${a}" == "" -a "${b}" == "" ];then
		return 2;
	fi;
	local len_a=${#a};
	local len_b=${#b};
	if [ $len_a -gt $len_b ];then
		b=${b}`f_fill $(( $len_a - $len_b ))`;
	else
		a=${a}`f_fill $(( $len_b - $len_a ))`;
	fi;
	a=`echo $a | sed 's/\.//'`;
	b=`echo $b | sed 's/\.//'`;
	if [ $a -ge $b ];then
		echo true;return 0;
	else
		echo false;return 1;
	fi;
}
f_fill(){
	local i=$1;
	local zero;
	while (( $i != 0 ));do
		zero=${zero}0;
	((i--));
	done;
	echo $zero;
}
check_os(){
	local todo;
	echo check_os todo;
}
JSON_buildSingleObject(){
local attr=$1;
local value=$2;
echo "{\"$attr\":\"$value\"}";
}
buildOpData(){
local name=$1
echo "[{\"name\":\"$name\",\"uuid\":\"\",\"level\":\"4\"}]";
}
