#!/bin/bash

PUID=${PUID:-0}
PGID=${PGID:-0}

USER="deluge"
GROUP="deluge"

if [ "$PGID" != "0" ]; then
    groupadd -g $PGID $GROUP
fi

if [ "$PUID" != "0" ]; then
    useradd -m -s /sbin/nologin -u $PUID -g $PGID $USER

    UMASK=${UMASK:-$(umask)}
    echo "umask $UMASK" >> /home/$USER/.bashrc
fi

exec start-stop-daemon -S -c $USER:$GROUP -k $UMASK -x /usr/bin/deluged -- -d &
gosu deluge:deluge deluge-web

