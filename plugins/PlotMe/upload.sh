#!/bin/bash
source ../../function/var.sh

main(){
local name='PlotMe'
local from=$thisServerPath/plugins/$name
local to=$syncServerScpPath/plugins/$name
echo "upload to: $to"
scp $from/config.yml $to/$thisServerName.config.yml
scp $from/*.sh $to
}
main
