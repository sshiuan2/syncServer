#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
declare -A sync_var=()
#sync_var[thisServerIp]=""
#sync_var[thisServerPort]=""
#sync_var[thisServerName]=""

#sync_var[thisWorldName]=""
#sync_var[thisWorldNameNether]=""
#sync_var[thisWorldNameTheEnd]=""

sync_var[tmuxSession]=""
sync_var[tmuxWindow]=""
sync_var[tmuxPane]=""

sync_var[javaXms]="64M"
sync_var[javaXmx]="512M"
sync_var[javaParallelGCThreads]="1"

local k
for k in "${!sync_var[@]}";do
sed -i "s/^$k=.*$/$k=${sync_var[$k]}/g" $varPath
done
}
sync_conf(){
sync_conf_vanilla
sync_conf_bukkit
#sync_conf_spigot
}
sync_conf_vanilla(){
local f=$thisServerPath/server.properties
declare -A sync_conf_vanilla=()
sync_conf_vanilla[enable-command-block]="true"
#sync_conf_vanilla[white-list]="true"

sync_conf_vanilla[level-name]="$thisWorldName"
sync_conf_vanilla[server-port]="$thisServerPort"
sync_conf_vanilla[server-name]="$thisServerName"

#sync_conf_vanilla[spawn-npcs]="true"
#sync_conf_vanilla[spawn-animals]="true"
#sync_conf_vanilla[spawn-monsters]="true"

#sync_conf_vanilla[allow-nether]="true"
#sync_conf_vanilla[level-type]="FLAT"
#DEFAULT - Standard world with hills, valleys, water, etc.
#FLAT - A flat world with no features, meant for building.
#LARGEBIOMES - Same as default but all biomes are larger.
#AMPLIFIED - Same as default but world-generation height limit is increased.
#sync_conf_vanilla[max-build-height]="128"

#sync_conf_vanilla[gamemode]="2"
sync_conf_vanilla[force-gamemode]="true"
#sync_conf_vanilla[pvp]="true"
sync_conf_vanilla[max-players]="10"
#sync_conf_vanilla[spawn-protection]="0"

local k
for k in "${!sync_conf_vanilla[@]}";do
sed -i "s/^$k=.*$/$k=${sync_conf_vanilla[$k]}/g" $f
done

sync_conf_ban_ips
sync_conf_ban_players
sync_conf_ops
sync_conf_whitelist
}
sync_conf_ban_ips(){
local f=$thisServerPath/banned-ips.txt
}
sync_conf_ban_players(){
local f=$thisServerPath/banned-players.txt
}
sync_conf_ops(){
local f=$thisServerPath/ops.txt
}
sync_conf_whitelist(){
local f=$thisServerPath/white-list.txt
}
sync_conf_bukkit(){
local f=$thisServerPath/bukkit.yml
#sed -i 's/allow-end: .*$/allow-end: true/g' $f
}
sync_conf_spigot(){
local f=$thisServerPath/spigot.yml
}
sync_upload(){
local plugins=(
#VariableTriggers
)
for p in ${plugins[@]};do
$thisServerPath/plugins/$p/upload.sh
done
}
sync_backup(){
declare -A sync_backup=()
#sync_backup[plugin]="file"
local from
local to
local p
local f
local k

for p in "${!sync_backup[@]}";do #key=$p=plugin,value=${sync_backup[$p]}=file
from=$thisServerPath/plugins/$p
to=$thisServerPath/plugins_backup/$p
f=${sync_backup[$p]}
if [ ! -d $to ];then
mkdir -p $to
fi
if [ -f $from/$f ];then
mv $from/$f $to
fi
done
}
sync_world(){
local from=
local to=
}
sync_scp(){
scp_getControllers;
scp_getServer spigot;

local plugins=(
VariableTriggers
#TeleportSigns
#SuperCensor

#PermissionsEx
#Vault

#WorldBorder
#WorldEdit
)
local p
for p in ${plugins[@]};do
scp_getPlugin $p;
done
}
sync_purge(){
local sync_purge
#rm -fr $thisWorldPath;
#purge_plugins all;
#checkWorldNether 432000;
}
main(){
sync_backup;
sync_upload;

sync_var;
source_all;

sync_purge;

msg_startSync;

sync_world;
sync_scp;
sync_conf;

msg_endSync;
}
main
