#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start elasticsearch                               #
################################################################################
"
if [ -e "/lib/systemd/system/elasticsearch.service" ]; then
    if sudo systemctl is-active --quiet elasticsearch.service; then
        echo "Stopping elasticsearch.service"
        sudo systemctl stop elasticsearch.service 
    else
        echo "Starting elasticsearch.service"
        sudo systemctl start elasticsearch.service 
    fi
    sudo systemctl status elasticsearch.service
else
    echo "elasticsearch is not installed"
    sleep 3
fi