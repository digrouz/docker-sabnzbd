# vim:set ft=dockerfile:
FROM alpine:latest
MAINTAINER DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm' 

### Install Application
RUN apk --no-cache upgrade && \
    apk add --no-cache --virtual=build-deps \
      make \
      automake \
      autoconf \
      gcc \
      g++ \
      python-dev \
      py2-pip \
      wget \
      libressl-dev \
      musl-dev \
      libffi-dev && \
    apk add --no-cache --virtual=run-deps \
      ca-certificates \
      python \ 
      py-libxml2 \
      py-lxml \
      unrar  \
      p7zip \
      su-exec \
      git && \
    pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install --upgrade pyopenssl cheetah requirements && \
    pip --no-cache-dir install http://www.golug.it/pub/yenc/yenc-0.4.0.tar.gz && \
    wget --no-check-certificate https://github.com/sabnzbd/sabnzbd/archive/master.zip -O /tmp/sabnzbd.zip && \
    unzip /tmp/sabnzbd.zip -d /opt/ && \
    mv /opt/sabnzbd-master /opt/sabnzbd && \
    git clone --depth 1 https://github.com/Parchive/par2cmdline.git /tmp/par2cmdline && \
    cd /tmp/par2cmdline && \
    aclocal && \
    automake --add-missing && \
    autoconf && \
    ./configure && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/par2cmdline && \
    apk del --no-cache --purge \
      build-deps  && \
    rm -rf /opt/sabnzbd/.git* \
           /tmp/* \
           /var/cache/apk/*  \
           /var/tmp/*

### Volume
VOLUME ["/downloads","/config","/incomplete-downloads"]

### Expose ports
EXPOSE 8080 9090

### Running User: not used, managed by docker-entrypoint.sh
#USER sabnzbd

### Start Sabnzbd
#COPY ./docker-entrypoint.sh /
#ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["sabnzbd"]
