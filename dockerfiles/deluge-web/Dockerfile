FROM ubuntu:16.04

RUN apt-get update && \
apt-get upgrade -y && \
apt-get install -y deluged \
deluge-webui

CMD /usr/bin/deluged && /usr/bin/deluge-web
