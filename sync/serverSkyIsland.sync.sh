#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.2/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25565/g" $varPath
sed -i "s/^thisWorldName=.*$/thisWorldName=\"world\"/g" $varPath

sed -i 's/^session=.*$/session=mc2/g' $varPath
sed -i 's/^window=.*$/window=0/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
sed -i 's/^server-name=$/server-name=$thisServerName/g' $to
sed -i 's/^max-players=.*$/max-players=20/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to
sed -i 's/^generate-structures=.*$/generate-structures=true/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=40/g' $to
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=512M/g' $to
}
sync_IslandWorld(){
local to=$thisServerPath/plugins/IslandWorld/config.yml
sed -i "s/^world-isle=.*$/world-isle=$thisWorldName/g" $to
sed -i "s/^world-spawn=.*$/world-spawn=$thisWorldName/g" $to
}
$thisServerPath/plugins/IslandWorld/backup.sh

sync_var;
source_all;

purge_plugins all;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer spigot;
sync_conf;

scp_getPlugin VariableTriggers;
scp_getPlugin TeleportSigns;
scp_getPlugin BungeeSuiteWarps;
scp_getPlugin SuperCensor;

scp_getPlugin IslandWorld; #must need world edit
sync_IslandWorld;
scp_getPlugin WorldEdit;

scp_getPlugin PermissionsEx;
#scp_getPlugin Essencials;
scp_getPlugin ChatColors;
scp_getPlugin Vault;
scp_getPlugin iConomy;
#scp_getPlugin mcMMO #MCMMO 2server共用db會回碩 bug 待修復...
scp_getPlugin KillerMoney;
scp_getPlugin HealthBar;
#scp_getPlugin AutoSaveWorld;
#scp_getPlugin WorldBorder;
msg_endSync;
