#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.3/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25566/g" $varPath

sed -i 's/^session=.*$/session=mc3/g' $varPath
sed -i 's/^window=.*$/window=3/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=$/server-name=up9cloud - $thisServerName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to

sed -i "s/^op-permission-level=$/op-permission-level=4/g" $to
sed -i "s/^level-type=.*$/level-type=FLAT/g" $to
sed -i 's/^gamemode=.*$/gamemode=2/g' $to
sed -i 's/^force-gamemode=.*$/force-gamemode=true/g' $to
sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i 's/^max-players=.*$/max-players=8/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=0/g' $to

sed -i 's/^white-list=.*$/white-list=true/g' $to
}
sync_op(){
local to=$thisServerPath/ops.txt
echo 'in91andy' >> $to
echo 'sp-Mercurius' >> $to
echo 'O0oO0o0Oo0O' >> $to
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
sync_op;

scp_getPlugin WorldEdit;
scp_getPlugin MythicMobs;
scp_getPlugin HealthBar;
msg_endSync;
