#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.3/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25600/g" $varPath

#sed -i "s/^thisWorldName=.*$/thisWorldName=world_test/g" $varPath

sed -i 's/^session=.*$/session=mc3/g' $varPath
sed -i 's/^window=.*$/window=0/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_backup_score(){
local from=$thisServerPath/$thisWorldName
local to=$sourceWorldName
local ds=(
players
playerdata
data
stats
)
for d in ${ds[@]};do
cp -r $from/$d $sourceWorldName
done
}
sync_backup_region(){
local path=$thisServerPath/$thisWorldName
$path/backup_regions.sh
$path/upload.sh
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=.*$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=.*$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=.*$/server-name=up9cloud - $thisServerName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to

#sed -i 's/^announce-player-achievements=.*$/announce-player-achievements=true/g' $to
sed -i 's/^difficulty=.*$/difficulty=3/g' $to
sed -i 's/^pvp=.*$/pvp=true/g' $to

sed -i "s/^level-type=.*$/level-type=FLAT/g" $to
sed -i 's/^gamemode=.*$/gamemode=1/g' $to
sed -i 's/^force-gamemode=.*$/force-gamemode=true/g' $to
#sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i 's/^max-players=.*$/max-players=8/g' $to
#sed -i 's/^spawn-protection=.*$/spawn-protection=500/g' $to

sed -i "s/^op-permission-level=.*$/op-permission-level=2/g" $to
sed -i 's/^white-list=.*$/white-list=true/g' $to

sync_conf_spigot;
sync_conf_start;
sync_conf_ops;
}
sync_conf_spigot(){
local to=$thisServerPath/spigot.yml
sed -i 's/\  whitelist:.*$/  whitelist: "你不在白名單內！若想加入請FB問op...\\n近期有人搗亂，待1.8有觀察者模式後再拿掉白名單。"/g' $to
}
sync_conf_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=512M/g' $to
}
sync_conf_ops(){
local f="$thisServerPath/ops.json"
local ops=(
"O0oO0o0Oo0O"
"sp-michelle"
"in91andy"
"sp-kenny"
"SmallWawa"
"XianGerWu"
#"A129lau" #black list send items to survival server...
"sp-bonebonekai"
"sp-byebyron"
"andywawa"
"susanwawa"
"jam09jam"
"bonr_maximum"
"Shiaobin"
"sp-moha"
"OZ_00MS"
"carlccc0911"
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
sync_conf_whitelist
}
sync_conf_whitelist(){
local f=$thisServerPath/whitelist.json
local whites=(
"sp-JackLin84911"
)
local white;
local args=();
for white in ${whites[@]};do
args+=(`buildOpData "$white"`);
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
VariableTriggers
WorldEdit
dynmap

#iConomy
#Vault
#KillerMoney
#GriefPrevention
#Residence
)
}
sync_dynmap_port(){
local to=$thisServerPath/plugins/dynmap/configuration.txt
sed -i "s/^webserver-port:.*$/webserver-port: 8888/g" $to
}
sync_var;
source_all;

msg_startSync;

sync_backup_region;
#sync_backup_score;
purge_plugins all;

sync_scp;
sync_conf;

sync_dynmap_port;

msg_endSync;
