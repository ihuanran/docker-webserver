FROM composer

RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

VOLUME /app /tmp

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD composer
