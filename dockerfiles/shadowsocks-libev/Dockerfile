FROM ubuntu:17.10

RUN : \
## For local build in China, uncomment the below lines to use aliyun mirror
#	&& printf '\
#		deb http://mirrors.aliyun.com/ubuntu/ yakkety main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ yakkety-security main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ yakkety-updates main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ yakkety-proposed main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ yakkety-backports main restricted universe multiverse\n\
#		' > /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		shadowsocks-libev \
		ca-certificates \
		dirmngr \
		wget \
	&& rm -fr /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.10
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["shadowsocks-libev"]

