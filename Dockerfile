FROM tiredofit/nginx-php-fpm:8.0
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Default Runtime Environment Variables
ENV BOOKSTACK_VERSION=v21.05.3 \
    BOOKSTACK_REPO_URL=https://github.com/BookStackApp/BookStack \
    PHP_ENABLE_CREATE_SAMPLE_PHP=FALSE \
    PHP_ENABLE_LDAP=TRUE \
    PHP_ENABLE_SIMPLEXML=TRUE \
    PHP_ENABLE_MEMCACHED=TRUE \
    PHP_ENABLE_PDO=TRUE \
    PHP_ENABLE_PDO_MYSQL=TRUE \
    PHP_ENABLE_FILEINFO=TRUE \
    PHP_ENABLE_TOKENIZER=TRUE \
    PHP_ENABLE_XMLWRITER=TRUE \
    NGINX_WEBROOT=/www/bookstack \
    CONTAINER_ENABLE_MESSAGING=TRUE \
    ZABBIX_HOSTNAME=bookstack-app

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .bookstack-run-deps \
                expect \
                fontconfig \
                git \
                jpegoptim \
                libmemcached \
                optipng \
                ttf-freefont \
                wkhtmltopdf \
                && \
    \
    mkdir -p /assets/install && \
    git clone ${BOOKSTACK_REPO_URL} /assets/install && \
    cd /assets/install && \
    git checkout ${BOOKSTACK_VERSION} && \
    composer install && \
    \
    cd /assets/install/ && \
    rm -rf *.yml dev php*.xml tests && \
    rm -rf /root/.composer && \
    rm -rf /var/cache/apk/*

### Assets
ADD install /
