#!/bin/bash

pgid=${PGID:-$(id -u nobody)}
puid=${PUID:-$(id -g nobody)}
cmd=$(tr "[:upper:]" "[:lower:]" <<< """${CMD:-NULL}""")
config_file=${SS_CONFIG_FILE:-null}

if [[ "$*" == "kcptun" ]]; then
    [ ! -f $config_file ] && exit 1

    if [ "$cmd" = "client" ]; then
        exec su-exec $puid:$pgid kcp-client -c "$config_file"
    elif [ "$cmd" = "server" ]; then
        exec su-exec $puid:$pgid kcp-server -c "$config_file"
    else
        exit 1
    fi
fi

exec "$@"

