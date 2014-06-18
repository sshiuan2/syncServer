#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.3/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25565/g" $varPath

#sed -i "s/^thisWorldName=.*$/thisWorldName=\"trade\"/g" $varPath
#sed -i "s/^thisWorldName=.*$/thisWorldName=\"Qwhite\"/g" $varPath
sed -i "s/^thisWorldName=.*$/thisWorldName=\"moha\"/g" $varPath

sed -i 's/^session=.*$/session=mc3/g' $varPath
sed -i 's/^window=.*$/window=1/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=$/server-name=up9cloud - $thisWorldName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

#sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
#sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to
#sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to

sed -i 's/^gamemode=.*$/gamemode=1/g' $to

sed -i 's/^max-players=.*$/max-players=5/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=100000/g' $to

sed -i 's/^white-list=.*$/white-list=true/g' $to

sync_conf_start;
sync_conf_op;
}
sync_conf_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=512M/g' $to
}
sync_conf_op(){
local f="$thisServerPath/ops.json"
local ops=(
"sp-bonebonekai"
"O0oO0o0Oo0O"
)
local op;
local args=();
for op in ${ops[@]};do
args+=(`buildOpData "$op"`);
done;
local arg;
for arg in ${args[@]};do
echo $arg;
cat $f|$varDir/jq ". + $arg" > $f;
done;
}
sync_scp(){
scp_getControllers;
scp_getServer spigot;

local plugins=(
SuperCensor
VariableTriggers
BungeeSuiteWarps
#TeleportSigns
ChatColors
PermissionsEx
#Vault
#iConomy
WorldEdit
dynmap
)
local p
for p in ${plugins[@]};do
scp_getPlugin $p;
done
}
main(){
sync_var;
source_all;

msg_startSync;

purge_plugins all;

sync_scp;
sync_conf;

msg_endSync;
}
main
