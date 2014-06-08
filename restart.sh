#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

source $varDir/tmux.sh

main(){
local target="$session:$window.$pane"
local delay
local type=$1
if [ "$type" == "proxy" ];then
delay=10
else
delay=30
fi
tmux_sendkey_restart $target $delay $type;
}
main $@
