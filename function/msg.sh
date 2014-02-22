#!/bin/bash
#msg_$FUNCNAME
msg_(){
echo $@
msg_$@
}
msg_delay(){
echo 3;sleep 1;
echo 2;sleep 1;
echo 1;sleep 1;
}
msg_startSync(){
echo ${logWARNING} "----------------SERVER pre syncing...!---------------"
echo ${logINFO} "本伺服器路徑為 $thisServerIp:$thisServerPath"
echo ${logINFO} "世界名稱為 $thisWorldName"
echo ${logINFO} "sync從 $syncServerScpPath"
msg_delay;
echo ${logWARNING} "----------------SERVER START syncing...!---------------"
}
msg_endSync(){
echo "sync done."
}
msg_startServer(){
echo ${logWARNING} "----------------SERVER preSTART!---------------"
echo ${logINFO} "記憶體範圍: $Xms ~ $Xmx"
echo ${logINFO} "使用jar檔: $jar"
msg_delay;
echo ${logWARNING} "----------------SERVER START!---------------"
}
msg_startPurge(){
echo "清除舊檔案"
}
msg_endPurge(){
echo "purge done."
}
msg_purge_plugins_all(){
echo "removed plugins whole folder"
}
msg_purge_plugins_jar(){
echo "已刪除所有 plugins jar files..."
}
msg_purge_plugins_zip(){
echo "已刪除所有 plugins zip files..."
}
msg_purge_world_players(){
echo "已刪除所有 $thisWorldName players 資料"
}
msg_purge_logs(){
echo "已清空 logs"
}
msg_scp_getPlugin(){
echo $logINFO "----- get $1 -----"
}
