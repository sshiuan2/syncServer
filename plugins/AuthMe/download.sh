#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name="AuthMe"
local from=$syncServerScpPath/plugins/$name
local to=$thisServerPath/plugins/$name

scp -r $from/* $to
}
main
