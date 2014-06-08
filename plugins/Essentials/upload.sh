#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='Essentials'
local f=jail.yml
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
mkdir -p $from/$thisServerName
cp $from/$f $from/$thisServerName

scp -r $from/$thisServerName $to

scp $from/*.sh $to
}

main $name
