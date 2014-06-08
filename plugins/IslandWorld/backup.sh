#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='IslandWorld'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
mkdir -p $from/$thisServerName
cp -f $from/compChallenges.dat $from/$thisServerName
#cp -f $from/freelistV6.dat $from/$thisServerName
cp -f $from/islelistV6.dat $from/$thisServerName
scp -r $from/$thisServerName $to
}
main
