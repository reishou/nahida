FROM alpine:3.18
LABEL Maintainer="Reishou <reishou90@gmail.com>" \
      Description="Lightweight container with Nginx & PHP-FPM 8 based on Alpine Linux."

RUN apk --no-cache add \
    curl \
    nginx \
    php82 \
    php82-bcmath \
    php82-ctype \
    php82-curl \
    php82-dom \
    php82-fileinfo \
    php82-fpm \
    php82-gd \
    php82-iconv \
    php82-json \
    php82-mbstring \
    php82-openssl \
    php82-pdo \
    php82-pdo_mysql \
    php82-pdo_pgsql \
    php82-pdo_sqlite \
    php82-phar \
    php82-redis \
    php82-simplexml \
    php82-session \
    php82-sodium \
    php82-tokenizer \
    php82-xml \
    php82-xmlwriter \
    php82-xmlreader \
    php82-zip \
    runit

RUN cp /usr/bin/php82 /usr/bin/php && \
    cp /usr/sbin/php-fpm82 /usr/sbin/php-fpm

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
