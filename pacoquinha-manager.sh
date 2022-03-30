#!/bin/bash

### Script Variables

FULL_APP=/opt/pacoquinha-app/pacoquinha-APP.sh

APP_PROCESS=$(ps xau | grep pacoquinha-APP.sh | grep -v grep | awk '{print $2}')

APP_MANAGER=/opt/pacoquinha-app/pacoquinha-manager.sh

VERSION=0.1


case "$1" in 

### Option Start 

start)

  "$FULL_APP" &

  exit

;;

### Option Stop 

stop)

  /usr/bin/kill -9 "$APP_PROCESS"
    
;;

### Option Status 

status)

  if [ -n "$APP_PROCESS" ] ; then

    echo "Active PID:" "$APP_PROCESS"

  else

    echo "Not Active"

    exit 

  fi
;;

### Option Restart 

restart)

  if [ -n "$APP_PROCESS" ] ; then 

    "$APP_MANAGER" stop

    sleep 2

    "$APP_MANAGER" start

  else

    "$APP_MANAGER" start

  fi

;;

*)

### Help Option 

  echo "Usage Mode: $0 {start|stop|status|restart}"

esac
