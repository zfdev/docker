#!/bin/bash

config_file=${CONFIG_FILE:-"NULL"}
if [ ! -f "$config_file" ]; then
    echo "Not a valid config file"
    exit 1
fi


if [[ "$*" == privoxy*start* ]]; then
    exec gosu nobody:nogroup privoxy --no-daemon $config_file
fi

exec "$@"

