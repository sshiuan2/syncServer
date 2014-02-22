#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/../../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local pluginName='WorldEdit'
local path=$thisServerPath/plugins/$pluginName/schematics

scp -r $syncServerScpPath/plugins/$pluginName/schematics $path/..
}
main
