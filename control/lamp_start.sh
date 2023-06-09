#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start lamp                                   #
################################################################################
"
services=""
if [ -e "/lib/systemd/system/httpd.service" ]; then
    sudo systemctl start httpd.service
    services="httpd.service"
fi

if [ -e "/lib/systemd/system/php-fpm.service" ]; then
    sudo systemctl start php-fpm.service
    services="${services}php-fpm.service "
fi

if [ -e "/etc/init.d/mysqld" ]; then
    sudo systemctl start mysqld.service
    services="${services}mysqld.service"
fi

sudo systemctl status $services