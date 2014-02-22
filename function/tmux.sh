#!/bin/bash
tmux_check_version(){ #todo...
local tmux=1.9
#send-key support non-unicode 必須要1.9以上！ version 1.6,1.8都不能用!
}
tmux_sendkey_console(){
#can't parse array...
for ((i=0; i<${#2}; i++)); do
echo $2
  if [[ $2[$i] =~ ^[0-9]+$ ]]; then
    sleep $2[$i]
  else
tmux send-key -t $1 enter "${2[$i]}" enter
  fi
done
}
tmux_sendkey_restart(){
local target=$1

local pre_delay=0
local delay=$2
if [ $2 == "" ];then local delay=300;fi
local sub_delay=30

local argv=()

argv+=("say Auto Restart:" 1)
while (($delay > 0));do
if (( $(($delay - 60)) >= "60" ));then
argv+=("say ${delay}s" 60)
delay=$(($delay - 60))
elif (( $(($delay - 30)) >= "30" ));then
argv+=("say ${delay}s" 30)
delay=$(($delay - 30))
elif (( $(($delay - 10)) >= "10" ));then
argv+=("say ${delay}s" 10)
delay=$(($delay - 10))
else
argv+=("say ${delay}s" 1)
delay=$(($delay - 1))
fi
done
argv+=("stop")
sleep $pre_delay

for ((i=0; i<${#argv[@]}; i++)); do
  if [[ ${argv[$i]} =~ ^[0-9]+$ ]]; then
sleep ${argv[$i]}
  else
tmux send-key -t $target enter "${argv[$i]}" enter
  fi
done

sleep $sub_delay
}
tmux_sendkey_tailMsgLog(){
local target=$1
tmux send-key -t $target C-c enter "$thisServerPath/logsChat.sh last" enter
}
