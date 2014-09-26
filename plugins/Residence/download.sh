#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name="Residence"
local from=$syncServerScpPath/plugins/$name
local to=$thisServerPath/plugins/$name
local fs=(
upload.sh
download.sh
config.yml
Language/zh_TW.yml
)
local f;
for f in ${fs[@]};do
scp -r $from/$f $to
done
}
main
