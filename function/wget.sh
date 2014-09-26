#!/bin/bash
#2014-02-04 edited
wget_(){
if [ "$1" == "" ];then echo "Arg parse error.";exit 1;fi
wget_$1 $@
}
wget_plugins_all(){
local plugins=(
#serverAuth
AuthMe
#serverCreative
PlotMe
DynmapPlotMe
#serverSurvival
VariableTriggers
BungeeSuiteWarps
TeleportSigns

dynmap
Dynmap-Essentials
dynmap-residence

PermissionsEx
CoreProtect
AutoSaveWorld
Lockette
Residence

Vault
iConomy
KillerMoney
MythicMobs

Essentials
ChatColors
HealthBar
SuperCensor

mcMMO
BringBackTheEnd
MultiWorld

WorldBorder #removable when 1.8
WorldEdit
#serverBackbone
Backbone
#serverQuicksand
Quicksand
)
local p
for p in ${plugins[@]};do
wget_plugin $p $@;
done
}
wget_plugin(){
local name=$1
wget_plugin_$1 $@
}
wget_plugin_jar(){
local name=$1
local url=$2
local uname=`basename $url`
cd $thisServerPath/plugins/
rm $name.jar
wget $url --no-check-certificate
cp -f $uname $name.jar
}
wget_server(){
local name=$1
if [ "$1" == "" ];then
wget_server_vanilla
wget_server_craftbukkit
wget_server_spigot
wget_server_BungeeCord BungeeCord
else
wget_server_$1 $@
fi
}
wget_server_jar(){
local name=$1
local url=$2
local uname=`basename $url`
rm -f $uname
wget -N $url --no-check-certificate
cp -f $uname $name.jar
}
wget_server_vanilla(){
wget_server_vanilla_1_7_10 minecraft_server;
}
wget_server_vanilla_1_7_10(){
local name=$1
local url
url="https://s3.amazonaws.com/Minecraft.Download/versions/1.8/minecraft_server.1.8.jar"
wget_server_jar $name $url
}
wget_server_vanilla_1_7_9(){
local name=$1
local url
url="https://s3.amazonaws.com/Minecraft.Download/versions/1.7.9/minecraft_server.1.7.9.jar"
wget_server_jar $name $url
}
wget_server_vanilla_1_7_5(){
local name=$1
local url
url="https://s3.amazonaws.com/Minecraft.Download/versions/1.7.5/minecraft_server.1.7.5.jar"
wget_server_jar $name $url
}
wget_server_vanilla_1_7_4(){
local name=$1
local url
url="https://s3.amazonaws.com/Minecraft.Download/versions/1.7.4/minecraft_server.1.7.4.jar"
wget_server_jar $name $url
}
wget_server_vanilla_1_7_2(){
local name=$1
local url
url="https://s3.amazonaws.com/Minecraft.Download/versions/1.7.2/minecraft_server.1.7.2.jar"
wget_server_jar $name $url
}
wget_server_craftbukkit(){
#craftbukkit need search newest version on the net
wget_server_craftbukkit_1_7_9 craftbukkit
}
wget_server_craftbukkit_1_7_9(){
local name=$1
local url
url="https://dl.bukkit.org/downloads/craftbukkit/get/02633_1.7.9-R0.3/craftbukkit-dev.jar"
wget_server_jar $name $url
}
wget_server_craftbukkit_1_7_5(){
local name=$1
local url
url="http://dl.bukkit.org/downloads/craftbukkit/get/02566_1.7.5-R0.1/craftbukkit-dev.jar"
wget_server_jar $name $url
}
wget_server_spigot(){
wget_server_spigot_1_7_10 spigot
}
wget_server_spigot_latest(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot.jar"
else
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot.jar"
fi
wget_server_jar $name $url
}
wget_server_spigot_1_7_10(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.10-R0.1-SNAPSHOT.jar"
else
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.10-R0.1-SNAPSHOT.jar"
fi
wget_server_jar $name $url
}
wget_server_spigot_1_7_9(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.9-R0.3-SNAPSHOT.jar"
else
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.9-R0.3-SNAPSHOT.jar"
fi
wget_server_jar $name $url
}
wget_server_spigot_1_7_5(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.5-R0.1-SNAPSHOT.jar"
else
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.5-R0.1-SNAPSHOT.jar"
fi
wget_server_jar $name $url
}
wget_server_spigot_1_7_2(){
local name=$1
local url
url="http://ci.md-5.net/job/Spigot/lastSuccessfulBuild/artifact/Spigot-Server/target/spigot-1.7.2-R0.4-SNAPSHOT.jar"
wget_server_jar $name $url
}
wget_server_BungeeCord(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar"
else
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar"
fi
wget_server_jar $name $url
wget_server_BungeeCord_cmd;
}
wget_server_BungeeCord_cmd(){
wget_server_BungeeCord_cmd_alert;
wget_server_BungeeCord_cmd_find;
wget_server_BungeeCord_cmd_list;
wget_server_BungeeCord_cmd_send;
wget_server_BungeeCord_cmd_server;
wget_server_BungeeCord_reconnect_yaml;
}
wget_server_BungeeCord_cmd_alert(){
local name="cmd_alert"
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-alert/target/cmd_alert.jar"
wget_server_jar $name $url
}
wget_server_BungeeCord_cmd_find(){
local name="cmd_find"
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-find/target/cmd_find.jar"
wget_server_jar $name $url
}
wget_server_BungeeCord_cmd_list(){
local name="cmd_list"
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-list/target/cmd_list.jar"
wget_server_jar $name $url
}
wget_server_BungeeCord_cmd_send(){
local name="cmd_send"
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-send/target/cmd_send.jar"
wget_server_jar $name $url
}
wget_server_BungeeCord_cmd_server(){
local name="cmd_server"
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/cmd-server/target/cmd_server.jar"
wget_server_jar $name $url
}
wget_server_BungeeCord_reconnect_yaml(){
local name="reconnect_yaml"
url="http://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/module/reconnect-yaml/target/reconnect_yaml.jar"
wget_server_jar $name $url
}
wget_plugin_VanillaPod(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://www.spigotmc.org/resources/vanillapod.1022/download?version=3667"
else
url="http://www.spigotmc.org/resources/vanillapod.1022/download?version=3667"
fi
wget_plugin_jar $name $url
}

