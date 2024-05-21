#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start memcached                                 #
################################################################################
"
if [ -e "/lib/systemd/system/memcached.service" ]; then
    if sudo systemctl is-active --quiet memcached.service; then
        echo "Stopping memcached.service"
        sudo systemctl stop memcached.service
    else
        echo "Starting memcached.service"
        sudo systemctl start memcached.service 
    fi
    sudo systemctl status memcached.service
else
    echo "memcached is not installed"
    sleep 3
fi