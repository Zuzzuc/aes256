#!/bin/bash
# Author Zuzzuc https://github.com/Zuzzuc/
ws=/tmp/$RANDOM && mkdir $ws && cd $ws
SRC=$1 && TRUESRC=$(echo "$1" | sed 's%\\%%g') && TRUESRC=$(echo "$TRUESRC" | sed -e 's%[[:space:]]*$%%') && CUR_PATH="$TRUESRC"
F_IS_DIR=-1;
if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ];then
	echo "Incorrect usage"
	exit 1
else
	F_NAME="${TRUESRC##*/}"
	if [ "$2" == "enc" ];then
		if [ -d "$TRUESRC" ];then
			F_IS_DIR=1;
		else
			F_IS_DIR=0;
		fi
		mv "$TRUESRC" ./ 
		if [[ F_IS_DIR -eq 1 ]];then
			zip -rq "$F_NAME".zip "$F_NAME"
			openssl aes-256-cbc -a -salt -in "$ws/$F_NAME.zip" -out "$ws/enc" -pass file:<( echo -n "$3" )
			mv "$ws/enc" "$TRUESRC"
		else
			openssl aes-256-cbc -a -salt -in "$ws/$F_NAME" -out "$ws/enc" -pass file:<( echo -n "$3" )
			mv "$ws/enc" "$TRUESRC"
		fi
	elif [ "$2" == "dec" ];then
		openssl aes-256-cbc -d -a -salt -in "$TRUESRC" -out "$ws/DEC" -pass file:<( echo -n "$3" )
		rm -rf "$TRUESRC"
		if [[ $(head -1 "DEC" | grep -q "PK" && echo "isDir") == "isDir" ]];then
			unzip -o -qq "DEC" -d "DEC.d"
			mv "DEC.d/${TRUESRC##*/}" "$TRUESRC"
		else
			rm -rf "$TRUESRC"
			mv "DEC" "$TRUESRC"
		fi
	fi
fi
rm -rf $ws
exit 0
