#!/bin/bash
thisBasename=`basename $PWD`
thisServerName=$thisBasename
varFilename="var.sh"
varDir="$PWD/function"
varPath="$varDir/$varFilename"
#scpFilename="scp.sh"
#scpPath="$varDir/$scpFilename"
syncFilename="sync.sh"
echo "Remember this run.sh file have to run on the currect folder!"

askInfo(){
#local lo=`hostname --ip-address`
echo -n "Please enter sync server's ip: "
read syncServerIp
echo -n "Please enter sync server's dir path: "
read syncServerPath
echo -n "Please enter user name: "
read syncServerUser
syncServerScpPath="${syncServerUser}@$syncServerIp:$syncServerPath"
echo $syncServerScpPath
echo -n "The scp path is currect? <y/n>: "
read confirm
}
getVarFile(){
local from=$syncServerScpPath/function
local to=$PWD/function
echo "start getting $varFilename"
mkdir -p $PWD/function
scp $from/$varFilename $to/$varFilename
}
getSyncFile(){
local from=$syncServerScpPath/sync
local to=$PWD
echo "start getting $syncFilename"
scp $from/$thisServerName.$syncFilename $to/$syncFilename
}
uploadSyncFile(){
local from=$PWD
local to=$syncServerScpPath/sync
echo "start uploading $syncFilename"
scp $from/$syncFilename $to/$thisServerName.$syncFilename
}
scp_getFunctions(){
local from=$syncServerScpPath/function
local to=$PWD/function
rm -fr $to
scp -r $from $PWD
}

checkVarFile(){
while [ ! -f "$varPath" ];do
echo "$varFilename not exist"
askInfo;
while [ "$confirm" != "y" ];do
echo ""
echo "Please enter again or Ctrl+C exit this shell."
askInfo;
done
getVarFile;
done
echo "$varFilename exist, pass the manual step."
source $varPath
echo "Scp to: $syncServerScpPath"
}

main(){
checkVarFile;
while [ 1 = 1 ]; do
scp_getFunctions;
getSyncFile;
if [ -f $thisServerPath/$syncFilename ];then
./$syncFilename;
else exit 2;
fi
./start.sh;
done
}

case $1 in
"")
#start main process
main
;;
"upload")
checkVarFile
uploadSyncFile
;;
"get")
checkVarFile
case $2 in
"sync")
getSyncFile
;;
"var")
getVarFile
;;
*)
echo "get What???"
;;
esac
;;
"help")
echo .......
;;
*)
$1
;;
esac
