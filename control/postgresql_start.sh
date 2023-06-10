#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start postgresql                              #
################################################################################
"
if [ -e "/lib/systemd/system/postgresql.service" ]; then
    if sudo systemctl is-active --quiet postgresql.service; then
        echo "Stopping postgresql.service"
        sudo systemctl stop postgresql.service 
    else
        echo "Starting postgresql.service"
        sudo systemctl start postgresql.service 
    fi
    sudo systemctl status postgresql.service
else
    echo "postgresql is not installed"
    sleep 3
fi