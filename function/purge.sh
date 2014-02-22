#!/bin/bash
purge_all(){
echo "not support yet."
}
purge_plugins(){
purge_plugins_$1 $@
}
purge_plugins_all(){
rm -fr $thisServerPath/plugins/*
msg_${FUNCNAME}
}
purge_plugins_jar(){
rm -fr $thisServerPath/plugins/*.jar
msg_${FUNCNAME}
}
purge_plugins_zip(){
rm -fr $thisServerPath/plugins/*.zip
msg_${FUNCNAME}
}
purge_world_players(){
rm -f $thisServerPath/$thisWorldName/players/*
msg_${FUNCNAME}
}
purge_logs(){
if [ -d $thisServerPath/logs ];then
rm -fr $thisServerPath/logs
else
rm -fr $thisServerPath/proxy.log*
fi
msg_${FUNCNAME}
}
