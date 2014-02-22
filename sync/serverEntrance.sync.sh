#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.1/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25565/g" $varPath
sed -i "s/^thisWorldName=.*$/thisWorldName=\"天界\"/g" $varPath

sed -i 's/^session=.*$/session=mc1/g' $varPath
sed -i 's/^window=.*$/window=2/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i 's/^level-name=.*$/level-name=\\u5929\\u754C/g' $to
sed -i 's/^allow-flight=.*$/allow-flight=true/g' $to
sed -i "s/^server-port=.*$/server-port=$thisServerPort/g" $to
sed -i 's/^server-name=.*$/server-name=up9cloud Server/g' $to
sed -i 's/^max-players=.*$/max-players=100/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=1000/g' $to

#sed -i 's/^enable-query=.*$/enable-query=true/g' $to
#sed -i "s/^query.port=.*$/query.port=$thisServerPort/g" $to
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=512M/g' $to
}
sync_var;
source_all;

purge_plugins all;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer spigot;
sync_conf;

scp_getPlugin VariableTriggers;
scp_getPlugin BungeeSuiteBans;
scp_getPlugin BungeeSuitePortals;
scp_getPlugin BungeeSuiteWarps;
scp_getPlugin TeleportSigns;

scp_getPlugin PermissionsEx;

scp_getPlugin WorldBorder
scp_getPlugin WorldEdit;
msg_endSync
