#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='EpicBossRecoded'
local from=$thisServerPath/plugins/$name
local to=$from
mkdir -p $from/$thisServerPath
cp -f $from/SavedData.yml $to/$thisServerName/SavedData.yml
cp -f $from/Spawning.yml $to/$thisServerName.Spawning.yml
}
main
