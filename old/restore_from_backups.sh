#!/bin/bash
. function/inputCheck.sh

##method for backup.jar
#latestFile=`ls -d backups/* -l --sort=time|grep -o '[0-9-]\+.zip'|head -2|tail -1`
#
#if [ "$latestFile" = "" ]; then
#  echo "Not found any backup file..."
#  echo "You need to execute this shell in currect folder."
#  echo "Please confirm."
#  exit
#fi
#
#echo -n "restore form $latestFile <y or n> :"
#read confirm

#yesOrExit $confirm
#echo "copypaste & execute the following command."
#echo "jar -xvf /home/minecraft_server/backeups/$latestFile"

#method for AutoSaveWorld.jar
latestPluginsFilePath=`ls -d backups/plugins/* -l --sort=time|head -2|tail -1|grep -o 'backups/plugins/[^[:space:]]\+'`
worldsFolderPaths=(`ls -d backups/worlds/* -l|grep -o 'backups/worlds/[^[:space:]]\+'`)
if [ "$latestPluginsFilePath" = "" ] && [ "$worldsFolderPaths" = "" ]; then
  echo "Not found any backup file..."
  echo "You need to execute this shell in currect folder."
  echo "Please confirm."
  exit
fi
echo "restore All from following files?"
echo $latestPluginsFilePath
for ((index=0; index<${#worldsFolderPaths[@]}; index++)); do
  echo `ls -d ${worldsFolderPaths[$index]}/* -l --sort=time|head -2|tail -1|grep -o 'backups/worlds/[^[:space:]]\+'`
done
echo -n "<y or n> :"
read confirm

yesOrExit $confirm

echo "copypaste & execute the following command:"
echo "jar -xvf $latestPluginsFilePath"
for ((index=0; index<${#worldsFolderPaths[@]}; index++)); do
#  echo ${worldsFolderPaths[$index]}
  echo -n "jar -xvf "
  echo `ls -d ${worldsFolderPaths[$index]}/* -l --sort=time|head -2|tail -1|grep -o 'backups/worlds/[^[:space:]]\+'`
done
