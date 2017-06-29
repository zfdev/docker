#!/bin/bash

CMD=${CMD:-"client"}
if [ "$CMD" != "client" ] && [ "$CMD" != "server" ]; then
    echo "Invalid command"
    exit 1
fi

SS_CONFIG_FILE=${SS_CONFIG_FILE:-"NULL"}
if [ ! -f $SS_CONFIG_FILE ]; then
    echo "shadowsocks-libev config file = $SS_CONFIG_FILE is not a regular file or does not exist"
    exit 1
fi

ENABLE_KCP=${ENABLE_KCP+"ENABLE"}
KCP_CONFIG_FILE=${KCP_CONFIG_FILE:-"NULL"}
if [ ! -f $KCP_CONFIG_FILE ] && [ "$ENABLE_KCP" = "ENABLE" ]; then
    echo "kcptun config file = $KCP_CONFIG_FILE is not a regular file or does not exist"
    exit 1
fi

if [ "$CMD" = "client" ]; then
    if [ "$ENABLE_KCP" = "ENABLE" ]; then
        exec gosu nobody:nogroup /usr/local/bin/kcp-client -c $KCP_CONFIG_FILE > /dev/null 2>&1 &
        port=$(cat $KCP_CONFIG_FILE | jq '.localaddr'  | tr -d '"' | awk 'BEGIN{FS=":"}; {print $2}')
        if [ "$port" = "null" ]; then
            exec gosu nobody:nogroup /usr/bin/ss-local -c $SS_CONFIG_FILE -s 127.0.0.1 > /dev/null 2>&1
        else
            exec gosu nobody:nogroup /usr/bin/ss-local -c $SS_CONFIG_FILE -s 127.0.0.1 -p $port > /dev/null 2>&1
        fi
    else
        exec gosu nobody:nogroup /usr/bin/ss-local -c $SS_CONFIG_FILE > /dev/null 2>&1
    fi
fi

if [ "$CMD" = "server" ]; then
    TMP_SS_CONFIG_FILE=/tmp/tmp_ss_config_file.json
    jq -r ".server = \"0.0.0.0\"" $SS_CONFIG_FILE > $TMP_SS_CONFIG_FILE
    if [ "$ENABLE_KCP" = "ENABLE" ]; then
        exec gosu nobody:nogroup /usr/bin/ss-server -c $TMP_SS_CONFIG_FILE > /dev/null 2>&1 &
        exec gosu nobody:nogroup /usr/local/bin/kcp-server -c $KCP_CONFIG_FILE > /dev/null 2>&1
    else
        exec gosu nobody:nogroup /usr/bin/ss-server -c $TMP_SS_CONFIG_FILE > /dev/null 2>&1
    fi
fi
