#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='Essentials'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
local backup_fs=(
jail.yml

)
mkdir -p $from/$thisServerName
local backup_f;
for backup_f in ${backup_fs[@]};do
cp $from/$backup_f $from/$thisServerName
done
scp -r $from/$thisServerName $to
}

main
