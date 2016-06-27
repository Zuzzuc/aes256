#!/bin/bash
# Author Zuzzuc github.com/Zuzzuc/
if [ "$1" != "" ];then
	if [ "$3" == "enc" ];then
		openssl aes-256-cbc -a -salt -in $1 -out $2 -pass file:<( echo -n "$4" )
	elif [ "$3" == "dec" ];then
		openssl aes-256-cbc -d -a -salt -in $1 -out $2 -pass file:<( echo -n "$4" )
	fi
else
	echo "Incorrect argument(s)"
fi