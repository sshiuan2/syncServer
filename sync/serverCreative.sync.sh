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
#sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i "s/^server-name=$/server-name=up9cloud - $thisServerName/g" $to

sed -i 's/^allow-flight=.*$/allow-flight=true/g' $to
sed -i 's/^gamemode=.*$/gamemode=1/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=0/g' $to
sed -i 's/^max-players=.*$/max-players=10/g' $to

sync_conf_start
}
sync_conf_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=768M/g' $to
}
sync_scp(){
scp_getControllers;
scp_getServer spigot;

local plugins=(
PlotMe
VariableTriggers
BungeeSuiteWarps

TeleportSigns

dynmap
DynmapPlotMe

ChatColors
PermissionsEx
Vault
iConomy
WorldBorder
WorldEdit
)
local p
for p in ${plugins[@]};do
scp_getPlugin $p;
done
}
sync_killall(){
local i
#/butcher : Kills all hostile mobs
#/butcher -p : also kills pets.
#/butcher -n : also kills NPCs.
#/butcher -g : also kills Golems.
#/butcher -a : also kills animals.
#/butcher -f : compounds all previous flags.
#/butcher -l : strikes lightning on each killed mob.
}
main(){
sync_var;
source_all;

purge_plugins all;

msg_startSync;
sync_scp;
sync_conf;
msg_endSync;
}
main
