FROM php:fpm
MAINTAINER Dennis Holmen <dennis.holmen@gmail.com>

RUN apt-get update 
RUN apt-get upgrade 
RUN apt-get openssh-client install git libcurl4-gnutls-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libwebp-dev openldap-dev postgresql-dev jpeg-dev icu-dev gettext-dev freetype-dev freetds-dev freetds freetype icu libintl libldap libjpeg libmcrypt libpng libpg libwebp

# Install PHP extensions
ADD install-php.sh /usr/sbin/install-php.sh
RUN /usr/sbin/install-php.sh

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80