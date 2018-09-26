FROM nginx:alpine

COPY nginx.conf /etc/nginx/

ADD sites/*.conf /etc/nginx/conf.d/

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data