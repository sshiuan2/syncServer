#!/bin/bash
varDir="$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)"
varPath="$varDir/var.sh"

version="1.7.5"

thisServerIp=`hostname --ip-address`
thisServerPort="25565"
thisServerPath="$(dirname "$varDir")"
thisServerName="$(basename "$thisServerPath")"

thisWorldName="world"
thisWorldPath="$thisServerPath/$thisWorldName"
thisWorldNameNether="${thisWorldName}_nether"
thisWorldNameTheEnd="${thisWorldName}_the_end"
thisWorldNameBackup="${thisWorldName}_backup"

syncServerUser="root"
syncServerIp="192.200.109.235"
syncServerName="syncServer"
syncServerPath="/root/$syncServerName"
if [ $thisServerIp == $syncServerIp ];then
syncServerScpPath=$syncServerPath
else
syncServerScpPath="$syncServerUser@$syncServerIp:$syncServerPath"
fi

databaseIp="10.0.0.200"

tmuxSession=
tmuxWindow=
tmuxPane=0

session=$tmuxSession
window=$tmuxWindow
pane=$tmuxPane

javaXms=64M
javaXmx=512M
javaParallelGCThreads=1

source_all(){
echo -n "sourceAllFunctions: "
for f in $varDir/*.sh;do
source $f;echo -n "$f ";
done
echo ""
}
