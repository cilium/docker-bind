FROM ubuntu:18.04

MAINTAINER Eloy Coto <eloy.coto@gmail.com>
RUN apt-get update; apt-get install -y bind9

COPY docker-entrypoint.sh /

VOLUME /data
EXPOSE 53/udp 53/tcp

ENTRYPOINT ["/docker-entrypoint.sh"]
