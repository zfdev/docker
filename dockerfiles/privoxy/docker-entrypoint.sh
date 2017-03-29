#!/bin/bash

config_file=${config_file:-"NULL"}
if [ ! -f "$config_file" ]; then
    echo "Not a valid config file"
    exit 1
fi

exec gosu nobody:nogroup privoxy --no-daemon $config_file

