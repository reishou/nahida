FROM php:7-fpm-alpine

RUN set -xe \
    && apk add --no-cache \
        bash \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
    && pecl install xdebug-2.6.1 \
    && docker-php-ext-enable \
        xdebug \
    && apk del .build-deps \
    && rm -rf /tmp/*

EXPOSE 80
