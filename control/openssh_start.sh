#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start openssh                                 #
################################################################################
"
if [ -e "/lib/systemd/system/ssh.service" ]; then
    if sudo systemctl is-active --quiet ssh.service; then
        echo "Stopping ssh.service"
        sudo systemctl stop ssh.service 
    else
        echo "Starting ssh.service"
        sudo systemctl start ssh.service 
    fi
    sudo systemctl status ssh.service
else
    echo "ssh is not installed"
    sleep 3
fi