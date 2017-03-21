#!/bin/bash

cmd=${cmd:-"client"}
if [ "$cmd" != "client" ] && [ "$cmd" != "server" ]; then
    echo "Invalid command"
    exit 1
fi

config_file=${config_file:-"NULL"}
if [ ! -f $config_file ]; then
    echo "config_file = $config_file is not a regular file"
    exit 1
fi

enable_kcptun=${enable_kcptun+"ENABLE"}
kcpargs="$kcpargs"
if [ "$cmd" = "client" ]; then
    if [ "$enable_kcptun" = "ENABLE" ]; then
        eval gosu nobody:nogroup /usr/local/bin/kcp-client $kcpargs &
        while true; do
            port=$(gosu nobody:nogroup netstat -tlnp | awk '($7 ~ /kcp-client/){print $4}' | awk 'BEGIN{FS=":"}; {print $NF}')
            [ -z "$port" ] || break
        done
        exec gosu nobody:nogroup /usr/bin/ss-local -c $config_file -s 127.0.0.1 -p $port
    else
        exec gosu nobody:nogroup /usr/bin/ss-local -c $config_file
    fi
fi

if [ "$cmd" = "server" ]; then
    exec gosu nobody:nogroup /usr/bin/ss-server -c $config_file &

    if [ "$enable_kcptun" = "ENABLE" ]; then
        eval gosu nobody:nogroup /usr/local/bin/kcp-server $kcpargs
    fi
fi
