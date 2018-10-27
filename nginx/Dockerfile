FROM nginx:alpine

RUN set -xe \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data

EXPOSE 80 443