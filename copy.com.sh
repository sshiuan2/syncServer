#!/bin/bash
source ./secret.sh
username=$copy_username
password=$copy_password
dir='/root/copy'
app_dir='/root/copy_app'
cmd_dir="$app_dir/x86_64"

copy_install(){
local url='https://copy.com/install/linux/Copy.tgz'
cd $dir
wget $url --no-check-certificate
tar -xvzf Copy.tgz
mv copy/ $app_dir
$cmd_dir/CopyConsole -u=$username -p=$password -r=$dir
}

copy_get_auth(){
$cmd_dir/CopyCmd Cloud -username=$username -password=$password authClient
}

main(){
#local auth=$(copy_get_auth)
#local args="-authToken=$auth -username=$username"
args="-password=$password -username=$username"
$cmd_dir/CopyCmd Cloud $args $@
}

main $@
