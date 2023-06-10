#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start mongodb                                  #
################################################################################
"
if [ -e "/lib/systemd/system/mongodb.service" ]; then
    if sudo systemctl is-active --quiet mongodb.service; then
        echo "Stopping mongodb.service"
        sudo systemctl stop mongodb.service 
    else
        echo "Starting mongodb.service"
        sudo systemctl start mongodb.service 
    fi
    sudo systemctl status mongodb.service
else
    echo "mongodb is not installed"
    sleep 3
fi