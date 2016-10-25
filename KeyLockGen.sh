#!/bin/bash
# License: The MIT License (MIT)
# Author Zuzzuc https://github.com/Zuzzuc/
# This script generates a file named KeyLock.command that is used to execute AES256.sh without saving input to terminal.
SC(){
	echo "$(echo "$1" | sed 's%\\%%g' | sed -e 's%[[:space:]]*$%%')"
}
mode=""
if [ "$1" == "static" ];then
	mode="$1"
	if [ "$4" == "" ];then
		echo '$1 was static, but no file path was supplied'
		exit 4
	fi
elif [ "$1" == "generic" ];then
	mode="$1"
else
	echo '$1 needs to be either "static" or "generic"'
	exit 4
fi
fta=""
if [ "$2" != "" ];then
	fta="$(SC "$2")"
else
	echo 'No path to aes256 found'
fi
of=""
if [ "$3" != "" ];then
	of="$(SC "$3")"
	if [ää -d "$of" ];then
		of="$of/KeyLock.command"
		
	fi
else
	echo 'Output file is not set.'
fi
fte=""
if [ "$mode" == "static" ];then
	fte="$(SC "$4")"
fi
touch "$of"
echo -e '#!/bin/bash' > "$of"
if [ "$mode" == "static" ];then
	echo -en "f=\"$fte\";" >> "$of"
	echo -e 'echo "This lock has a locked filepath at $f"' >> "$of"
elif [ "$mode" == "generic" ];then
	echo -en "echo \"Enter path to file to encrypt/decrypt\"\nread -p \"File:\" f;" >> "$of"
fi
echo -en "e=\"$fta\"\n" >> "$of"
echo -e 'if [ ! -f "$e" ];then\n	echo "AES256.sh not found!";exit 1\nfi' >> "$of"
echo -en 'echo "What mode would you like to execute AES256.sh with?"\nread -p "mode:" m\necho "Enter file password";read -sp "Password:" p\necho "Working"...\nexec "$e" "$f" "$m" "$p"\necho "Done"' >> "$of"
chmod u+x "$of"