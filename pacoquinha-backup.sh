#!/bin/bash

### Script Variables

DATE=$(date +"%Y-%m-%d-%H-%M")

PATH_LOG=/opt/pacoquinha-app/log/

FILE_TIME=$(ls -alt "$PATH_LOG" | grep "weather" | head -n 12 | tail -n 10 | awk '{print $9}')

PATH_BKP=/backup/$DATE

VERSION=0.1

### Function to Check Directory

function directory_validation {

if [ ! -d "$PATH_BKP" ]; then

	/usr/bin/mkdir -p "$PATH_BKP"/service.backup

fi

}


### Function to Select Files to Backup

function select_files {

for backup_file in $FILE_TIME; do

	/usr/bin/mv "$PATH_LOG""$backup_file" "$PATH_BKP"/service.backup

	cd "$PATH_BKP"/service.backup

	/usr/bin/tar -czvf "$backup_file".tar.gz "$backup_file"

	/usr/bin/rm -Rf "$PATH_BKP"/service.backup/"$backup_file"

done

}


### Function to Set Permissions

function set_permission {

	/usr/bin/chown -R root "$PATH_BKP"/service.backup/

	/usr/bin/chmod -R 400 "$PATH_BKP"/service.backup/

}

#Call the functions

directory_validation

select_files

set_permission

