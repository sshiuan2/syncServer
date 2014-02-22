#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/../../function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit;fi

main(){
local name='mcMMO'
local to=$thisServerPath/plugins/$name/config.yml
sed -i "s/^    Locale:.*$/    Locale: zh_TW/g" $to
sed -i "s/^    MOTD_Enabled:.*$/    MOTD_Enabled: false/g" $to
sed -i "s/^    Update_Check:.*$/    Update_Check: false/g" $to
sed -i "s/^    Config_Update_Overwrite:.*$/    Config_Update_Overwrite: false/g" $to
sed -i "s/^    Rainbows:.*$/    Rainbows: true/g" $to
local ip="10.0.0.200"
#sed -n '1h;1!H;${;g;s/<h2.*</h2>/No title here/g;p;}' sample.php > sample-edited.php;
echo "remember to fix mysql setting!!!!!"
}
main
