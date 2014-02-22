#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=192.200.109.235/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25566/g" $varPath

sed -i 's/^syncServerScpPath=.*$/syncServerScpPath=$syncServerPath/g' $varPath

sed -i 's/^session=.*$/session=proxy/g' $varPath
sed -i 's/^window=.*$/window=2/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xmx=.*/Xmx=768M/g' $to
sed -i 's/$arg/-server/g' $to
}
sync_conf(){
local to=$thisServerPath/config.yml
local port=25566
sed -i 's/^stats:.*$/stats: 48722903-7477-4339-ac76-31e4dc5c9466/g' $to
sed -i '/^permissions:.*$/{n;n;d}' $to
sed -i 's/^- fallback_server:.*$/- fallback_server: auth/g' $to
sed -i "s/^  host:.*$/\  host: $thisServerIp:$port/g" $to
sed -i 's/^  query_port:.*$/\  query_port: 25578/g' $to
sed -i 's/^  default_server:.*$/\  default_server: auth/g' $to
sed -i 's/^online_mode:.*$/online_mode: false/g' $to
}
sync_var;
source_all;

purge_plugins all;
purge_logs

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer proxy;
sync_conf;
scp_getServer icon;

scp_getPlugin BungeeSuite;
msg_endSync;
