# For ubuntu, the latest tag points to the LTS version, since that is
# recommended for general use.
FROM ubuntu:latest

RUN : \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		samba \
		ca-certificates \
		gpg \
		gpg-agent \
		dirmngr \
		wget \
	&& rm -fr /var/lib/apt/lists/*

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

ENV SMB_CONF_DIR /var/samba
RUN mkdir -p "$SMB_CONF_DIR"

COPY docker-entrypoint.sh /usr/local/bin
COPY usradmin smb_export smb_import /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 139 445
CMD ["smb", "start"]
