#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start rabbitmq                                #
################################################################################
"
if [ -e "/lib/systemd/system/rabbitmq-server.service" ]; then
    if sudo systemctl is-active --quiet rabbitmq-server.service; then
        echo "Stopping rabbitmq-server.service"
        sudo systemctl stop rabbitmq-server.service 
    else
        echo "Starting rabbitmq-server.service"
        sudo systemctl start rabbitmq-server.service 
    fi
    sudo systemctl status rabbitmq-server.service
else
    echo "rabbitmq-server is not installed"
    sleep 3
fi