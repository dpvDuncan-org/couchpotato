ARG BASE_IMAGE_PREFIX

FROM ${BASE_IMAGE_PREFIX}alpine

ENV PUID=0
ENV PGID=0

COPY scripts/start.sh /

RUN apk -U --no-cache upgrade
RUN apk add --no-cache python2
RUN apk add --no-cache --virtual=.build-dependencies ca-certificates curl
RUN mkdir -p /config /opt/couchpotato
RUN curl -o - \
        -L "https://github.com/CouchPotato/CouchPotatoServer/archive/master.tar.gz" \
        | tar xz -C /opt/couchpotato \
                --strip-components=1
RUN apk del .build-dependencies

RUN chmod -R 777 /start.sh /opt/couchpotato

RUN rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
# ports and volumes
EXPOSE 5050
VOLUME /config

CMD ["/start.sh"]