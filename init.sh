#!/bin/sh

/etc/init.d/php7.3-fpm start
/etc/init.d/nginx start

tail -f /var/log/nginx/*
