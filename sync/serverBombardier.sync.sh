#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$DIR/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

sync_var(){
sed -i "s/^thisServerIp=.*$/thisServerIp=10.0.0.2/g" $varPath
sed -i "s/^thisServerPort=.*$/thisServerPort=25569/g" $varPath

sed -i 's/^session=.*$/session=mc2/g' $varPath
sed -i 's/^window=.*$/window=4/g' $varPath
sed -i 's/^pane=.*$/pane=0/g' $varPath
}
sync_backup_score(){
local from=$thisServerPath/$thisWorldName
local to=$thisWorldNameBackup
cp -r $from/data $to
}
sync_world_restore(){
local from=$thisServerPath/$thisWorldNameBackup
local to=$thisServerPath/$thisWorldName
rm -fr $to
cp -r $from $to
#ln -s /dev/null world/players
}
sync_conf(){
local to=$thisServerPath/server.properties
sed -i "s/^level-name=$/level-name=$thisWorldName/g" $to
sed -i "s/^server-port=$/server-port=$thisServerPort/g" $to
sed -i "s/^server-name=$/server-name=up9cloud - $thisServerName/g" $to
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $to

#sed -i 's/^spawn-animals=.*$/spawn-animals=true/g' $to
#sed -i 's/^spawn-npcs=.*$/spawn-npcs=true/g' $to
#sed -i 's/^spawn-monsters=.*$/spawn-monsters=true/g' $to

#sed -i 's/^announce-player-achievements=.*$/announce-player-achievements=true/g' $to
sed -i 's/^difficulty=.*$/difficulty=3/g' $to
sed -i 's/^pvp=.*$/pvp=true/g' $to

sed -i "s/^op-permission-level=$/op-permission-level=4/g" $to
sed -i "s/^level-type=.*$/level-type=FLAT/g" $to
sed -i 's/^gamemode=.*$/gamemode=2/g' $to
sed -i 's/^force-gamemode=.*$/force-gamemode=true/g' $to
#sed -i 's/^max-build-height=.*$/max-build-height=128/g' $to
sed -i 's/^max-players=.*$/max-players=8/g' $to
sed -i 's/^spawn-protection=.*$/spawn-protection=0/g' $to
}
sync_start(){
sed -i 's/^local Xms=.*$/Xms=64M/g' start.sh
sed -i 's/^local Xmx=.*$/Xmx=512M/g' start.sh
}
sync_var;
source_all;

sync_backup_score;
sync_world_restore;

msg_startSync;
scp_getControllers;
sync_start;
scp_getServer vanilla;
sync_conf;
msg_endSync;
