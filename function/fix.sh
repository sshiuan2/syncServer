#!/bin/bash
fix_start_jar(){
local jar=$1
local to="$thisServerPath/start.sh"
sed -i "s/jar=.*$/jar=$jar/g" $to
}
function fix_craftbukkit_v1_6_4_R0(){
cd $thisServerPath/input/
rm -fr $thisServerPath/input/net
unzip 'craftbukkit-1.6.4-R0.x.zip'
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection$1.class
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection$2.class
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection$3.class
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection$4.class
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection$5.class
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection.class
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/SharedConstants.class
}
function fix_craftbukkitv1_6_4_R2(){
cd $thisServerPath/input/
rm -fr $thisServerPath/input/net
unzip '#2918_craftbukkit-1.6.4-R2.0_rec.zip'
jar uf ../craftbukkit.jar net/minecraft/server/v1_6_R3/PlayerConnection.class
}
function fix_Essentials(){
echo -n "是否要修正/nick不能打中文(要有裝Essentials.jar): <y or n>"
read confirm
convertConfirm $confirm
if $confirm; then
  cd $thisServerPath/plugins/Essentials/jar
  javac -classpath ../../Essentials.jar:../../../craftbukkit.jar com/earth2me/essentials/commands/Commandnick.java
  jar uf ../../Essentials.jar com/earth2me/essentials/commands/Commandnick.class
  cd $thisServerPath/plugins
fi
echo -n "是否要中文化Essentials插件: <y or n>"
read confirm
convertConfirm $confirm
if $confirm; then
  cd $thisServerPath/plugins/Essentials/jar
  jar uf ../../Essentials.jar plugin.yml
  cd $thisServerPath/plugins
fi
}
function fix_PermissionsEx(){
echo -n "是否要中文化PermissionsEx權限插件: <y or n>"
read confirm
convertConfirm $confirm
if $confirm; then
  cd $thisServerPath/plugins/PermissionsEx/jar
  javac -classpath ../../PermissionsEx.jar:../../../craftbukkit.jar ru/tehkode/permissions/commands/CommandsManager.java
  jar uf ../../PermissionsEx.jar ru/tehkode/permissions/commands/CommandsManager.class
  cd $thisServerPath/plugins
fi
}
function fix_Residence(){
echo -n "是否要中文化Residence領地插件: <y or n>"
read confirm
convertConfirm $confirm
if $confirm; then
  cd $thisServerPath/plugins/Residence/jar
  jar uf ../../Residence.jar plugin.yml
  javac -classpath ../../Residence.jar:../../../craftbukkit.jar com/bekvon/bukkit/residence/permissions/PermissionGroup.java
  jar uf ../../Residence.jar com/bekvon/bukkit/residence/permissions/PermissionGroup.class
  cd $thisServerPath/plugins
fi
}
function fix_Vault(){
echo "fix vault Language"
}
function fix_mcmmo(){
#sed
echo -n "是否要修正mcmmo內文: <y or n>"
read confirm
convertConfirm $confirm
if $confirm; then
  fixFilePath="com/gmail/nossr50/locale/locale_zh_TW.properties"
  cd $thisServerPath/plugins/mcMMO/jar
  jar xf ../../mcMMO.jar $fixFilePath
  sed -i 's/MOTD.Donate=.*$/MOTD.Donate=[[DARK_AQUA]]\\u006d\\u0063\\u004d\\u004d\\u004f \\u0064\\u006f\\u006e\\u0061\\u0074\\u0065:/g' $fixFilePath
  sed -i 's/mcMMO.Description=.*$/mcMMO.Description=[[DARK_AQUA]]\\u6307\\u4ee4\\u8aaa\\u660e,[[GOLD]] \\u002d [[GREEN]]\\u8f38\\u5165 [[RED]]\/mcmmo help[[GREEN]] \\u4ee5\\u4e86\\u89e3\\u6240\\u6709\\u6307\\u4ee4,[[GOLD]] \\u002d [[GREEN]]\\u8f38\\u5165 [[RED]]\/mcstats [[GREEN]]\\u53ef\\u5728\\u53f3\\u65b9\\u8a18\\u5206\\u677f\\u770b\\u6240\\u6709\\u6280\\u80fd,[[GOLD]] \\u002d [[GREEN]]\\u8f38\\u5165 [[RED]]\/\\u6280\\u80fd\\u540d\\u7a31 [[GREEN]]\\u53ef\\u67e5\\u770b\\u6280\\u80fd\\u8a73\\u7d30\\u8cc7\\u8a0a,[[GOLD]] \\u002d [[GREEN]]\\u8f38\\u5165 [[RED]]\/mcrank [[GREEN]]\\u53ef\\u67e5\\u770b\\u500b\\u4eba\\u6280\\u80fd\\u6392\\u884c/g' $fixFilePath
  jar uf ../../mcMMO.jar $fixFilePath
  cd $thisServerPath/plugins
fi
}
