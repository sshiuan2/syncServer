#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

source $varDir/tmux.sh

main(){
local delay=30
tmux_sendkey_restart "$session:$window.$pane" $delay;
}
main
