#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
declare -A sync_var=()
sync_var[thisServerIp]="10.0.0.4"
sync_var[thisServerPort]="25566"
#sync_var[thisServerName]=""

#sync_var[thisWorldName]=""
#sync_var[thisWorldNameNether]=""
#sync_var[thisWorldNameTheEnd]=""

sync_var[tmuxSession]="mc4"
sync_var[tmuxWindow]="1"
sync_var[tmuxPane]="0"

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
}
sync_conf_vanilla(){
local f=$thisServerPath/server.properties
declare -A sync_conf_vanilla=()
sync_conf_vanilla[enable-command-block]="true"

sync_conf_vanilla[level-name]="$thisWorldName"
sync_conf_vanilla[server-port]="$thisServerPort"
sync_conf_vanilla[server-name]="$thisServerName"

#sync_conf_vanilla[spawn-npcs]="true"
sync_conf_vanilla[spawn-animals]="true"
sync_conf_vanilla[spawn-monsters]="true"

#sync_conf_vanilla[allow-nether]="false"
sync_conf_vanilla[level-type]="FLAT"

sync_conf_vanilla[gamemode]="2"
sync_conf_vanilla[force-gamemode]="true"
#sync_conf_vanilla[pvp]="true"
sync_conf_vanilla[max-players]="5"
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
local f=$thisServerPath/banned-ips.json
}
sync_conf_ban_players(){
local f=$thisServerPath/banned-players.json
}
sync_conf_ops(){
local f=$thisServerPath/ops.json
local ops=(
O0oO0o0Oo0O
in91andy
sp-Kane
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
sync_conf_whitelist(){
local f=$thisServerPath/white-list.json
}
sync_scp(){
scp_getControllers;
scp_getServer spigot;

local plugins=(
WorldEdit
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
sync_scp;
sync_conf;
msg_endSync;
}
main
