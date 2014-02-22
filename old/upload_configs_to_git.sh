#!/bin/bash
. function/inputCheck.sh

##method for backup.jar
`./git_add_files.sh`
git status
echo -n "upload above all configs to Github? <y or n> :"
read confirm

yesOrExit $confirm

echo -n "write commit memo: "
read memo
git commit -m "$memo"

iptables -A INPUT -j ACCEPT
echo "注意！iptable -A INPUT -j ACCEPT！"
git push -f -u origin master
iptables -D INPUT -j ACCEPT
echo "iptable -D INPUT -j ACCEPT！"
