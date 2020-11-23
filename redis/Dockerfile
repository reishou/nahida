FROM redis:5-alpine

RUN set -xe \
    && apk add --no-cache bash

EXPOSE 6379

CMD ["redis-server"]
