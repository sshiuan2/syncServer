#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='EpicBossRecoded'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
$from/backup.sh
#scp $from/Bosses.yml $to/Bosses.yml
#scp $from/*.sh $to
scp -r $from/$thisServerName $to
}
main
