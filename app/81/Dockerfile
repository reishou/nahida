FROM alpine:3.17
LABEL Maintainer="Reishou <reishou90@gmail.com>" \
      Description="Lightweight container with Nginx & PHP-FPM 8 based on Alpine Linux."

RUN apk --no-cache add \
    curl \
    nginx \
    php81 \
    php81-bcmath \
    php81-ctype \
    php81-curl \
    php81-dom \
    php81-fileinfo \
    php81-fpm \
    php81-gd \
    php81-iconv \
    php81-json \
    php81-mbstring \
    php81-openssl \
    php81-pdo \
    php81-pdo_mysql \
    php81-pdo_pgsql \
    php81-pdo_sqlite \
    php81-phar \
    php81-redis \
    php81-simplexml \
    php81-session \
    php81-sodium \
    php81-tokenizer \
    php81-xml \
    php81-xmlwriter \
    php81-xmlreader \
    php81-zip \
    runit

RUN cp /usr/bin/php81 /usr/bin/php && \
    cp /usr/sbin/php-fpm81 /usr/sbin/php-fpm

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configure nginx
COPY ./../shared/nginx.conf /etc/nginx/nginx.conf
COPY ./../shared/sites/*.conf /etc/nginx/http.d/
#COPY ssl /etc/nginx/ssl
# Remove default server definition
RUN rm /etc/nginx/http.d/default.conf

# Configure PHP-FPM
COPY ./../shared/fpm-pool.conf /etc/php81/php-fpm.d/www.conf
COPY ./../shared/php.ini /etc/php81/conf.d/custom.ini

# Configure runit boot script
COPY ./../shared/boot.sh /sbin/boot.sh

RUN adduser -D -u 1000 -g 1000 -s /bin/sh www && \
    mkdir -p /var/www/html && \
    mkdir -p /var/cache/nginx && \
    chown -R www:www /var/www/html && \
    chown -R www:www /run && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /var/log/nginx

COPY ./../shared/nginx.run /etc/service/nginx/run
COPY ./../shared/php.run /etc/service/php/run

RUN chmod +x /etc/service/nginx/run \
    && chmod +x /etc/service/php/run \
    && ls -al /var/www/html/

WORKDIR /var/www/html

# Expose the port nginx is reachable on
EXPOSE 80
#EXPOSE 443

# Let boot start nginx & php-fpm
CMD ["sh", "/sbin/boot.sh"]
