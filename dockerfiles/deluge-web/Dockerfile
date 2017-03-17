FROM ubuntu:16.04

RUN : \
##
# For local build in China, uncomment the below lines to use aliyun mirror
##
# && printf '\
#    deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse\n\
#    ' > /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
    deluged \
    deluge-webui \
 && rm -fr /var/lib/apt/lists/*

CMD /usr/bin/deluged && /usr/bin/deluge-web
