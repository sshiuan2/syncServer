#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name=VariableTriggers
local from="$thisServerPath/plugins/$name"
local to=$from/$thisServerName
mkdir -p $to
cp -f $from/vardata.yml $to
}
main
