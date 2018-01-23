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

# install kcptun
ENV KCPTUN_VERSION 20171201
RUN set -x \
	&& wget -O /tmp/kcptun.tar.gz "https://github.com/xtaci/kcptun/releases/download/v$KCPTUN_VERSION/kcptun-linux-$(dpkg --print-architecture)-$KCPTUN_VERSION.tar.gz" \
	&& tar -xf /tmp/kcptun.tar.gz -C /tmp \
	&& rm -fr /tmp/kcptun.tar.gz \
	&& mv /tmp/client_linux_$(dpkg --print-architecture) /usr/local/bin/kcp-client \
	&& mv /tmp/server_linux_$(dpkg --print-architecture) /usr/local/bin/kcp-server

# install jq for json parse
ENV JQ_VERSION 1.5
RUN set -x \
	&& wget -O /usr/local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux$(dpkg --print-architecture | tr -d 'amd')" \
	&& chmod a+x /usr/local/bin/jq \
	&& apt-get purge -y --auto-remove ca-certificates wget dirmngr

EXPOSE 1080/tcp

COPY docker-entrypoint.sh /usr/local/bin/
CMD ["docker-entrypoint.sh"]

