#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.1/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25566/g" $varPath
sed -i "s/^thisWorldName=.*$/thisWorldName=\"auth\"/g" $varPath

sed -i 's/^session=.*$/session=mc1/g' $varPath
sed -i 's/^window=.*$/window=1/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_world_clean(){
cd $thisServerPath/$thisWorldName
./rm.sh;
#ln -s /dev/null $thisWorldName/players
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=.*$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=.*$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=.*$/server-name=$thisServerName/g" $to
sed -i 's/^max-players=.*$/max-players=10/g' $to
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
