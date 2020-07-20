FROM tiredofit/nginx-php-fpm:7.3
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Default Runtime Environment Variables
ENV BOOKSTACK_VERSION=0.29.3 \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_LDAP=TRUE \
    PHP_ENABLE_SIMPLEXML=TRUE \
    PHP_ENABLE_MEMCACHED=TRUE \
    PHP_ENABLE_PDO=TRUE \
    PHP_ENABLE_PDO_MYSQL=TRUE \
    PHP_ENABLE_TIDY=TRUE \
    PHP_ENABLE_FILEINFO=TRUE \
    PHP_ENABLE_TOKENIZER=TRUE \
    PHP_ENABLE_XMLWRITER=TRUE \
    NGINX_WEBROOT=/www/bookstack \
    ENABLE_SMTP=TRUE \
    ZABBIX_HOSTNAME=bookstack-app

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .bookstack-run-deps \
                expect \
                fontconfig \
                libmemcached \
                ttf-freefont \
                wkhtmltopdf \
                && \
    \
    mkdir -p /assets/install && \
    curl -sSL https://github.com/BookStackApp/BookStack/archive/v${BOOKSTACK_VERSION}.tar.gz | tar xvfz - --strip 1 -C /assets/install && \
    cd /assets/install && \
    composer install && \
    \
    cd /assets/install/ && \
    rm -rf *.yml dev php*.xml tests && \
    rm -rf /root/.composer && \
    rm -rf /var/cache/apk/*

### Assets
  ADD install /
