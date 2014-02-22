#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='Residence'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
#scp $from/upload.sh $to/upload.sh
}
main
