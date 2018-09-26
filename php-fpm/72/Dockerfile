FROM php:7.2-fpm-alpine

ENV DEBIAN_FRONTEND noninteractive

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000