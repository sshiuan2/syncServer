#!/bin/bash
source ../../function/var.sh

main(){
local name='TeleportSigns'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
echo "upload to: $to"
scp $from/$name.db $to/$thisServerName.db
scp $from/upload.sh $to/upload.sh
}
main
