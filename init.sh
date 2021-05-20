#!/bin/sh

/etc/init.d/php7.3-fpm start
/etc/init.d/nginx start

exec tail -f /var/log/nginx/*
