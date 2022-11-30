#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          stop all service      
####################################################################
"

if [ -e "/lib/systemd/system/nginx.service" ]; then
    systemctl stop nginx.service
fi

if [ -e "/lib/systemd/system/php-fpm.service" ]; then
    systemctl stop php-fpm.service
fi

if [ -e "/etc/init.d/mysqld/mysql.server" ]; then
    systemctl stop mysql.service
fi

if [ -e "/lib/systemd/system/redis-server.service" ]; then
    systemctl stop redis-server.service
fi

if [ -e "/etc/init.d/memcached" ]; then
    systemctl stop memcached.service
fi

if [ -e "/lib/systemd/system/mongod.service" ]; then
    systemctl stop mongod.service
fi

if [ -e "/lib/systemd/system/postgresql.service" ]; then
    systemctl stop postgresql.service
fi

echo "stop all service successed!"