FROM alpine:3.8
LABEL maintainer "DI GREGORIO Nicolas <nicolas.digregorio@gmail.com>"

### Environment variables
ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    GIT_BRANCH='master' \
    APPUSER='sabnzbd' \
    APPUID='10012' \
    APPGID='10012'

# Copy config files
COPY root/ /

### Install Application
RUN chmod 1777 /tmp && \
    . /usr/local/bin/docker-entrypoint-functions.sh && \
    MYUSER=${APPUSER} && \
    MYUID=${APPUID} && \
    MYGID=${APPGID} && \
    DetectOS && \
    ConfigureUser && \
    apk --no-cache upgrade && \
    apk add --no-cache --virtual=build-deps \
      make \
      automake \
      autoconf \
      gcc \
      g++ \
      python-dev \
      py2-pip \
      libressl-dev \
      musl-dev \
      libffi-dev \
    && \
    apk add --no-cache --virtual=run-deps \
      bash \
      ca-certificates \
      python \ 
      py-libxml2 \
      py-lxml \
      unrar  \
      libgomp \
      p7zip \
      libressl \
      su-exec \
      git \
    && \
    pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install --upgrade pyopenssl cheetah requirements && \
    pip --no-cache-dir install http://www.golug.it/pub/yenc/yenc-0.4.0.tar.gz && \
    pip --no-cache-dir install --upgrade sabyenc && \
    git clone --depth 1 --branch ${GIT_BRANCH} https://github.com/sabnzbd/sabnzbd.git /opt/sabnzbd && \
    cd /opt/sabnzbd && \
    python tools/make_mo.py && \
    ln -s /config /opt/sabnzbd/.sabnzbd && \
    git clone --depth 1 --branch ${GIT_BRANCH} https://github.com/jkansanen/par2cmdline-mt.git /tmp/par2cmdline-mt && \
    cd /tmp/par2cmdline-mt && \
    aclocal && \
    automake --add-missing && \
    autoconf && \
    ./configure && \ 
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/par2cmdline /tmp/par2cmdline-mt && \
    mkdir /docker-entrypoint.d && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    ln -snf /usr/local/bin/docker-entrypoint.sh /docker-entrypoint.sh && \
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
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sabnzbd"]
