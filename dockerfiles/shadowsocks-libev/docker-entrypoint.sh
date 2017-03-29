#!/bin/bash

cmd=${cmd:-"client"}
if [ "$cmd" != "client" ] && [ "$cmd" != "server" ]; then
    echo "Invalid command"
    exit 1
fi

ss_config_file=${ss_config_file:-"NULL"}
if [ ! -f $ss_config_file ]; then
    echo "shadowsocks-libev config file = $ss_config_file is not a regular file or does not exist"
    exit 1
fi

enable_kcp=${enable_kcp+"ENABLE"}
kcp_config_file=${kcp_config_file:-"NULL"}
if [ ! -f $kcp_config_file ] && [ "$enable_kcp" = "ENABLE" ]; then
    echo "kcptun config file = $kcp_config_file is not a regular file or does not exist"
    exit 1
fi

if [ "$cmd" = "client" ]; then
    if [ "$enable_kcp" = "ENABLE" ]; then
        exec gosu nobody:nogroup /usr/local/bin/kcp-client -c $kcp_config_file > /dev/null 2>&1 &
        port=$(cat $kcp_config_file | jq '.localaddr'  | tr -d '"' | awk 'BEGIN{FS=":"}; {print $2}')
        if [ "$port" = "null" ]; then
            exec gosu nobody:nogroup /usr/bin/ss-local -c $ss_config_file -s 127.0.0.1 > /dev/null 2>&1
        else
            exec gosu nobody:nogroup /usr/bin/ss-local -c $ss_config_file -s 127.0.0.1 -p $port > /dev/null 2>&1
        fi
    else
        exec gosu nobody:nogroup /usr/bin/ss-local -c $ss_config_file > /dev/null 2>&1
    fi
fi

if [ "$cmd" = "server" ]; then
    if [ "$enable_kcp" = "ENABLE" ]; then
        exec gosu nobody:nogroup /usr/bin/ss-server -c $ss_config_file > /dev/null 2>&1 &
        exec gosu nobody:nogroup /usr/local/bin/kcp-server -c $kcp_config_file > /dev/null 2>&1
    else
        exec gosu nobody:nogroup /usr/bin/ss-server -c $ss_config_file > /dev/null 2>&1
    fi
fi
