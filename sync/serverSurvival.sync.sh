#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.200/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25565/g" $varPath

sed -i 's/^session=.*$/session=mcmain/g' $varPath
sed -i 's/^window=.*$/window=1/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf_ban(){
local to=$thisServerPath/banned-ips.json
#echo "112.171.53.194" >> $to
#echo "123.240.177.208" >> $to
#echo "124.209.99.194" >> $to
#older brother
#echo "123.240.133.184" >> $to
}
sync_conf(){
sync_conf_vanilla
sync_conf_ban
sync_conf_bukkit
sync_conf_start
}
sync_conf_vanilla(){
local to=$thisServerPath/server.properties
sed -i 's/^allow-nether=.*$/allow-nether=true/g' $to

sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=$/server-name=up9cloud Server - $thisServerName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to

sed -i 's/^max-players=.*$/max-players=100/g' $to
sed -i 's/^generate-structures=.*$/generate-structures=true/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=10/g' $to
}
sync_conf_bukkit(){
local to=$thisServerPath/bukkit.yml
sed -i 's/allow-end: false/allow-end: true/g' $to
}
sync_conf_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=4G/g' $to
sed -i 's/^local Xmx=.*$/Xmx=8G/g' $to
sed -i 's/^local ParallelGCThreads=.*$/ParallelGCThreads=1/g' $to
}
sync_upload(){
local plugins=(
VariableTriggers
)
for p in ${plugins[@]};do
$thisServerPath/plugins/$p/upload.sh
done
}
sync_backup(){
local plugin='Essentials'
local f=jail.yml
local from=$thisServerPath/plugins/$plugin
local to=$thisServerPath/plugins_backup/$plugin
if [ ! -d $to ];then
mkdir -p $to
fi
if [ -f $from/$f ];then
mv $from/$f $to
fi
}
sync_scp(){
scp_getControllers;
scp_getServer spigot;
scp_getWorld region_0_0_spawn; #worldname=world

local plugins=(
VariableTriggers
BungeeSuiteWarps
TeleportSigns

dynmap
Dynmap-Essentials
dynmap-residence

PermissionsEx
CoreProtect
AutoSaveWorld
Lockette
Residence

Vault
iConomy
KillerMoney

Essentials
ChatColors
#DeathMessages #cancel by no mod tag name
HealthBar
SuperCensor

mcMMO
EpicBossRecoded

BringBackTheEnd
MultiWorld

WorldBorder
WorldEdit
)
local p
for p in ${plugins[@]};do
scp_getPlugin $p;
done
}
main(){
sync_backup;
sync_upload;

sync_var;
source_all;

msg_startSync;

purge_plugins all;
#1d=24h=1440m=86400s
#432000s=7200m=120h=5d
checkWorldNether 240000;
checkWorld $thisWorldNameTheEnd 80000;

sync_scp;
sync_conf;

msg_endSync;
}
main
