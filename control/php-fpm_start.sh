#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  start php-fpm                               #
################################################################################
"
if [ -e "/lib/systemd/system/php-fpm.service" ]; then
    if sudo systemctl is-active --quiet php-fpm.service; then
        echo "Stopping php-fpm.service"
        sudo systemctl stop php-fpm.service 
    else
        echo "Starting php-fpm.service"
        sudo systemctl start php-fpm.service 
    fi
    sudo systemctl status php-fpm.service
else
    echo "php-fpm is not installed"
    sleep 3
fi
