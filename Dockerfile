ARG PHP_VERSION=8.2
ARG DISTRO="alpine"

FROM docker.io/tiredofit/nginx-php-fpm:${PHP_VERSION}-${DISTRO}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG BOOKSTACK_VERSION

ENV BOOKSTACK_VERSION=${BOOKSTACK_VERSION:-"v24.02.3"} \
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
    NGINX_SITE_ENABLED=bookstack \
    CONTAINER_ENABLE_MESSAGING=TRUE \
    IMAGE_NAME="tiredofit/bookstack" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-bookstack/"

RUN source /assets/functions/00-container \
    set -x && \
    package update && \
    package upgrade && \
    package install .bookstack-run-deps \
                fontconfig \
                git \
                jpegoptim \
                libmemcached \
                optipng \
                ttf-freefont \
                #wkhtmltopdf \
                && \
    \
    clone_git_repo "${BOOKSTACK_REPO_URL}" "${BOOKSTACK_VERSION}" /assets/install && \
    if [ -d "/build-assets/src" ] ; then cp -Rp /build-assets/src/* /assets/install ; fi; \
    if [ -d "/build-assets/scripts" ] ; then for script in /build-assets/scripts/*.sh; do echo "** Applying $script"; bash $script; done && \ ; fi ; \
    composer install && \
    \
    package cleanup && \
    rm -rf /assets/install/.git \
           /assets/install/*.yml \
           /assets/install/dev \
           /assets/install/php*.xml \
           /assets/install/tests \
           /root/.composer

COPY install /
