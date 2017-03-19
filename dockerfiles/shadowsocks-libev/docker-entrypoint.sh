#!/bin/bash

CONFIG_FILE=${CONFIG_FILE:-"NULL"}

if [ ! -f $CONFIG_FILE ]; then
    echo "CONFIG_FILE = $CONFIG_FILE is not a regular file"
    exit 1
fi

exec gosu nobody:nogroup /usr/bin/ss-local -c $CONFIG_FILE
