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
local delay
if [ $2 == "" ];then
delay=300
else
delay=$2
fi
local sub_delay=0

local argv=()
local pre_msg
local cmd
local cmd_end
local type=$3
if [ "$type" == "proxy" ];then
pre_msg="Proxy Auto Restart:"
cmd=alert
cmd_end=end
else
pre_msg="Auto Restart:"
cmd=say
cmd_end=stop
fi

argv+=("$cmd $pre_msg" 1)
while (($delay > 0));do
if (( $(($delay - 60)) >= "60" ));then
argv+=("$cmd ${delay}s" 60)
delay=$(($delay - 60))
elif (( $(($delay - 30)) >= "30" ));then
argv+=("$cmd ${delay}s" 30)
delay=$(($delay - 30))
elif (( $(($delay - 10)) >= "10" ));then
argv+=("$cmd ${delay}s" 10)
delay=$(($delay - 10))
else
argv+=("$cmd ${delay}s" 1)
delay=$(($delay - 1))
fi
done
argv+=("$cmd_end")
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
