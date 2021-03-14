FROM alpine:3.13
LABEL Maintainer="Reishou <reishou90@gmail.com>" \
      Description="Lightweight container with Nginx & PHP-FPM 7 based on Alpine Linux."

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-bcmath php7-ctype php7-json php7-fileinfo \
    php7-mbstring php7-openssl php7-pdo_mysql php7-curl php7-pdo php7-tokenizer php7-xml \
    php7-opcache nginx curl runit openrc composer php7-simplexml php7-dom php7-xmlwriter

# Configure nginx
COPY nginx.conf /etc/nginx/nginx.conf
ADD sites/*.conf /etc/nginx/conf.d/
# Remove default server definition
RUN rm /etc/nginx/conf.d/default.conf

# Configure PHP-FPM
COPY fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY php.ini /etc/php7/conf.d/custom.ini

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

# Expose the port nginx is reachable on
EXPOSE 80

# Let boot start nginx & php-fpm
CMD ["sh", "/sbin/boot.sh"]

