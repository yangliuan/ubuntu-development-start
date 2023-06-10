#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start kibana                                  #
################################################################################
"
if [ -e "/lib/systemd/system/kibana.service" ]; then
    if sudo systemctl is-active --quiet kibana.service; then
        echo "Stopping kibana.service"
        sudo systemctl stop kibana.service 
    else
        echo "Starting kibana.service"
        sudo systemctl start kibana.service 
    fi
    sudo systemctl status kibana.service
else
    echo "kibana is not installed"
    sleep 3
fi