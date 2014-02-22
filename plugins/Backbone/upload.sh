#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='Backbone'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
echo "scp to: $to"
scp $from/config.yml $to/$thisServerName.config.yml
scp $from/upload.sh $to/upload.sh
}
main
