#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.3/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25599/g" $varPath

sed -i 's/^session=.*$/session=mc3/g' $varPath
sed -i 's/^window=.*$/window=4/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_world_restore(){
local from=$thisServerPath/$thisWorldNameBackup
local to=$thisServerPath/$thisWorldName
rm -fr $to
cp -r $from $to
#ln -s /dev/null $thisWorldName/players
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=.*$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=.*$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=.*$/server-name=up9cloud - $thisServerName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

#sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
#sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
#sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to

sed -i "s/^op-permission-level=.*$/op-permission-level=4/g" $to
sed -i "s/^level-type=.*$/level-type=FLAT/g" $to
sed -i 's/^gamemode=.*$/gamemode=2/g' $to
sed -i 's/^force-gamemode=.*$/force-gamemode=true/g' $to
sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i 's/^max-players=.*$/max-players=2/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=0/g' $to

sync_conf_start
}
sync_conf_start(){
local to=$thisServerPath/start.sh
sed -i 's/^local Xms=.*$/Xms=64M/g' $to
sed -i 's/^local Xmx=.*$/Xmx=256M/g' $to
}
sync_var;
source_all;

purge_plugins all;
sync_world_restore;

msg_startSync;
scp_getControllers;
scp_getServer vanilla;
sync_conf;

#scp_getPlugin WorldEdit;
msg_endSync;
