FROM ubuntu:latest

RUN : \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		nginx \
		openssl \
	&& rm -fr /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["nginx", "start"]

