#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                              stop all service                                #
################################################################################
"
# web server
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

# database 
if [ -e "/etc/init.d/mysqld" ]; then
    sudo systemctl stop mysql.service
    echo "stop mysql success!"
fi

if [ -e "/lib/systemd/system/postgresql.service" ]; then
    sudo systemctl stop postgresql.service
    echo "stop postgresql success!"
fi

if [ -e "/lib/systemd/system/mongod.service" ]; then
    sudo systemctl stop mongod.service
    echo "stop mongod success!"
fi

# cache
if [ -e "/lib/systemd/system/redis-server.service" ]; then
    sudo systemctl stop redis-server.service
    echo "stop redis-server success!"
fi

if [ -e "/etc/init.d/memcached" ]; then
    sudo systemctl stop memcached.service
    echo "stop memcached success!"
fi

# other
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

# mssage queue
if [ -e "/lib/systemd/system/zookeeper.service" ]; then
    sudo systemctl stop zookeeper.service
    echo "stop zookeeper success!"
fi

if [ -e "/lib/systemd/system/kafka.service" ]; then
    sudo systemctl stop kafka.service
    echo "stop kafka success!"
fi

if [ -e "/lib/systemd/system/rabbitmq-server.service" ]; then
    sudo systemctl stop rabbitmq-server.service
    echo "stop rabbitmq-server success!"
fi

if [ -e "/lib/systemd/system/rocketmq-namesrv.service" ]; then
    sudo systemctl stop rocketmq-namesrv.service
    echo "stop rocketmq-namesrv success!"
fi

if [ -e "/lib/systemd/system/rocketmq-broker.service" ]; then
    sudo systemctl stop rocketmq-broker.service
    echo "stop rocketmq-broker success!"
fi

# elastic stack
if [ -e "/lib/systemd/system/elasticsearch.service" ]; then
    sudo systemctl stop elasticsearch.service
    echo "stop elasticsearch.service success!"
fi

if [ -e "/lib/systemd/system/kibana.service" ]; then
    sudo systemctl stop kibana.service
    echo "stop kibana.service success!"
fi

if [ -e "/lib/systemd/system/logstash.service" ]; then
    sudo systemctl stop logstash.service
    echo "stop logstash.service success!"
fi

if [ -e "/lib/systemd/system/cerebro.service" ]; then
    sudo systemctl stop cerebro.service
    echo "stop cerebro.service success!"
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
