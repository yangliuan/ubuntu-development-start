#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start apached httpd                               #
################################################################################
"
if [ -e "/lib/systemd/system/httpd.service" ]; then
    if sudo systemctl is-active --quiet httpd.service; then
        echo "Stopping httpd.service"
        sudo systemctl stop httpd.service 
    else
        echo "Starting httpd.service"
        sudo systemctl start httpd.service 
    fi
    sudo systemctl status httpd.service
else
    echo "apached httpd is not installed"
    sleep 3
fi