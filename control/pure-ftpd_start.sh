#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start pureftpd                                #
################################################################################
"
if [ -e "/lib/systemd/system/pureftpd.service" ]; then
    if sudo systemctl is-active --quiet pureftpd.service; then
        echo "Stopping pureftpd.service"
        sudo systemctl stop pureftpd.service 
    else
        echo "Starting pureftpd.service"
        sudo systemctl start pureftpd.service 
    fi
    sudo systemctl status pureftpd.service
else
    echo "pureftpd is not installed"
    sleep 3
fi