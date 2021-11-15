FROM alpine:3.14
LABEL Maintainer="Reishou <reishou90@gmail.com>" \
      Description="Lightweight container with Nginx & PHP-FPM 8 based on Alpine Linux."

RUN apk --no-cache add \
    php8  \
    php8-fpm  \
    php8-bcmath  \
    php8-ctype  \
    php8-fileinfo \
    php8-json  \
    php8-mbstring  \
    php8-openssl  \
    php8-pdo_pgsql  \
    php8-curl  \
    php8-pdo  \
    php8-tokenizer  \
    php8-xml \
    php8-phar \
    php8-dom \
    php8-gd \
    php8-iconv \
    php8-xmlwriter \
    php8-xmlreader \
    php8-zip \
    php8-simplexml \
    nginx  \
    curl  \
    runit

RUN cp /usr/bin/php8 /usr/bin/php

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configure nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites/*.conf /etc/nginx/http.d/
# Remove default server definition
RUN rm /etc/nginx/http.d/default.conf

# Configure PHP-FPM
COPY fpm-pool.conf /etc/php8/php-fpm.d/www.conf
COPY php.ini /etc/php8/conf.d/custom.ini

# Configure runit boot script
COPY boot.sh /sbin/boot.sh

RUN adduser -D -u 1000 -g 1000 -s /bin/sh www && \
    mkdir -p /var/www/html && \
    mkdir -p /var/cache/nginx && \
    chown -R www:www /var/www/html && \
    chown -R www:www /run && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/log/nginx

COPY nginx.run /etc/service/nginx/run
COPY php.run /etc/service/php/run

RUN chmod +x /etc/service/nginx/run \
    && chmod +x /etc/service/php/run \
    && ls -al /var/www/html/

WORKDIR /var/www/html

# Expose the port nginx is reachable on
EXPOSE 80

# Let boot start nginx & php-fpm
CMD ["sh", "/sbin/boot.sh"]

