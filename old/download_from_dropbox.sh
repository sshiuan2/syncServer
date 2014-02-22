#!/bin/bash
. function/inputCheck.sh

type=
#請在此檔案folder執行
#serverPath=`pwd`
#serverName=`echo $serverPath|awk -F'/' '{print $NF}'`
serverName=
serverPath="/home/$serverName"

uploaderPath="/root/Dropbox-Uploader/dropbox_uploader.sh"

remoteFolderPath="/$serverName/$type"

tmpFolderName="tmp_dropbox"
tmpFolderPath="$serverPath/$tmpFolderName"

#download to tmpFolder
mkdir $tmpFolderPath
echo "please confirm the settings of iptables!"
$uploaderPath download $remoteFolderPath $tmpFolderPath

#extract
filesStr=`ls $tmpFolderPath/$type`
IFS=" "
set -- $filesStr
unset IFS
worlds=( $@ )
ls -l $tmpFolderPath/$type
echo -n "extract all above files to $serverPath? <y or n> :"
read confirm
yesOrExit $confirm
for ((i=0; i<${#worlds[@]}; i++)); do
  echo "jar xvf $tmpFolderPath/$type/${worlds[$i]}"
jar xvf $tmpFolderPath/$type/${worlds[$i]}
done

#delete tmp
echo -n "delete \"$tmpFolderPath\" whole folder? <y or n> :"
read confirm
yesOrExit $confirm
rm -r $tmpFolderPath

exit
