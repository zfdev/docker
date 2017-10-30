#!/bin/sh
set -e

pgid=${PGID:-$(id -u nobody)}
puid=${PUID:-$(id -g nobody)}

if [[ "$*" == "kcptun" ]]; then
    cmd=$(echo ${CMD:-NULL} | tr "[:upper:]" "[:lower:]")
    config_file=${KCP_CONFIG_FILE:-null}
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

