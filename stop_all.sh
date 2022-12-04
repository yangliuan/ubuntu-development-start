#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          stop all service      
####################################################################
"

if [ -e "/lib/systemd/system/httpd.service" ]; then
    systemctl stop httpd.service
fi

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

if [ -e "/usr/bin/supervisorctl" ]; then
    sudo supervisorctl stop all
fi

if [ -e "/lib/systemd/system/supervisor.service" ]; then
    systemctl stop supervisor.service
fi

if [ -e "/lib/systemd/system/pureftpd.service" ]; then
    systemctl stop pureftpd.service
fi

if [ -e "/lib/systemd/system/cerebro.service" ]; then
    systemctl stop cerebro.service
fi

if [ -e "/lib/systemd/system/kafka.service" ]; then
    systemctl stop kafka.service
fi

if [ -e "/lib/systemd/system/rabbitmq-server.service" ]; then
    systemctl stop rabbitmq-server.service
fi

echo "stop all service successed!"