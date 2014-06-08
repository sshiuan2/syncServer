#!/bin/bash
#2014-02-04 edited
wget_(){
if [ "$1" == "" ];then echo "Arg parse error.";exit 1;fi
wget_$1 $@
}
wget_plugin(){
local name=$1
wget_plugin_$1 $@
}
wget_plugin_jar(){
local name=$1
local url=$2
cd $thisServerPath/plugins
rm $name.jar
wget $url -O $name.jar
}
wget_server(){
local name=$1
wget_server_$1 $@
}
wget_server_jar(){
local name=$1
local url=$2
local uname=`basename $url`
rm -f $uname
wget $url
cp -f $uname $name.jar
}
wget_server_vanilla(){
wget_server_vanilla_1_7_5 minecraft_server;
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
wget_server_craftbukkit_1_7_5 $@
}
wget_server_craftbukkit_1_7_5(){
local name=$1
local url
url="http://dl.bukkit.org/downloads/craftbukkit/get/02566_1.7.5-R0.1/craftbukkit-dev.jar"
wget_server_jar $name $url
}
wget_server_spigot(){
wget_server_spigot_1_7_5 $@
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
}
function wget_structuresaver(){
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
function wget_AuthMe(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/765/442/AuthMe.jar
}
function wget_VariableTriggers(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/708/169/VariableTriggers.jar
}
function wget_Lockette(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/702/588/Lockette.jar
}
function wget_ClearLag(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/728/550/ClearLag.jar
}
function wget_CraftBukkitUpToDate(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/716/200/CraftBukkitUpToDate.jar
}
function wget_AutoSaveWorld(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/726/156/AutoSaveWorld.jar
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
else
url="wget http://dev.bukkit.org/media/files/711/777/Essentials.zip"
cd $thisServerPath/plugins
wget $url
unzip Essentials.zip
fi
wget_plugin_jar $name $url
}
function wget_ColoredSigns(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/708/392/ColoredSigns.jar
}
function wget_ChatColors(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/619/759/ChatColors.jar
}
function wget_ColoredTexts(){ #有config檔太多餘
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/711/447/ColoredTexts.jar
}
function wget_DeathMessages(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/721/920/DeathMessages.jar
}
function wget_PermissionsEx(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/742/103/PermissionsEx.jar
}
wget_plugin_WorldEdit(){
local name=$1
local url
url="http://dev.bukkit.org/media/files/782/358/worldedit-5.6.1.jar"
cd $thisServerPath/plugins
wget $url -O WorldEdit.jar
#unzip -jo worldedit*.zip $name.jar
#url="http://builds.enginehub.org/job/worldedit/last-successful/download/worldedit-5.5.9-SNAPSHOT.zip"
#wget http://dev.bukkit.org/media/files/715/447/worldedit-5.5.7.jar -O WorldEdit.jar
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
url="http://mikeprimm.com/dynmap/releases/dynmap-1.9.2.jar"
fi
wget_plugin_jar $name $url
}
wget_plugin_DynmapPlotMe(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/604/394/DynmapPlotMe.jar"
else
url="http://dev.bukkit.org/media/files/604/394/DynmapPlotMe.jar"
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
url="http://mikeprimm.com/dynmap/releases/Dynmap-Essentials-0.60.jar"
fi
wget_plugin_jar $name $url
}
function wget_TeleportSigns(){
cd $thisServerPath/plugins
#wget http://www.spigotmc.org/resources/teleportsigns.29/download?version=865 -O TeleportSigns.jar
#old version
#wget http://www.spigotmc.org/resources/teleportsigns.29/update?update=462 -O TeleportSigns.jar
wget_TeleportSigns_dev;
}
function wget_TeleportSigns_dev(){
cd $thisServerPath/plugins
wget http://ci.zh32.de/job/TeleportSigns/lastSuccessfulBuild/artifact/target/TeleportSigns.jar
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
function wget_PlotMe(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/707/659/PlotMe.jar
}
function wget_IslandWorld(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/764/343/IslandWorld.jar
}
function wget_BringBackTheEnd(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/723/915/BringBackTheEnd.jar #重生終界
}
function wget_Backbone(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/745/910/Backbone.jar
}
function wget_Quicksand(){
local name='Quicksand'
cd $thisServerPath/plugins
wget -N http://dev.bukkit.org/media/files/766/955/Quicksand.jar -O $name.jar
}
function wget_CoreProtect(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/715/374/CoreProtect_2.0.8.jar -O CoreProtect.jar
}
wget_plugin_WorldBorder(){
cd $thisServerPath/plugins
local name=$1
local url
if [ "$2" == "dev" ];then
url=http://dev.bukkit.org/media/files/775/280/WorldBorder.jar
else
url=http://dev.bukkit.org/media/files/775/280/WorldBorder.jar
fi
wget_plugin_jar $name $url
}
function wget_Residence(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/722/685/Residence.jar
}
function wget_Flags(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/743/174/Flags.zip
unzip Flags.zip
}
function wget_Vault(){
name="Vault"
cd $thisServerPath/plugins
rm $name.jar
wget http://dev.bukkit.org/media/files/770/208/Vault.jar
}
wget_plugin_iConomy(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/584/551/iConomy.jar
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
function wget_HealthBar(){
#http://dev.bukkit.org/bukkit-plugins/health-bar/
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/763/232/HealthBar.jar
}
function wget_EpicBossRecoded(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/688/989/EpicBossRecoded.jar
}
function wget_EpicBossGoldEdition(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/756/311/EpicBossGoldEdition.jar
}
function wget_MultiWorld(){
cd $thisServerPath/plugins
wget http://dev.bukkit.org/media/files/764/191/multiworld.jar
mv multiworld.jar MultiWorld.jar
}
function wget_GriefPrevention(){
cd $thisServerPath/plugins
wget -N http://dev.bukkit.org/media/files/691/599/GriefPrevention.jar
}
function wget_KillerMoney(){
cd $thisServerPath/plugins
wget -N http://dev.bukkit.org/media/files/766/430/KillerMoney.jar
}
wget_plugin_SuperCensor(){
local name=$1
local url
if [ "$2" == "dev" ];then
url="http://dev.bukkit.org/media/files/769/295/SuperCensor.jar"
else
url="http://dev.bukkit.org/media/files/769/295/SuperCensor.jar"
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
