FROM php:fpm
MAINTAINER Dennis Holmen <dennis.holmen@gmail.com>

RUN apt-get update -yqq
RUN apt-get install openssh-client git libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libwebp-dev libjpeg62-turbo-dev libaio-dev libgearman-dev libmemcached-dev libssl-dev freetds-dev -yqq

# Configure extensions
RUN docker-php-ext-configure gd --with-jpeg-dir=usr/ --with-freetype-dir=usr/ --with-webp-dir=usr/
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-configure pdo_dblib --with-libdir=/lib/x86_64-linux-gnu/

# Download mongo extension
RUN /usr/local/bin/pecl download mongodb && \
    tar -C /usr/src/php/ext -xf mongo*.tgz && \
    rm mongo*.tgz && \
    mv /usr/src/php/ext/mongo* /usr/src/php/ext/mongodb

RUN docker-php-ext-install \
    bcmath \
    bz2 \
    exif \
    gd \
    gettext \
    intl \
    ldap \
    mbstring \
    mcrypt \
    mongodb \
    opcache \
    pdo_dblib \
    pdo_mysql \
    pdo_pgsql \
    soap \
    xml \
    xmlrpc \
    zip

# Download trusted certs 
RUN mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

# Download trusted certs 
RUN mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80