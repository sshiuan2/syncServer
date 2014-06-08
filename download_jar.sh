#!/bin/bash
#2014-02-17 edited
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

source_all;

default(){
local servers=(
vanilla
craftbukkit
BungeeCord
spigot
)
local s
for s in ${servers[@]};do
wget_server $s
done

local plugins=(
AuthMe
PermissionsEx
WorldEdit

VariableTriggers
BungeeSuite
TeleportSigns

Essentials

ColoredSigns
ChatColors

DeathMessages

MultiWorld
BringBackTheEnd

PlotMe
IslandWorld
Backbone
Quicksand

Lockette
Residence
CoreProtect
AutoSaveWorld
WorldBorder

"dynmap all"

Vault
iConomy
KillerMoney

mcMMO
HealthBar
EpicBossRecoded
)
local p
for p in ${plugins[@]};do
wget_plugin $p
done
}

case "$1" in
"")
echo 請輸入參數
;;
"default")
default
;;
"function")
echo download $2
$2
;;
"all")
echo 目前不支援
;;
*)
echo "參數不正確? $@"
$@
;;
esac
