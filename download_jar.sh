#!/bin/bash
#2014-02-17 edited
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

source_all;

default(){
wget_vanilla
wget_craftbukkit
wget_BungeeCord
wget_spigot

purgePlugins

wget_structuresaver
wget_BungeeSuite
wget_AutoMessage
wget_AuthMe
wget_VariableTriggers
wget_Lockette
wget_ClearLag
wget_CraftBukkitUpToDate
wget_AutoSaveWorld
wget_AutoRestart
wget_AntiCheat
wget_Chairs
wget_Essentials
wget_ColoredSigns
wget_ChatColors
wget_ColoredTexts
wget_DeathMessages
wget_PermissionsEx
wget_WorldEdit
wget_AsyncWorldEdit
wget_dynmap
wget_TeleportSigns
wget_ServerSigns
wget_Multiverse-Core
wget_multiworld
wget_PlotMe
wget_IslandWorld
wget_BringBackTheEnd
wget_Backbone
wget_Quicksand
wget_CoreProtect
wget_WorldBorder
wget_Residence
fix_Residence
wget_Flags
wget_Vault
wget_iConomy
wget_MobBountyReloaded
wget_mcMMO
wget_HealthBar
wget_EpicBossRecoded
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
