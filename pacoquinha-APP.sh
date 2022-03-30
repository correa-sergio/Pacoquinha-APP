#!/bin/bash

### Script Variables 

URL=wttr.in

CITY=joao_pessoa

DIR_LOG=/opt/pacoquinha-app/log

VERSION=0.1


### Function to Create Log Directory 

function directory_validation {

if [ ! -d "$DIR_LOG" ]; then

	/usr/bin/mkdir -p "$DIR_LOG"

fi

}

### Function to Save Data  

function pacoquinha-app {

	while true 

	do

		DATE=$(date +"%Y_%m_%d-%H_%M_%S")

		curl -s $URL/$CITY?0 -o $DIR_LOG/weather_$DATE.log		

		sleep 60

	done
}

### Call to Functions

directory_validation

pacoquinha-app

