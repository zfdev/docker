# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-16-04
# https://jovicailic.org/2013/10/how-to-install-apache-with-ssl-webdav-on-ubuntu/
FROM ubuntu:latest

RUN : \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		apache2 \
		openssl \
	&& rm -fr /var/lib/apt/lists/*

COPY default-ssl.conf /default-ssl.conf
COPY ssl-params.conf /ssl-params.conf

COPY first_run.sh /first_run

EXPOSE 443/tcp

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["webdav", "start"]

