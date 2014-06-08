#!/bin/bash
varPath="function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

source $varDir/msg.sh
source $varDir/color.sh

#http://www.oracle.com/technetwork/java/javase/tech/vmoptions-jsp-140102.html#PerformanceTuning
#http://pic.dhe.ibm.com/infocenter/wasinfo/v6r0/index.jsp?topic=%2Fcom.ibm.websphere.express.doc%2Finfo%2Fexp%2Fae%2Ftprf_tunejvm.html

main(){
#dont change, otherwise sed command will not work
local Xms=$javaXms
local Xmx=$javaXmx
local ParallelGCThreads=$javaParallelGCThreads
local MaxGCPauseMillis=500
local SurvivorRatio=16
local UseSSE=3
local PermSize=128m
local TargetSurvivorRatio=90
local LargePageSizeInBytes=4m
local MaxHeapFreeRatio=70
local argArray=( #http://unixboy.iteye.com/blog/174173
"-Xms$Xms"
"-Xmx$Xmx"
'-server' #指示JAVA以伺服器模式執行(只有64位元適用)
'-Xincgc' #指示垃圾回收不斷進行 而不是停頓來進行一次性清理
###+UseParallelGC啟用會有問題
##'-XX:+UseParallelGC' #新生代暫存使用ParallelGC
##'-XX:+UseParallelOldGC' #Use parallel garbage collection for the full collections. Enabling this option automatically sets -XX:+UseParallelGC. (Introduced in 5.0 update 6.)
"-XX:ParallelGCThreads=$ParallelGCThreads" #指示JAVA同一時間用多少處理執行緒垃圾回收新生代
##'-XX:+UseAdaptiveSizePolicy' #
'-XX:+UseParNewGC' #指示使用新版垃圾回收 有更好的效能
'-XX:+CMSParallelRemarkEnabled' #使用UseParNewGC的參數下 儘量減少 mark 的時間
'-XX:+UseConcMarkSweepGC' #指示垃圾回收和伺服器核心同時進行
'-XX:+CMSIncrementalPacing' #指示伺服器執行時 根據收集的數據自動調節所佔空間比率
'-XX:+AggressiveOpts' #增加編譯的速度
##'DisableExplicitGC'會造成Could not create the Java Virtual Machine.
'-XX:+DisableExplicitGC' #禁止全面性垃圾回收呼叫 (減少每隔一段時間的伺服器短暫停頓)
"-XX:MaxGCPauseMillis=$MaxGCPauseMillis" #限制垃圾回收最大的暫停毫秒數
"-XX:SurvivorRatio=$SurvivorRatio" #調整JAVA程序新生代與舊代的比率
"-XX:TargetSurvivorRatio=$TargetSurvivorRatio"
##'-XX:-AllowUserSignalHandlers' #Do not complain if the application installs signal handlers. (Relevant to Solaris and Linux only.)
'-XX:+UseAdaptiveGCBoundary' #允許垃圾回收依據情況需要在程序新生代與舊代之間移轉 (提升性能)
'-XX:-UseGCOverheadLimit' #禁止JAVA花費大量時間只為了釋放一點點空間
'-Xnoclassgc' #命令記憶體存放區填滿之後 禁止停頓進行大規模垃圾回收 而是開新空間
"-XX:UseSSE=$UseSSE" #指示JAVA編譯器操作處理器的調整 (數值會自動降低直到符合使用者的處理器)
"-XX:PermSize=$PermSize" #指示伺服器一開始執行時的永久可用記憶體區域
##"-XX:MaxPermSize=$MaxPermSize" #-XX:PermSize specifies the initial size that will be allocated during startup of the JVM. If necessary, the JVM will allocate up to -XX:MaxPermSize.
"-XX:LargePageSizeInBytes=$LargePageSizeInBytes" #記憶體分頁的大小 (概念和磁碟區叢集很像 數值小 效率高)
##"-XX:MaxHeapFreeRatio=$MaxHeapFreeRatio" #Maximum percentage of heap free after GC to avoid shrinking.
)

local arg
local a
echo -n "載入參數: "
for a in ${argArray[@]};do
  arg="${arg}${a} "
  echo -n "$a "
done
echo ""
local jar=

msg_startServer;
cd $thisServerPath
java $arg -jar $thisServerPath/$jar nogui
}
main
