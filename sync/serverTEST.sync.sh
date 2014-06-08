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
}
sync_conf_spigot(){
local to=$thisServerPath/spigot.yml
sed -i 's/\  whitelist:.*$/  whitelist: "你不在白名單內！若想加入請FB問op...\\n近期有人搗亂，待1.8有觀察者模式後再拿掉白名單。"/g' $to
}
sync_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=512M/g' $to
}
sync_op(){
local to=$thisServerPath/ops.txt
echo "O0oO0o0Oo0O" >> $to
echo "sp-michelle" >> $to
echo "in91andy" >> $to
echo "sp-kenny" >> $to
echo "SmallWawa" >> $to
echo "XianGerWu" >> $to
#echo "A129lau" >> $to #black list send items to survival server...
echo "sp-bonebonekai" >> $to
echo "sp-byebyron" >> $to
echo "andywawa" >> $to
echo "susanwawa" >> $to
echo "jam09jam" >> $to
echo "bonr_maximum" >> $to
echo "Shiaobin" >> $to
echo "sp-moha" >> $to
echo "OZ_00MS" >> $to
echo "carlccc0911" >> $to
sync_whitelist
}
sync_whitelist(){
local from=$thisServerPath/ops.txt
local to=$thisServerPath/white-list.txt
cat $from >> $to
echo "sp-JackLin84911" >> $to
}
sync_dynmap_port(){
local to=$thisServerPath/plugins/dynmap/configuration.txt
sed -i "s/^webserver-port:.*$/webserver-port: 8888/g" $to
}
sync_var;
source_all;

sync_backup_region;
#sync_backup_score;
purge_plugins all;

msg_startSync;
scp_getControllers
sync_start;
scp_getServer spigot;
sync_conf;
sync_op;

#scp_getPlugin EpicBossGoldEdition;
scp_getPlugin VariableTriggers;
scp_getPlugin WorldEdit;
scp_getPlugin dynmap;
sync_dynmap_port;
#scp_getPlugin iConomy
#scp_getPlugin Vault
#scp_getPlugin KillerMoney
#scp_getPlugin GriefPrevention;
#scp_getPlugin Residence;
msg_endSync;
