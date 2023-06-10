#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                             start redis-server                               #
################################################################################
"
if [ -e "/lib/systemd/system/redis-server.service" ]; then
    if sudo systemctl is-active --quiet redis-server.service; then
        echo "Stopping redis-server.service"
        sudo systemctl stop redis-server.service 
    else
        echo "Starting redis-server.service"
        sudo systemctl start redis-server.service 
    fi
    sudo systemctl status redis-server.service
else
    echo "redis-server is not installed"
    sleep 3
fi