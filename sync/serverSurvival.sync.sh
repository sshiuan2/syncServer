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
sync_ban(){
local to=$thisServerPath/banned-ips.txt
echo "112.171.53.194" >> $to
echo "123.240.177.208" >> $to
echo "124.209.99.194" >> $to
#older brother
#echo "123.240.133.184" >> $to
}
sync_conf(){
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

sync_conf_bukkit
}
sync_conf_bukkit(){
local to=$thisServerPath/bukkit.yml
sed -i 's/allow-end: false/allow-end: true/g' $to
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=4G/g' $to
sed -i 's/^local Xmx=.*$/Xmx=8G/g' $to
sed -i 's/^local ParallelGCThreads=.*$/ParallelGCThreads=1/g' $to
}
sync_upload(){
local plugins=(
EpicBossRecoded
VariableTriggers
)
for p in ${plugins[@]};do
$thisServerPath/plugins/$p/upload.sh
done
}
sync_var;
source_all;

sync_upload;

purge_plugins all;
checkWorldNether 432000;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer spigot;
sync_conf;
sync_ban;
scp_getWorld region_0_0_spawn; #worldname=world

scp_getPlugin VariableTriggers;
scp_getPlugin BungeeSuiteWarps;
scp_getPlugin TeleportSigns;

scp_getPlugin dynmap;
scp_getPlugin Dynmap-Essentials;
scp_getPlugin dynmap-residence;

scp_getPlugin PermissionsEx;
scp_getPlugin CoreProtect;
scp_getPlugin AutoSaveWorld;
scp_getPlugin Lockette;
scp_getPlugin Residence;

scp_getPlugin Vault;
scp_getPlugin iConomy;
scp_getPlugin KillerMoney;

scp_getPlugin Essentials;
scp_getPlugin ChatColors;
scp_getPlugin DeathMessages;
scp_getPlugin HealthBar;

scp_getPlugin mcMMO;
scp_getPlugin EpicBossRecoded;
scp_getPlugin BringBackTheEnd world_the_end;
scp_getPlugin MultiWorld;

scp_getPlugin WorldBorder;
scp_getPlugin WorldEdit;
msg_endSync;
