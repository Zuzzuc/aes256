#!/bin/bash
# Author Zuzzuc https://github.com/Zuzzuc/
# Does not work when path contains spaces. Will fix soon
ws=/tmp/$RANDOM && mkdir $ws && cd $ws
TRG=$1 && SRC=$1
if [ "$1" != "" ];then
	if [ "$2" == "enc" ];then
		if [[ -d $1 ]];then
			mv $1 ./
			zip -rq "$(basename $1).zip" "$(basename $1)" 
			SRC="$ws/$(basename $1).zip"
		fi
		openssl aes-256-cbc -a -salt -in $SRC -out $TRG -pass file:<( echo -n "$3" )
	elif [ "$2" == "dec" ];then
		mv $1 ./
		SRC="$ws/$(basename $1)"
		openssl aes-256-cbc -d -a -salt -in $SRC -out $TRG -pass file:<( echo -n "$3" )
		if grep -q "PK" <<<"$(awk 'FNR == 1 { print; exit }' $TRG)"; then
			rm "$ws/$(basename $TRG)"
			mv "$TRG" "$ws/$(basename $TRG)"
			TRG="$ws/$TRG"
			mkdir "$1"
			unzip -o -qq "$(basename $TRG)" -d "$(cd $1 && cd .. && pwd)"
    	fi
		sleep 5
	else
		echo "Incorrect operation"
	fi
else
	echo "No path specificated"
fi
rm -rf $ws
