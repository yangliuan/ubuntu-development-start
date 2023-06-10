#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  start mysqld                                #
################################################################################
"
if [ -e "/etc/init.d/mysqld" ]; then
    if sudo systemctl is-active --quiet mysqld.service; then
        echo "Stopping mysqld.service"
        sudo systemctl stop mysqld.service 
    else
        echo "Starting mysqld.service"
        sudo systemctl start mysqld.service 
    fi
    sudo systemctl status mysqld.service
else
    echo "mysqld is not installed"
    sleep 3
fi