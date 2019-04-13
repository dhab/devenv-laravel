FROM debian:buster
MAINTAINER DreamHack AB <tech@dreamhack.com>

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default

RUN apt-get update -yqq && apt-get install -yyqq \
apt-transport-https \
ca-certificates \
wget \
curl \
procps \
vim \
tcpdump \
git \
openssh-client

RUN apt-get install -yyqq \
nginx \
php-imagick \
libmagickcore-6.q16-6-extra \
php7.3-fpm \
php7.3-xdebug \
php7.3-bcmath \
php7.3-curl \
php7.3-gd \
php7.3-mbstring \
php7.3-mysql \
php7.3-xml \
php7.3-zip

# Download trusted certs
RUN mkdir -p /etc/ssl/certs && update-ca-certificates
RUN mkdir -p /var/log/supervisord/apps

# Install sentry-cli
RUN curl -sL https://sentry.io/get-cli/ | bash

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

WORKDIR /var/www

ADD init.sh /
CMD ["/init.sh"]

EXPOSE 80
