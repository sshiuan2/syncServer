#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.1/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25567/g" $varPath
#sed -i "s/^thisWorldName=.*$/thisWorldName=\"創造\"/g" $varPath

sed -i 's/^session=.*$/session=mc1/g' $varPath
sed -i 's/^window=.*$/window=0/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=.*$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=.*$/server-port=$thisServerPort/g" $to
sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i "s/^server-name=$/server-name=up9cloud - $thisServerName/g" $to

sed -i 's/^allow-flight=.*$/allow-flight=true/g' $to
sed -i 's/^gamemode=.*$/gamemode=1/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=0/g' $to
sed -i 's/^max-players=.*$/max-players=10/g' $to
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=1G/g' $to
}
sync_var;
source_all;

purge_plugins all;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer spigot;
sync_conf;

scp_getPlugin PlotMe;
scp_getPlugin VariableTriggers;
scp_getPlugin BungeeSuiteWarps;

scp_getPlugin TeleportSigns;

scp_getPlugin dynmap;
scp_getPlugin DynmapPlotMe;

scp_getPlugin ChatColors;
scp_getPlugin PermissionsEx;
scp_getPlugin Vault;
scp_getPlugin iConomy;
scp_getPlugin WorldBorder;
scp_getPlugin WorldEdit;
msg_endSync;
