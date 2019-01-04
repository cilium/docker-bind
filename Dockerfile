FROM ubuntu:18.04

MAINTAINER Eloy Coto <eloy.coto@gmail.com>
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get upgrade -y --no-install-recommends \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        bind9 \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /

VOLUME /data
EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/docker-entrypoint.sh"]
