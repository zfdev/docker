#!/bin/bash
set -e

pgid=${PGID:-$(id -u nobody)}
puid=${PUID:-$(id -g nobody)}
cmd=$(tr "[:upper:]" "[:lower:]" <<< """${CMD:-NULL}""")
config_file=${SS_CONFIG_FILE:-null}

if [[ "$*" == "shadowsocks-libev" ]]; then
    [ ! -f $config_file ] && exit 1

    if [ "$cmd" = "client" ]; then
        exec gosu $puid:$pgid ss-local -c "$config_file"
    elif [ "$cmd" = "server" ]; then
        exec gosu $puid:$pgid ss-server -c "$config_file"
    else
        exit 1
    fi
fi

exec "$@"

