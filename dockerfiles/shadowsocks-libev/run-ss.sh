#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage $0 <config_file>"
    exit 1
fi

if [ ! -f $1 ]; then
    echo "$1 is not a regular file"
    exit 1
fi

exec gosu nobody:nogroup /usr/bin/ss-local -c $1
