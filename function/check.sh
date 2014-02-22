#!/bin/bash
function yesOrExit() {
case $1 in
  y|Y|YES|yes|Yes) ;;
  n|N|no|NO|No) echo "exit"
  exit ;;
  *) echo "input is wrong, exit the shell"
  exit ;;
esac
}
checkConfirm() {
case $1 in
  y|Y|YES|yes|Yes) echo true;;
  n|N|no|NO|No) echo false;;
  *) echo "convert is wrong, exit the shell"
  exit ;;
esac
}
checkWorldNether(){
echo "開始檢查 $thisWorldNameNether 是否需要重置"
if [ -d $thisWorldName/DIM-1 ];then
checkWorldNether_vanilla $1
elif [ -f $thisWorldNameNether/uid.dat ];then
checkWorldNether_bukkit $1
else
echo "Nether 不存在 ...pass"
fi
}
checkWorldNether_vanilla(){
local to=$thisServerPath/$thisWorldName/DIM-1
local netherTime=`stat -c %Y $to`
local now=`date +%s`
if (( $[$now - $netherTime] > $1 )); then
rm -fr $to
echo "$to 存活 $[$now - $netherTime] 秒，超過限制已被刪除"
else
echo "$to 存活 $[$now - $netherTime] 秒，沒超過限制不需重置"
fi
}
checkWorldNether_bukkit(){
local to=$thisServerPath/$thisWorldNameNether
local netherTime=`stat -c %Y $to/uid.dat`
local now=`date +%s`
if (( $[$now - $netherTime] > $1 )); then
rm -fr $to
echo "$to 存活 $[$now - $netherTime] 秒，超過限制已被刪除"
else
echo "$to 存活 $[$now - $netherTime] 秒，沒超過限制不需重置"
fi
}
