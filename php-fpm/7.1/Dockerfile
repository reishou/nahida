FROM php:7.1-fpm-alpine

ENV DEBIAN_FRONTEND noninteractive

RUN apk update \
    && apk upgrade \
    && docker-php-ext-install \
        pdo_mysql

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9001