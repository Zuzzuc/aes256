#!/bin/bash
# Author Zuzzuc https://github.com/Zuzzuc/
ws=/tmp/$RANDOM && mkdir $ws && cd $ws
TRG=$1 && SRC=$1
if [ "$1" != "" ];then
	if [ "$2" == "enc" ];then
		if [[ -d $1 ]];then
			echo in dir
			
			mv $1 ./
			zip -r "$(basename $1).zip" "$(basename $1)" 
			SRC="$ws/$(basename $1).zip"
			echo SRC IS: $SRC
			echo basename is : $(basename $1)
		fi
		echo in enc
		openssl aes-256-cbc -a -salt -in $SRC -out $TRG -pass file:<( echo -n "$3" )
	elif [ "$2" == "dec" ];then
	echo in dec
		mv $1 ./
		SRC="$ws/$(basename $1)"
		openssl aes-256-cbc -d -a -salt -in $SRC -out $TRG -pass file:<( echo -n "$3" )
		sleep 1
		
		
		if grep -q "PK" <<<"$(awk 'FNR == 1 { print; exit }' $TRG)"; then
			rm "$ws/$(basename $TRG)"
			mv "$TRG" "$ws/$(basename $TRG)"
			TRG="$ws/$TRG"
			echo "It's there!!!!!!!!!!!!!!!!!!!!!!!!!!!1?!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo im in unzip
			echo ITTTTT WOOOOORLSSSS
			sleep 2
			mkdir "$1"
			unzip -o "$(basename $TRG)" -d "$(cd $1 && cd .. && pwd)"
		else
			echo "FAIL, its ..$(awk 'FNR == 1 { print; exit }' $TRG).."
    	fi
		echo post unzip
		sleep 5
	else
		echo "incorrect operation"
	fi
else
	echo "No path specificated"
fi
rm -rf $ws
