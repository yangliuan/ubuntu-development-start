#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start mongod                                  #
################################################################################
"
if [ -e "/lib/systemd/system/mongod.service" ]; then
    if sudo systemctl is-active --quiet mongod.service; then
        echo "Stopping mongod.service"
        sudo systemctl stop mongod.service 
    else
        echo "Starting mongod.service"
        sudo systemctl start mongod.service 
    fi
    sudo systemctl status mongod.service
else
    echo "mongod is not installed"
    sleep 3
fi