#!/bin/sh
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
systemctl stop nginx.service
systemctl stop php-fpm.service
systemctl stop mysqld.service
systemctl stop redis-server.service
systemctl stop supervisor.service
service memcached stop