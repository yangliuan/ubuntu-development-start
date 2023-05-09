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
    echo "stop httpd success!"
fi

if [ -e "/lib/systemd/system/nginx.service" ]; then
    sudo systemctl stop nginx.service
    echo "stop nginx success!"
fi

if [ -e "/etc/init.d/tomcat" ]; then
    sudo systemctl stop tomcat.service
    echo "stop tomcat success!"
fi

if [ -e "/lib/systemd/system/php-fpm.service" ]; then
    sudo systemctl stop php-fpm.service
    echo "stop php-fpm success!"
fi

if [ -e "/etc/init.d/mysqld" ]; then
    sudo systemctl stop mysql.service
    echo "stop mysql success!"
fi

if [ -e "/lib/systemd/system/redis-server.service" ]; then
    sudo systemctl stop redis-server.service
    echo "stop redis-server success!"
fi

if [ -e "/etc/init.d/memcached" ]; then
    sudo systemctl stop memcached.service
    echo "stop memcached success!"
fi

if [ -e "/lib/systemd/system/mongod.service" ]; then
    sudo systemctl stop mongod.service
    echo "stop mongod success!"
fi

if [ -e "/lib/systemd/system/postgresql.service" ]; then
    sudo systemctl stop postgresql.service
    echo "stop postgresql success!"
fi

if [ -e "/lib/systemd/system/supervisor.service" ]; then
     if [ -e "/var/run/supervisor.sock" ]; then
        sudo supervisorctl stop all
        echo "stop supervisord success!"
    fi
fi

if [ -e "/lib/systemd/system/pureftpd.service" ]; then
    sudo systemctl stop pureftpd.service
    echo "stop pureftpd success!"
fi

if [ -e "/lib/systemd/system/cerebro.service" ]; then
    sudo systemctl stop cerebro.service
    echo "stop cerebro success!"
fi

if [ -e "/lib/systemd/system/kafka.service" ]; then
    sudo systemctl stop kafka.service
    echo "stop kafka success!"
fi

if [ -e "/lib/systemd/system/rabbitmq-server.service" ]; then
    sudo systemctl stop rabbitmq-server.service
    echo "stop rabbitmq-server success!"
fi

if [ -e "/usr/local/php/bin/php" ]; then
    if pgrep php > /dev/null
    then
        sudo killall -9 php
        echo "kill php process success!"
    fi
fi

echo "stop all service successed!"
sleep 10
