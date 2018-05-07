FROM php:7.2-fpm

ARG app_env=development

COPY php.ini-$app_env /usr/local/etc/php
COPY php.ini /usr/local/etc/php/conf.d

RUN docker-php-ext-install pdo_mysql \
	&& mv /usr/local/etc/php/php.ini-$app_env /usr/local/etc/php/php.ini \
    && mkdir /log \
    && mkdir -p /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
VOLUME /log /usr/share/nginx/html
EXPOSE 9000

CMD php-fpm
