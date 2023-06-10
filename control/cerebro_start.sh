#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start cerebro                                #
################################################################################
"
if [ -e "/lib/systemd/system/cerebro.service" ]; then
    if sudo systemctl is-active --quiet cerebro.service; then
        echo "Stopping cerebro.service"
        sudo systemctl stop cerebro.service 
    else
        echo "Starting cerebro.service"
        sudo systemctl start cerebro.service 
    fi
    sudo systemctl status cerebro.service
else
    echo "cerebro is not installed"
    sleep 3
fi
