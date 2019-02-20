FROM ubuntu:latest

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
		gpg \
		dirmngr \
		wget \
	&& rm -fr /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN set -eux \
	&& apt-get update \
	&& apt-get install -y gosu \
	&& rm -rf /var/lib/apt/lists/* \
# verify that the binary works
	&& gosu nobody true

# install kcptun
ENV KCPTUN_VERSION 20190109
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
	&& apt-get purge -y --auto-remove ca-certificates wget dirmngr gpg

EXPOSE 1080/tcp

COPY docker-entrypoint.sh /usr/local/bin/
CMD ["docker-entrypoint.sh"]