function wget_structuresaver(){ #1.6 to 1.7 fix .mca files
cd $thisServerPath/plugins
wget https://github.com/Bukkit/StructureSaver/releases/download/v1.2/structuresaver-1.2.jar
}
function wget_OnlyProxyJoin(){ #proxy only(use iptables instead)
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/677/660/OnlyProxyJoin.jar
}
wget_plugin_BungeeSuite_all(){
local this=$1
local version=$2
wget_plugin BungeeSuite $2
wget_plugin BungeeSuiteTeleports $2
wget_plugin BungeeSuiteWarps $2
wget_plugin BungeeSuitePortals $2
wget_plugin BungeeSuiteSpawn $2
wget_plugin BungeeSuiteBans $2
wget_plugin BungeeSuiteChat $2
wget_plugin BungeeSuiteHomes $2
}
wget_plugin_BungeeSuite(){ #suite for bungeecord
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuite/lastSuccessfulBuild/artifact/target/BungeeSuite.jar"
else
url="http://www.spigotmc.org/resources/bungeesuite.9/download?version=799"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuiteTeleports(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuiteTeleports/lastSuccessfulBuild/artifact/target/BungeeSuiteTeleports.jar"
else
url="http://www.spigotmc.org/resources/bungeesuiteteleports.10/download?version=806"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuiteWarps(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuiteWarps/lastSuccessfulBuild/artifact/target/BungeeSuiteWarps.jar"
else
url="http://www.spigotmc.org/resources/bungeesuitewarps.63/download?version=802"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuitePortals(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuitePortals/7/artifact/target/BungeeSuitePortals.jar"
else
url="http://www.spigotmc.org/resources/bungeesuiteportals.67/download?version=807"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuiteSpawn(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuiteSpawn/lastSuccessfulBuild/artifact/target/BungeeSuiteSpawn.jar"
else
url="http://www.spigotmc.org/resources/bungeesuitespawn.68/download?version=803"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuiteBans(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuiteBans/lastSuccessfulBuild/artifact/target/BungeeSuiteBans.jar"
else
url="http://www.spigotmc.org/resources/bungeesuitebans.74/download?version=804"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuiteChat(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuiteChat/lastSuccessfulBuild/artifact/target/BungeeSuiteChat.jar"
else
url="http://www.spigotmc.org/resources/bungeesuitechat.78/download?version=801"
fi
wget_plugin_jar $name $url
}
wget_plugin_BungeeSuiteHomes(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/BungeeSuiteHomes/lastSuccessfulBuild/artifact/target/BungeeSuiteHomes.jar"
else
url="http://www.spigotmc.org/resources/bungeesuitehomes.112/download?version=808"
fi
wget_plugin_jar $name $url
}
function wget_AutoMessage(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/722/73/AutoMessage.jar
}
wget_plugin_AuthMe(){
#http://dev.bukkit.org/bukkit-plugins/authme-reloaded/
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/795/227/AuthMe.jar"
else
url="http://dev.bukkit.org/media/files/795/227/AuthMe.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_VariableTriggers(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/793/966/VariableTriggers.jar"
else
url="http://dev.bukkit.org/media/files/793/966/VariableTriggers.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_Lockette(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/702/588/Lockette.jar"
else
url="http://dev.bukkit.org/media/files/702/588/Lockette.jar"
fi
wget_plugin_jar $name $url
}
function wget_ClearLag(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/728/550/ClearLag.jar
}
function wget_CraftBukkitUpToDate(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/716/200/CraftBukkitUpToDate.jar
}
wget_plugin_AutoSaveWorld(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/767/492/AutoSaveWorld.jar"
else
url="http://dev.bukkit.org/media/files/767/492/AutoSaveWorld.jar"
fi
wget_plugin_jar $name $url
}
function wget_AutoRestart(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/739/691/AutoRestart_V1.5__1.6.4_.jar -O AutoRestart.jar
}
function wget_AntiCheat(){
cd $thisServerPath/plugins
wget http://ci.gravitydevelopment.net/job/AntiCheat/lastSuccessfulBuild/artifact/target/AntiCheat.jar
}
function wget_Chairs(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/731/441/Chairs.jar
}
wget_plugin_Essentials(){
local name=$1
local url
if [ $2 == "dev" ];then
echo "this link has java script..need node to dl?"
url="http://ci.ess3.net/repository/download/bt9/5958:id/Jars/Essentials.jar"
wget_plugin_jar $name $url
else
url="http://dev.bukkit.org/media/files/780/922/Essentials.zip"
cd $thisServerPath/plugins
wget $url
unzip Essentials.zip
fi
}
function wget_ColoredSigns(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/708/392/ColoredSigns.jar
}
wget_plugin_ChatColors(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/619/759/ChatColors.jar"
else
url="http://dev.bukkit.org/media/files/619/759/ChatColors.jar"
fi
wget_plugin_jar $name $url
}
function wget_ColoredTexts(){ #有config檔太多餘
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/711/447/ColoredTexts.jar
}
function wget_DeathMessages(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/721/920/DeathMessages.jar
}
wget_plugin_PermissionsEx(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/794/429/PermissionsEx.jar"
else
url="http://dev.bukkit.org/media/files/794/429/PermissionsEx.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_WorldEdit(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/786/103/worldedit-5.6.2.jar"
else
url="http://dev.bukkit.org/media/files/786/103/worldedit-5.6.2.jar"
#unzip -jo worldedit*.zip $name.jar
#url="http://builds.enginehub.org/job/worldedit/last-successful/download/worldedit-5.5.9-SNAPSHOT.zip"
fi
wget_plugin_jar $name $url
}
function wget_AsyncWorldEdit(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/724/946/AsyncWorldEdit.jar
}
wget_plugin_dynmap_all(){
local this=$1
local version=$2
local all=(
dynmap
DynmapPlotMe
Dynmap-GriefPrevention
dynmap-residence
Dynmap-Essentials
)
for p in ${all[@]};do
wget_plugin $p $2
done
}
wget_plugin_dynmap(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://mikeprimm.com/dynmap/builds/dynmap/dynmap-HEAD.jar"
else
url="http://mikeprimm.com/dynmap/releases/dynmap-1.9.4.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_DynmapPlotMe(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/787/937/DynmapPlotMe.jar"
else
url="http://dev.bukkit.org/media/files/787/937/DynmapPlotMe.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_Dynmap-GriefPrevention(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://mikeprimm.com/dynmap/builds/Dynmap-GriefPrevention/Dynmap-GriefPrevention-HEAD.jar"
else
url="http://mikeprimm.com/dynmap/releases/Dynmap-GriefPrevention-0.60.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_dynmap-residence(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://mikeprimm.com/dynmap/builds/dynmap-residence/dynmap-residence-HEAD.jar"
else
url="http://mikeprimm.com/dynmap/releases/dynmap-residence-0.50.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_Dynmap-Essentials(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://mikeprimm.com/dynmap/builds/Dynmap-Essentials/Dynmap-Essentials-HEAD.jar"
else
url="http://dev.bukkit.org/media/files/790/918/Dynmap-Essentials-0.80.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_TeleportSigns(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.zh32.de/job/TeleportSigns/lastSuccessfulBuild/artifact/target/TeleportSigns.jar"
else
url="http://ci.zh32.de/job/TeleportSigns/lastSuccessfulBuild/artifact/target/TeleportSigns.jar"
#wget http://www.spigotmc.org/resources/teleportsigns.29/download?version=865 -O TeleportSigns.jar
fi
wget_plugin_jar $name $url
}
function wget_ServerSigns(){ #用VariableTrigger代替
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/717/527/ServerSigns.jar
}
function wget_Multiverse_Core(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/588/781/Multiverse-Core-2.4.jar -O Multiverse-Core.jar
#jar uf plugins/Multiverse-Inventories-2.5.jar -C plugins/Multiverse-Inventories/jar zh_TW.yml
}
wget_plugin_PlotMe(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/788/797/PlotMe.jar"
else
url="http://dev.bukkit.org/media/files/788/797/PlotMe.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_IslandWorld(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/786/558/IslandWorld.jar"
else
url="http://dev.bukkit.org/media/files/786/558/IslandWorld.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_BringBackTheEnd(){ #重生終界
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/723/915/BringBackTheEnd.jar"
else
url="http://dev.bukkit.org/media/files/723/915/BringBackTheEnd.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_Backbone(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/784/980/Backbone.jar"
else
url="http://dev.bukkit.org/media/files/784/980/Backbone.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_Quicksand(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/775/837/Quicksand.jar"
else
url="http://dev.bukkit.org/media/files/775/837/Quicksand.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_CoreProtect(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/775/489/CoreProtect_2.0.9.jar"
else
url="http://dev.bukkit.org/media/files/775/489/CoreProtect_2.0.9.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_WorldBorder(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/793/351/WorldBorder.jar"
else
url="http://dev.bukkit.org/media/files/793/351/WorldBorder.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_Residence(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.drtshock.net/job/Residence/lastSuccessfulBuild/artifact/target/Residence.jar"
else
url="http://dev.bukkit.org/media/files/722/685/Residence.jar"
fi
wget_plugin_jar $name $url
}
function wget_Flags(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/743/174/Flags.zip
unzip Flags.zip
}
wget_plugin_Vault(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/792/396/Vault-1.4.1.jar"
else
url="http://dev.bukkit.org/media/files/792/396/Vault-1.4.1.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_iConomy(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/584/551/iConomy.jar"
else
url="http://dev.bukkit.org/media/files/584/551/iConomy.jar"
fi
wget_plugin_jar $name $url
}
function wget_MobBountyReloaded(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/689/596/MobBountyReloaded_v376.zip
unzip MobBountyReloaded_v376.zip
mv MobBountyReloaded_v376.jar MobBountyReloaded.jar
}
wget_plugin_mcMMO(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/mcMMO-dev/lastSuccessfulBuild/artifact/target/mcMMO.jar"
else
url="http://ci.md-5.net/job/mcMMO/lastSuccessfulBuild/artifact/target/mcMMO.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_HealthBar(){
#http://dev.bukkit.org/bukkit-plugins/health-bar/
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/770/165/HealthBar.jar"
else
url="http://dev.bukkit.org/media/files/770/165/HealthBar.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_MythicMobs(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/796/652/MythicMobs.jar"
else
url="http://dev.bukkit.org/media/files/796/652/MythicMobs.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_MultiWorld(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/792/152/multiworld.jar"
else
url="http://dev.bukkit.org/media/files/792/152/multiworld.jar"
fi
wget_plugin_jar $name $url
mv multiworld.jar MultiWorld.jar
}
function wget_plugin_GriefPrevention(){
cd $thisServerPath/plugins
wget -N http://dev.bukkit.org/media/files/691/599/GriefPrevention.jar
}
wget_plugin_KillerMoney(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/784/391/KillerMoney.jar"
else
url="http://dev.bukkit.org/media/files/784/391/KillerMoney.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_SuperCensor(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/790/886/SuperCensor.jar"
else
url="http://dev.bukkit.org/media/files/790/886/SuperCensor.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_ChatControl(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://www.spigotmc.org/resources/chatcontrol.271/download?version=1388"
else
url="http://www.spigotmc.org/resources/chatcontrol.271/download?version=1388"
fi
wget_plugin_jar $name $url
}
wget_plugin_ProtocolLib(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://assets.comphenix.net/job/ProtocolLib/261/artifact/ProtocolLib/target/ProtocolLib-3.4.1-SNAPSHOT.jar"
else
url="http://dev.bukkit.org/media/files/795/545/ProtocolLib-3.4.0.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_LibsDisguises(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://ci.md-5.net/job/LibsDisguises/lastSuccessfulBuild/artifact/target/LibsDisguises.jar"
else
url="http://www.spigotmc.org/resources/libs-disguises.81/download?version=2340"
fi
wget_plugin_jar $name $url
}
wget_plugin_VanillaCord(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://www.spigotmc.org/resources/vanillacord.952/download?version=3197"
else
url="http://www.spigotmc.org/resources/vanillacord.952/download?version=3197"
fi
wget_plugin_jar $name $url
}
