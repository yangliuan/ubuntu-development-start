#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          stop all service      
####################################################################
"

if [ -e "/lib/systemd/system/httpd.service" ]; then
    sudo systemctl stop httpd.service
fi

if [ -e "/lib/systemd/system/nginx.service" ]; then
    sudo systemctl stop nginx.service
fi

if [ -e "/lib/systemd/system/php-fpm.service" ]; then
    sudo systemctl stop php-fpm.service
fi

if [ -e "/etc/init.d/mysqld" ]; then
    sudo systemctl stop mysql.service
fi

if [ -e "/lib/systemd/system/redis-server.service" ]; then
    sudo systemctl stop redis-server.service
fi

if [ -e "/etc/init.d/memcached" ]; then
    sudo systemctl stop memcached.service
fi

if [ -e "/lib/systemd/system/mongod.service" ]; then
    sudo systemctl stop mongod.service
fi

if [ -e "/lib/systemd/system/postgresql.service" ]; then
    sudo systemctl stop postgresql.service
fi

if [ -e "/usr/bin/supervisorctl" ]; then
    if [ -e "/var/run/supervisor.sock" ]; then
        sudo supervisorctl stop all
    fi
fi

if [ -e "/lib/systemd/system/supervisor.service" ]; then
    sudo systemctl stop supervisor.service
fi

if [ -e "/lib/systemd/system/pureftpd.service" ]; then
    sudo systemctl stop pureftpd.service
fi

if [ -e "/lib/systemd/system/cerebro.service" ]; then
    sudo systemctl stop cerebro.service
fi

if [ -e "/lib/systemd/system/kafka.service" ]; then
    sudo systemctl stop kafka.service
fi

if [ -e "/lib/systemd/system/rabbitmq-server.service" ]; then
    sudo systemctl stop rabbitmq-server.service
fi

if [ -e "/usr/local/php/bin/php" ]; then
    if pgrep myprocess > /dev/null
    then
        sudo killall -9 php
    fi
fi

echo "stop all service successed!"
sleep 5
