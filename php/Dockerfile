FROM php:7.3-fpm

ENV SWOOLE_VERSION=4.1.2

ARG app_env=development

COPY php.ini-$app_env /usr/local/etc/php
COPY php.ini /usr/local/etc/php/conf.d

RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        zlib1g-dev \
        libzip-dev \
	&& docker-php-ext-install pdo_mysql \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install zip \
	&& docker-php-ext-install bcmath \
	&& pecl install swoole-$SWOOLE_VERSION \
    && docker-php-ext-enable swoole \
    && docker-php-ext-install sockets \
    && docker-php-ext-install pcntl \
	&& mv /usr/local/etc/php/php.ini-$app_env /usr/local/etc/php/php.ini \
    && mkdir /log \
    && mkdir -p /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
VOLUME /log /usr/share/nginx/html
EXPOSE 9000

CMD php-fpm
