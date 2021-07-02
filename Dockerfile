FROM php:7.4.21-cli
MAINTAINER Shane Mc Cormack <dataforce@dataforce.org.uk>

COPY errors.ini /usr/local/etc/php/conf.d/errors.ini

RUN \
  apt-get update && apt-get install -y git unzip libz-dev libmemcached-dev libicu-dev libonig-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev && \
  ln -s /usr/local/bin/php /usr/bin/php && \
  docker-php-source extract && \
  docker-php-ext-install bcmath && \
  docker-php-ext-install pcntl && \
  docker-php-ext-install mbstring && \
  docker-php-ext-install pdo_mysql && \
  docker-php-ext-install mysqli && \
  docker-php-ext-install intl && \
  docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp && \
  docker-php-ext-install gd && \
  pecl install -o -f memcached && \
  docker-php-ext-enable memcached && \
  pecl install -o -f redis && \
  rm -rf /tmp/pear && \
  docker-php-ext-enable redis && \
  docker-php-source delete && \
  curl -sS https://getcomposer.org/installer | php -- --no-ansi --install-dir=/usr/bin --filename=composer
