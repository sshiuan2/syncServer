#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='IslandWorld'
local path=$thisServerPath/plugins/$name
scp -r $path/schematics $syncServerScpPath/plugins/$name
scp $path/*.yml $syncServerScpPath/plugins/$name
scp $path/*.sh $syncServerScpPath/plugins/$name
scp $path/*.xml $syncServerScpPath/plugins/$name
$path/backup.sh
}
main
