# aes256
Bash File Encrypter

This small script can encrypt and decrypt files and folders using aes-256-cbc. The usage is simple, `./AES256.sh "file to modify" mode password` For more info see usage.txt

# KeyLockGen


# Usage will be ./KeyLockGen.sh "generic or static" "path to AES256.sh" "Output file. Leave empty to create the file in current working directory" "(If $1 is static, otherwise leave empty)/path/to/file/or/dir" 
# If $1 is generic, no file path should be specified. KeyLock.command will ask for file to change each time it is executed.
# if $1 on the other hand is static, a file path must be specified.
# $2 should always be path to aes256.sh.
# $3 should be either a directory(if $3 is a directory eg. /foo/foo/ a file will be created in /foo/foo/KeyLock.command . Note that this will not create new directories) or a file name (eg. /foo/foo/lock.command). Both of these exampels assumed /foo/foo existed.
# $4 Is the path to the file to edit. This is required if $1 is static, leave blank otherwise.
