#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start logstash                                 #
################################################################################
"
if [ -e "/lib/systemd/system/logstash.service" ]; then
    if sudo systemctl is-active --quiet logstash.service; then
        echo "Stopping logstash.service"
        sudo systemctl stop logstash.service 
    else
        echo "Starting logstash.service"
        sudo systemctl start logstash.service 
    fi
    sudo systemctl status logstash.service
else
    echo "logstash is not installed"
    sleep 3
fi
