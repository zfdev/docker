FROM ubuntu:latest

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		gpg \
		gpg-agent \
		dirmngr \
		sudo \
		wget; \
	rm -fr /var/lib/apt/lists/*

# grab gosu for easy step-down from root
RUN set -eux; \
	export GOSU_VERSION=1.11; \
	GPG_KEYS=B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	savedAptMark="$(apt-mark showmanual)"; \
	if ! command -v gpg; then \
		apt-get install -y --no-install-recommends gnupg2 dirmngr; \
	fi; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
	export GNUPGHOME="$(mktemp -d)"; \
	#gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys $GPG_KEYS; \
	(  gpg --keyserver ipv4.pool.sks-keyservers.net --recv-keys "$GPG_KEYS" \
	|| gpg --keyserver pgp.mit.edu --recv-keys "$GPG_KEYS" \
	|| gpg --keyserver keyserver.pgp.com --recv-keys "$GPG_KEYS" ); \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
	apt-mark auto '.*' > /dev/null; \
	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	\
	chmod +x /usr/local/bin/gosu; \
	gosu --version; \
	gosu nobody true

# install kcptun
RUN set -eux; \
	export KCPTUN_VERSION=20190515; \
	wget -O /tmp/kcptun.tar.gz "https://github.com/xtaci/kcptun/releases/download/v$KCPTUN_VERSION/kcptun-linux-$(dpkg --print-architecture)-$KCPTUN_VERSION.tar.gz"; \
	tar -xf /tmp/kcptun.tar.gz -C /tmp; \
	rm -fr /tmp/kcptun.tar.gz; \
	mv /tmp/client_linux_$(dpkg --print-architecture) /usr/local/bin/kcp-client; \
	mv /tmp/server_linux_$(dpkg --print-architecture) /usr/local/bin/kcp-server

# install shadowsocks-libev
RUN set -eux; \
	export SS_VERSION=3.2.5; \
	apt-get update; \
	apt-get install -y --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto automake libsodium-dev git; \
	apt-get install -y --no-install-recommends libc-ares-dev libmbedtls-dev libev-dev; \
	\
	export LIBSODIUM_VER=1.0.16; \
	wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz; \
	tar xvf libsodium-$LIBSODIUM_VER.tar.gz; \
	cd libsodium-$LIBSODIUM_VER; \
	./configure --prefix=/usr && make; \
	make install; \
	cd ..; \
	rm -fr libsodium-$LIBSODIUM_VER.tar.gz libsodium-$LIBSODIUM_VER; \
	\
	export MBEDTLS_VER=2.6.0; \
	wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz; \
	tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz; \
	cd mbedtls-$MBEDTLS_VER; \
	make SHARED=1 CFLAGS=-fPIC; \
	sudo make DESTDIR=/usr install; \
	cd ..; \
	rm -fr mbedtls-$MBEDTLS_VER mbedtls-$MBEDTLS_VER-gpl.tgz; \
	\
	ldconfig; \
	git clone https://github.com/shadowsocks/shadowsocks-libev.git; \
	cd shadowsocks-libev; \
	git checkout v$SS_VERSION; \
	git submodule update --init --recursive; \
	./autogen.sh && ./configure && make; \
	make install; \
	cd ..; \
	rm -fr shadowsocks-libev; \
	apt-get purge -y --auto-remove build-essential autoconf libtool asciidoc git gettext xmlto libpcre3-dev automake libsodium-dev; \
	rm -fr /var/lib/apt/lists/*

# install jq for json parse
RUN set -eux; \
	export JQ_VERSION=1.5; \
	wget -O /usr/local/bin/jq "https://github.com/stedolan/jq/releases/download/jq-$JQ_VERSION/jq-linux$(dpkg --print-architecture | tr -d 'amd')"; \
	chmod a+x /usr/local/bin/jq; \
	apt-get purge -y --auto-remove ca-certificates wget dirmngr gpg

EXPOSE 1080/tcp

COPY docker-entrypoint.sh /usr/local/bin/
CMD ["docker-entrypoint.sh"]

