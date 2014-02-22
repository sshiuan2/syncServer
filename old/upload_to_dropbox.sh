#!/bin/bash
#請在此檔案folder執行
#serverName=`pwd|awk -F'/' '{print $NF}'`
serverName=
type=
worlds=

uploaderPath="/root/Dropbox-Uploader/dropbox_uploader.sh"

#search AutoSaveWorld backups backups/worlds/$worlds
for ((i=0; i<${#worlds[@]}; i++)); do
  latestFileNames[$i]=`ls -d backups/$type/${worlds[$i]}/* -l --sort=time|grep -o '[0-9-]\+.zip'|head -1`
if [ "${latestFileNames[$i]}" == "" ];then
exit;
else
fi
  localFilePath="/home/$serverName/backups/$type/${worlds[$i]}/${latestFileNames[$i]}"
  remoteFilePath="$serverName/$type/worlds$i.zip"
#  "$uploaderPath delete $remoteFilePath"
  $uploaderPath upload $localFilePath $remoteFilePath
done

exit;
