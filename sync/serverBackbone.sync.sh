#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
declare -A sync_var=()
sync_var[thisServerIp]="10.0.0.2"
sync_var[thisServerPort]="25567"
sync_var[thisWorldName]="pvp"
sync_var[session]="mc2"
sync_var[window]="2"
sync_var[pane]="0"
local i
for i in "${!sync_var[@]}";do
sed -i "s/^$i=.*$/$i=${sync_var[$i]}/g" $varPath
done
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i 's/^allow-nether=.*$/allow-nether=false/g' $to
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i 's/^spawn-npcs=.*$/spawn-npcs=false/g' $to
sed -i 's/^spawn-animals=.*$/spawn-animals=false/g' $to
sed -i 's/^pvp=.*$/pvp=true/g' $to
sed -i "s/^server-name=$/server-name=$thisServerName/g" $to
sed -i 's/^max-players=.*$/max-players=6/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=false/g' $to
sed -i 's/^generate-structures=.*$/generate-structures=false/g' $to
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
scp_getPlugin BungeeSuiteWarps;
scp_getPlugin Backbone;
scp_getPlugin TeleportSigns;

scp_getPlugin PermissionsEx
scp_getPlugin ChatColors
scp_getPlugin Vault
scp_getPlugin iConomy
scp_getPlugin KillerMoney;
scp_getPlugin HealthBar;
#scp_getPlugin WorldBorder;
#scp_getPlugin WorldEdit;
msg_endSync;
