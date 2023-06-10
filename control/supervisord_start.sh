#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start supervisor                               #
################################################################################
"
if [ -e "/lib/systemd/system/supervisor.service" ]; then
    if sudo systemctl is-active --quiet supervisor.service; then
        echo "Stopping supervisor.service"
        sudo systemctl stop supervisor.service 
    else
        echo "Starting supervisor.service"
        sudo systemctl start supervisor.service 
    fi
    sudo systemctl status supervisor.service
else
    echo "supervisor is not installed"
    sleep 3
fi