FROM alpine:latest

RUN : \
	&& apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add openssl \
	&& apk add su-exec

# install kcptun
ENV KCPTUN_VERSION 20180810
ENV ARCH amd64
RUN set -x \
	&& wget -O /tmp/kcptun.tar.gz "https://github.com/xtaci/kcptun/releases/download/v$KCPTUN_VERSION/kcptun-linux-$ARCH-$KCPTUN_VERSION.tar.gz" \
	&& tar -xf /tmp/kcptun.tar.gz -C /tmp \
	&& rm -fr /tmp/kcptun.tar.gz \
	&& mv /tmp/client_linux_$ARCH /usr/local/bin/kcp-client \
	&& mv /tmp/server_linux_$ARCH /usr/local/bin/kcp-server

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kcptun"]


