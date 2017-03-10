FROM ubuntu:16.10

RUN printf '\
deb http://mirrors.aliyun.com/ubuntu/ yakkety main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ yakkety-security main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ yakkety-updates main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ yakkety-proposed main restricted universe multiverse\n\
deb http://mirrors.aliyun.com/ubuntu/ yakkety-backports main restricted universe multiverse\n\
' > /etc/apt/sources.list && \
apt-get update && \
apt-get upgrade -y && \
apt-get install -y shadowsocks-libev && \
mkdir -p /config

CMD /usr/bin/ss-local -c /config/config.json &
