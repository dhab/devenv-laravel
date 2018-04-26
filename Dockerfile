FROM debian:stretch
MAINTAINER Dennis Holmen <dennis.holmen@gmail.com>


ENV QUEUE_CONNECTION=redis
ENV QUEUE_NAME=default

RUN apt-get update -yqq && apt-get install -yyqq \
apt-transport-https \
ca-certificates \
wget

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN sh -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update -yqq && apt-get install -yyqq \
git \
openssh-client \
php-imagick \
php7.1-fpm \
php7.1-bcmath \
php7.1-curl \
php7.1-fpm \
php7.1-gd \
php7.1-mbstring \
php7.1-mysql \
php7.1-xml \
php7.1-zip \
php7.1-xdebug \
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
