#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
declare -A sync_var=()
sync_var[thisServerIp]="10.0.0.4"
sync_var[thisServerPort]="25565"
sync_var[session]="mc4"
sync_var[window]="0"
sync_var[pane]="0"
local i
for i in "${!sync_var[@]}";do
sed -i "s/^$i=.*$/$i=${sync_var[$i]}/g" $varPath
done
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i 's/^allow-nether=.*$/allow-nether=true/g' $to
sed -i 's/^level-name=$/level-name=world/g' $to
sed -i "s/^server-ip=.*$/server-ip=$thisServerIp/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
sed -i 's/^announce-player-achievements=.*$/announce-player-achievements=true/g' $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to
sed -i 's/^server-name=$/server-name=up9cloud Server - Vanilla/g' $to
sed -i 's/^max-players=.*$/max-players=10/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to
sed -i 's/^generate-structures=.*$/generate-structures=true/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=16/g' $to
sed -i 's/^pvp=.*$/pvp=true/g' $to

sed -i 's/^level-type=.*$/level-type=AMPLIFIED/g' $to
#DEFAULT - Standard world with hills, valleys, water, etc.
#FLAT - A flat world with no features, meant for building.
#LARGEBIOMES - Same as default but all biomes are larger.
#AMPLIFIED - Same as default but world-generation height limit is increased.
}
sync_start(){
local to="$thisServerPath/start.sh"
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=1G/g' $to
sed -i 's/^local ParallelGCThreads=.*$/ParallelGCThreads=1/g' $to
}
sync_var;
source_all;

checkWorldNether 432000;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer vanilla;
sync_conf;
msg_endSync;
