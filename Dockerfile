FROM debian:stretch
MAINTAINER Dennis Holmen <dennis.holmen@gmail.com>

RUN apt-get update -yqq
RUN apt-get install dselect
RUN cat /etc/apt/sources.list
COPY packages.to.install.list /
RUN apt-get install -yy $(cat /packages.to.install.list)

# Download trusted certs 
RUN mkdir -p /etc/ssl/certs && update-ca-certificates

# Install composer
RUN php -r "readfile('https://getcomposer.org/installer');" | php && \
   mv composer.phar /usr/bin/composer && \
   chmod +x /usr/bin/composer

WORKDIR /var/www
CMD php ./artisan serve --port=80 --host=0.0.0.0
EXPOSE 80