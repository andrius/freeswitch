# vim:set ft=dockerfile:
FROM debian:jessie-slim

LABEL maintainer="Andrius Kairiukstis <k@andrius.mobi>"

USER root

RUN echo "APT::Install-Recommends "false";" > /etc/apt/apt.conf \
 && echo "APT::Install-Suggests "false";" >> /etc/apt/apt.conf \
 && apt-get -qq update \
 \
 && DEBIAN_FRONTEND=noninteractive apt-get install -yqq --no-install-recommends --no-install-suggests \
                                     gnupg \
                                     gnupg2 \
                                     curl \
                                     wget \
                                     lsb-release \
                                     ca-certificates \
 && wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add - \
 && echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list \
 && echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list \
 \
 && apt-get -qq update \
 \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
                                     freeswitch \
                                     freeswitch-conf-vanilla \
                                     freeswitch-mod-commands \
                                     freeswitch-mod-conference \
                                     freeswitch-mod-console \
                                     freeswitch-mod-dptools \
                                     freeswitch-mod-directory \
                                     freeswitch-mod-dialplan-xml \
                                     freeswitch-mod-curl \
                                     freeswitch-mod-dialplan-directory \
                                     freeswitch-mod-esl \
                                     freeswitch-mod-event-socket \
                                     freeswitch-mod-hash \
                                     freeswitch-mod-sofia \
 \
 && DEVELOPMENT_PACKAGES=`dpkg -l|grep '\-dev'|awk '{print $2}'|xargs` \
 && DEBIAN_FRONTEND=noninteractive apt-get --yes purge \
      ${DEVELOPMENT_PACKAGES} \
 && rm -rf /var/lib/freeswitch/sounds/music/16000 \
           /var/lib/freeswitch/sounds/music/32000 \
           /var/lib/freeswitch/sounds/music/48000 \
           /usr/share/doc \
           /usr/share/man* \
           /var/lib/apt/lists/* \
           /tmp/* \
           /var/tmp/*

VOLUME /etc/freeswitch/certs \
       /etc/freeswitch/tls

# COPY certs /etc/freeswitch/certs/

# RUN cat /etc/freeswitch/certs/cert.pem > /etc/freeswitch/tls/wss.pem
# RUN cat /etc/freeswitch/certs/privkey.pem >> /etc/freeswitch/tls/wss.pem
# RUN cat /etc/freeswitch/certs/chain.pem >> /etc/freeswitch/tls/wss.pem

RUN chown -R freeswitch:freeswitch /etc/freeswitch
USER freeswitch

EXPOSE 5060/tcp 5060/udp 5080/tcp 5080/udp
EXPOSE 5066/tcp 7443/tcp
EXPOSE 8021/tcp
EXPOSE 64535-65535/udp

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/freeswitch", "-u", "freeswitch", "-g", "freeswitch"]
