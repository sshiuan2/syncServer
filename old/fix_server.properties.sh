#!/bin/bash
filename="server.properties"

#預設改為關閉
sed -i 's/^allow-nether=.*$/allow-nether=false/g' $filename
sed -i 's/^generate-structures=.*$/generate-structures=false/g' $filename
sed -i 's/^announce-player-achievements=.*$/announce-player-achievements=false/g' $filename
sed -i 's/^online-mode=.*$/online-mode=false/g' $filename
sed -i 's/^white-list=.*$/white-list=false/g' $filename
sed -i 's/^snooper-enabled=.*$/snooper-enabled=false/g' $filename
sed -i 's/^pvp=.*$/pvp=false/g' $filename
sed -i 's/^hardcore=.*$/hardcore=false/g' $filename

sed -i 's/^spawn-npcs=.*$/spawn-npcs=false/g' $filename
sed -i 's/^spawn-animals=.*$/spawn-animals=false/g' $filename
sed -i 's/^spawn-monsters=.*$/spawn-monsters=false/g' $filename

sed -i 's/^enable-query=.*$/enable-query=false/g' $filename
sed -i 's/^allow-flight=.*$/allow-flight=false/g' $filename
sed -i 's/^enable-rcon=.*$/enable-rcon=false/g' $filename
sed -i 's/^force-gamemode=.*$/force-gamemode=false/g' $filename

#預設改為開啟
sed -i 's/^enable-command-block=.*$/enable-command-block=true/g' $filename

#改為空白以防錯誤
sed -i 's/^generator-settings=.*$/generator-settings=/g' $filename
sed -i 's/^level-name=.*$/level-name=/g' $filename
sed -i 's/^level-seed=.*$/level-seed=/g' $filename
sed -i 's/^server-ip=.*$/server-ip=/g' $filename
sed -i 's/^server-port=.*$/server-port=/g' $filename
sed -i 's/^texture-pack=.*$/texture-pack=/g' $filename
sed -i 's/^resource-pack=.*$/resource-pack=/g' $filename

#數字
sed -i 's/^gamemode=.*$/gamemode=0/g' $filename
sed -i 's/^max-players=.*$/max-players=0/g' $filename
sed -i 's/^difficulty=.*$/difficulty=3/g' $filename
sed -i 's/^op-permission-level=.*$/op-permission-level=4/g' $filename
sed -i 's/^player-idle-timeout=.*$/player-idle-timeout=240/g' $filename
sed -i 's/^view-distance=.*$/view-distance=10/g' $filename
sed -i 's/^max-build-height=.*$/max-build-height=256/g' $filename
sed -i 's/^spawn-protection=.*$/spawn-protection=100000/g' $filename

#文字
sed -i 's/^level-type=.*$/level-type=DEFAULT/g' $filename
sed -i 's/^motd=.*$/motd=\\u00A71up9cloud.net \\u00A7c| \\u00A7eup9cloud Server \\u00CE\\u00A3(\\u00EF\\u00BE\\u009F \\u00D0\\u00B4\\u00EF\\u00BE\\u009F|||)/g' $filename
