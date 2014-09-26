#!/bin/bash
#for server 1.7 or newer
thisPwd="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
varPath="$thisPwd/function/var.sh"
if [ -f $varPath ];then source $varPath;
else echo "source var.sh failed!";exit 2;fi

getChat(){
	local chatRegex="\[Server[^ ]\|\[Async Chat Thread\|command: \/\(m\|msg\|tell\|t\|w\|r\|p\|rc\) ";
	local dir=$thisServerPath/logs;
	if [ ! -d $dir ];then
		echo "logs folder not exist.";
	exit 2;
	fi

		case $1 in
		all)
		local files=($(ls $dir/*.gz));
					;;
					last)
					local day;
					if [ "$2" == "" ];then
					day=1;
					else
					day=$2;
					fi
					local yesterday=`date --date="-$2 day" +%F`;
					local today=`date +%F`;
					local files=($(ls $dir/${yesterday}*.gz));
					files+=($(ls $dir/${today}*.gz));
					files+=($dir/latest.log);
					;;
					clean)
					rm -f $dir/*.chat
					;;
				       *)
				       for i; do
				       local files+=(`ls $dir/${i}*.gz`);
				       done
				       ;;
				       esac

				       if [ "$files" == '' ];then echo "files empty";exit;fi

				       local chatResult="$dir/result.chat";
				       local latest="$dir/latest.log";

				       echo "" > $chatResult

				       for ((i=0; i<${#files[@]}; i++)); do
				       local gzfile=${files[$i]};
				       local file=${gzfile/.gz/};
				       if [ "$file" == "$latest" ];then
				       `cat $file|grep "$chatRegex" > $file.chat`;
				       elif [ -f $file.chat ];then
				       echo "$file.chat exist"
				       else
				       gzip -d $gzfile
				       `cat $file|grep "$chatRegex" > $file.chat`;
				       gzip $file
				       fi
				       echo "#${file}.chat" >> $chatResult
				       `cat $file.chat >> $chatResult`
				       done

				       cat $chatResult
				       }

getLogs(){
	local dir=$thisServerPath/logs;
case $1 in
					last)
					local day;
					if [ "$2" == "" ];then
					day=1;
					else
					day=$2;
					fi
					local yesterday=`date --date="-$2 day" +%F`;
					local today=`date +%F`;
					local files=($(ls $dir/${yesterday}*.gz));
					files+=($(ls $dir/${today}*.gz));
					files+=($dir/latest.log);
					;;
*)
;;
esac

				       if [ "$files" == '' ];then echo "files empty";exit;fi

				       local resultFile="$dir/result.log";
				       local latestFile="$dir/latest.log";

				       echo "" > $resultFile

				       for ((i=0; i<${#files[@]}; i++)); do
				       local gzfile=${files[$i]};
				       local file=${gzfile/.gz/};
				       if [ "$file" == "$latestFile" ];then
				       `cat $file >> $resultFile`;
				       else
				       gzip -d $gzfile
				       `cat $file >> $resultFile`;
				       gzip $file
				       fi
				       done

				       cat $resultFile


}

				       main(){
				       case "$1" in
				       "chat")
				       getChat $2 $3
				       ;;
				       "log")
				       getLogs $2 $3
				       ;;
				       *)
				       echo unknow params
				       ;;
				       esac
				       }
				       main $@
