#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='Residence'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
local fs=(
download.sh
upload.sh
Language/zh_TW.yml
config.yml
)
local f;
for f in ${fs[@]};do
scp $from/$f $to
done
}
main
