FROM ubuntu:16.04

RUN printf '\
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse\n\
' > /etc/apt/sources.list && \
apt-get update && \
apt-get upgrade -y && \
apt-get install -y deluged \
deluge-webui

CMD /usr/bin/deluge-web
