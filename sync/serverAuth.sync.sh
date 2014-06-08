#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
declare -A sync_var=()
sync_var[thisServerIp]="10.0.0.1"
sync_var[thisServerPort]="25566"
sync_var[thisWorldName]="auth"
sync_var[session]="mc1"
sync_var[window]="1"
sync_var[pane]="0"
local k
for k in "${!sync_var[@]}";do
sed -i "s/^$k=.*$/$k=${sync_var[$k]}/g" $varPath
done
}
sync_world_clean(){
cd $thisServerPath/$thisWorldName
./rm.sh;
#ln -s /dev/null $thisWorldName/players
}
sync_conf(){
local to=$thisServerPath/server.properties
declare -A sync_conf=()
sync_conf[level-name]="$thisWorldName"
sync_conf[server-port]="$thisServerPort"
sync_conf[server-name]="$thisServerName"
sync_conf[max-players]="10"
local k
for k in "${!sync_conf[@]}";do
sed -i "s/^$k=.*$/$k=${sync_conf[$k]}/g" $to
done
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=256M/g' $to
}
sync_var;
source_all;

sync_world_clean;
purge_plugins all;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer spigot;
sync_conf;

scp_getPlugin VariableTriggers;
scp_getPlugin BungeeSuitePortals;
scp_getPlugin BungeeSuiteWarps
scp_getPlugin PermissionsEx;
scp_getPlugin AuthMe;

scp_getPlugin TeleportSigns;

#scp_getPlugin WorldEdit;
msg_endSync
