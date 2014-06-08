#!/bin/bash
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit 2;fi

check_os(){
local todo
echo check_os todo
}
install_java(){
local todo
echo check_java todo
}
check_tmux(){
local sed_mainv='s/([0-9]+)\.([0-9]+)/\1/g'
local sed_subv='s/([0-9]+)\.([0-9]+)/\2/g'

local cv="1.9"
local maincv
maincv=(`echo $cv|sed -r "$sed_mainv"`)
local subcv
subcv=(`echo $cv|sed -r "$sed_subv"`)

local sed_v='s/.*([0-9]+.[0-9]+).*/\1/g'

local v=$(tmux -V|sed -r $sed_v)
local mainv
mainv=(`echo $v|sed -r "$sed_mainv"`)
local subv
subv=(`echo $v|sed -r "$sed_subv"`)

echo tmux version: $v
if (( $mainv > $maincv ));then
echo $v later than $cv...pass
return 0
elif (( $mainv == $maincv ));then
if (( $subv >= $subcv ));then
echo $v later than $cv...pass
return 0
fi
else
echo
fi
echo $v older than $cv...
return 1
}
install_tmux(){
local name=tmux
if (check_$name);then
return 1;
fi
local url="https://github.com/ThomasAdam/tmux/archive/master.zip"
local f=$(mktemp)
local root=~
cd $root
wget $url -O $f
unzip $f
rm -f $f
install_automake
install_libevent
cd $root/${name}*
./autogen.sh
./configure
make && make install
return 0
}
install_automake(){
apt-get install automake
}
check_libevent(){
local name=libevent
local result=(`dpkg --get-selections $name|grep install`)
if (( $? == 0 ));then
echo $name installed...pass
return 0
else
return 1
fi
}
install_libevent(){
local name=libevent
if (check_$name);then
return 1
fi
local url="https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz"
local f=$(mktemp)
local root=~
cd $root
wget $url -O $f
tar -zxf $f
rm -f $f
cd $root/${name}*
./configure
make && make install
}
install_vim(){
local todo
#apt-get install vim
}
set_vim(){
local dir=~/.vim/color
local vif=~/.vimrc
cat >$vif <<EOL
syntax on
set nu
set hlsearch
EOL
}
check_server_exist(){
local sv=$1
local to=~
if [ -d $to/$sv ];then
return 0
else
return 1
fi
}
create_servers(){
local from=$thisServerPath/sync
local runf=run.sh
local syncf=sync.sh
local f
local fpath
local sv
local to=~
for fpath in $from/*;do
f=`basename $fpath`
sv=`echo $f|sed "s/.$syncf//g"`
if (check_server_exist $sv);then
echo $to/$sv exist...pass
else
mkdir -p $to/$sv
cp $thisServerPath/$runf $to/$sv
cp $varPath $to/$sv/function
cp $fpath $to/$sv/$syncf
fi
done
}

install_apache2(){
local app=apache2
#mods-enabled,include,jd.....??
cp apache2/include.conf /etc/apache2/mods-enabled/
a2enmod headers
a2enmod include
rm /etc/apache2/site-enabled/*
cp apache2/minecraft /etc/apache2/site-enabled/minecraft
service $app restart
}

install_webserver(){
install_apache2
install_tomcat
install_node
install_vim
}

install_database(){
install_mysql
}

install_gameserver(){
install_java
install_tmux
create_server
}

main(){
sudo -i;
check_os
install_webserver
install_database
install_gameserver
}
