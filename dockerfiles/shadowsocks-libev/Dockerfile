FROM ubuntu:16.10

RUN : \
##
# For local build in China, uncomment the below lines to use aliyun mirror
##
# && printf '\
#    deb http://mirrors.aliyun.com/ubuntu/ yakkety main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ yakkety-security main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ yakkety-updates main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ yakkety-proposed main restricted universe multiverse\n\
#    deb http://mirrors.aliyun.com/ubuntu/ yakkety-backports main restricted universe multiverse\n\
#    ' > /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y shadowsocks-libev \
 && rm -fr /var/lib/apt/lists/*

CMD /usr/bin/ss-local -c /config.json
