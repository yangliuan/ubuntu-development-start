#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start lnpm                                   #
################################################################################
"
services=""
if [ -e "/lib/systemd/system/nginx.service" ]; then
    if sudo systemctl is-active --quiet nginx.service; then
        echo "Stopping nginx.service"
        sudo systemctl stop nginx.service 
    else
        echo "Starting nginx.service"
        sudo systemctl start nginx.service 
    fi
    services="nginx.service "
fi

if [ -e "/lib/systemd/system/php-fpm.service" ]; then
    if sudo systemctl is-active --quiet php-fpm.service; then
        echo "Stopping php-fpm.service"
        sudo systemctl stop php-fpm.service 
    else
        echo "Starting php-fpm.service"
        sudo systemctl start php-fpm.service 
    fi
    services="${services}php-fpm.service "
fi

if [ -e "/etc/init.d/mysqld" ]; then
    if sudo systemctl is-active --quiet mysqld.service; then
        echo "Stopping mysqld.service"
        sudo systemctl stop mysqld.service 
    else
        echo "Starting mysqld.service"
        sudo systemctl start mysqld.service 
    fi
    services="${services}mysqld.service"
fi

if [ -z "${services}" ]; then
    echo "lnmp is not installed"
    sleep 3
else
    sudo systemctl status $services
fi