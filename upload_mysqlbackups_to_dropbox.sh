#!/bin/bash -x
check(){
local todo=0
#mysqlBackups exist
#dropbox uploader exist
}
upload(){
local folderName="mysqlBackups"
local type="latest"

local path="/root/$folderName/$type"
local uploaderPath="/root/Dropbox-Uploader/dropbox_uploader.sh"

#tar latest files
tar -cf $path/$type.tar $path/$type/*

local localFilePath="$path/$type.tar"
local remoteFilePath="/$folderName/$type.tar"

#upload
iptables -I INPUT 1 -j ACCEPT
$uploaderPath upload $localFilePath $remoteFilePath
iptables -D INPUT -j ACCEPT

#remove local tar file
rm $localFilePath
}
main(){
check
upload
}
main
