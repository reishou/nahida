FROM php:7-fpm-alpine

RUN set -xe \
    && apk add --no-cache bash \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql

EXPOSE 80
