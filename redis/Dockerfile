FROM redis:4.0

COPY redis.conf /usr/local/etc/redis/redis.conf
COPY custom.conf /usr/local/etc/redis/custom.conf

RUN echo "include /usr/local/etc/redis/custom.conf">>/usr/local/etc/redis/redis.conf

VOLUME /data
EXPOSE 6379

CMD redis-server /usr/local/etc/redis/redis.conf
