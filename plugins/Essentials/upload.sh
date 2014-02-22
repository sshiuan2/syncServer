#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='Essentials'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
mv $from/userdata $from/$thisServerName.userdata
scp -r $from/$thisServerName.userdata $to
mv $from/$thisServerName.userdata $from/userdata

scp $from/*.sh $to
}
main
