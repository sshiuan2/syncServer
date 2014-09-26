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
sync_var[window]="2"
sync_var[pane]="0"
local k
for k in "${!sync_var[@]}";do
sed -i "s/^$k=.*$/$k=${sync_var[$k]}/g" $varPath
done
}
sync_world(){
rm -fr $thisWorldPath
cp -r $thisServerPath/$thisWorldNameBackup $thisWorldPath
}
sync_conf(){
sync_conf_vanilla
sync_conf_start
sync_conf_ops
}
sync_conf_vanilla(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-ip=.*$/server-ip=$thisServerIp/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=$/server-name=$thisServerName/g" $to

sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
#sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to

sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

sed -i 's/^max-players=.*$/max-players=12/g' $to

sed -i 's/^gamemode=.*$/gamemode=0/g' $to
#sed -i 's/^generate-structures=.*$/generate-structures=true/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=0/g' $to
#sed -i 's/^pvp=.*$/pvp=true/g' $to

sed -i 's/^level-type=.*$/level-type=FLAT/g' $to
}
sync_conf_start(){
local to="$thisServerPath/start.sh"
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=1024M/g' $to
sed -i 's/^local ParallelGCThreads=.*$/ParallelGCThreads=1/g' $to
}
sync_conf_ops(){
local f="$thisServerPath/ops.json"
local f_op="$thisServerPath/function/ops.json.op"
cat $f | $varDir/jq ". + $(cat $f_op)" > $f;
local ops=(
SmallWawa
kinfung831
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
#scp_getServer vanilla;
scp_getServer spigot;

local p=VariableTriggers;
scp_getPlugin $p
}
sync_event(){
local event_world_name='BlocksVsZombies'
cp $thisServerPath/spigot-1.7.5-R0.1-SNAPSHOT.jar spigot.jar
cp $thisServerPath/spigot.yml.$event_world_name $thisServerPath/spigot.yml
}
main(){
sync_var;
source_all;

purge_vanilla_files;
msg_startSync;

sync_world;
sync_scp;
sync_conf;

sync_event;

msg_endSync;
}
main
