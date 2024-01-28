# vim:set ft=dockerfile:
FROM alpine:3.18.6

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

ENV ENV="/etc/profile"
ENV WORKDIR /app
WORKDIR ${WORKDIR}

USER root

RUN apk add --update --no-cache \
      freeswitch \
			freeswitch-sample-config \
			freeswitch-timezones \
 && rm -rf /var/cache/apk/* \
           /tmp/* \
           /var/tmp/*

RUN chown -R freeswitch:freeswitch /etc/freeswitch
USER freeswitch

EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
EXPOSE 5066/tcp 7443/tcp
EXPOSE 8021/tcp
EXPOSE 64535-65535/udp

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/freeswitch", "-u", "freeswitch", "-g", "freeswitch"]
