FROM debian:buster
MAINTAINER DreamHack AB <tech@dreamhack.com>

ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default

RUN apt-get update -yqq && apt-get install -yyqq \
apt-transport-https \
ca-certificates \
wget

RUN apt-get update -yqq && apt-get install -yyqq \
git \
openssh-client \
php-imagick \
php7.2-fpm \
php7.2-bcmath \
php7.2-curl \
php7.2-gd \
php7.2-mbstring \
php7.2-mysql \
php7.2-xml \
php7.2-zip \
php7.2-xdebug \
supervisor

# Download trusted certs
RUN mkdir -p /etc/ssl/certs && update-ca-certificates
RUN mkdir -p /var/log/supervisord/apps

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www
CMD ["/usr/bin/supervisord"]
# CMD php ./artisan serve --port=80 --host=0.0.0.0

EXPOSE 80
