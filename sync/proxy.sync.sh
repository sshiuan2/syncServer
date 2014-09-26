#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit 2;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=192.200.109.235/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25565/g" $varPath

sed -i 's/^syncServerScpPath=.*$/syncServerScpPath=$syncServerPath/g' $varPath

sed -i 's/^session=.*$/session=proxy/g' $varPath
sed -i 's/^window=.*$/window=2/g' $varPath
sed -i 's/^pane=.*$/pane=2/g' $varPath
}
sync_conf_start(){
local to=$thisServerPath/start.sh
sed -i 's/Xmx=.*/Xmx=512M/g' $to
sed -i 's/$arg/-server/g' $to
}
sync_conf(){
local to=$thisServerPath/config.yml
local port=25565
sync_conf_start;
}
sync_scp(){
scp_getControllers;
scp_getServer proxy;
scp_getServer icon;

scp_getPlugin BungeeSuite;
scp_getPlugin VanillaPod;
}
main(){
sync_var;
source_all;

msg_startSync;

purge_plugins all;
purge_logs;

sync_scp;
sync_conf;

msg_endSync;
}
main
