# https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-apache-in-ubuntu-16-04
# https://jovicailic.org/2013/10/how-to-install-apache-with-ssl-webdav-on-ubuntu/
FROM ubuntu:latest

RUN : \
## For local build in China, uncomment the below lines to use aliyun mirror
#	&& printf '\
#		deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse\n\
#		deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse\n\
#		' > /etc/apt/sources.list \
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

