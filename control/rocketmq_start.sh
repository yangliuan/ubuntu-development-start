#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start rabbitmq                                 #
################################################################################
"
services=""
if [ -e "/lib/systemd/system/rocketmq-namesrv.service" ]; then
    if sudo systemctl is-active --quiet rocketmq-namesrv.service; then
        echo "Stopping rocketmq-namesrv.service"
        sudo systemctl stop rocketmq-namesrv.service 
    else
        echo "Starting rocketmq-namesrv.service"
        sudo systemctl start rocketmq-namesrv.service 
    fi
    services="rocketmq-namesrv.service "
fi

if [ -e "/lib/systemd/system/rocketmq-broker.service" ]; then
    if sudo systemctl is-active --quiet rocketmq-broker.service; then
        echo "Stopping rocketmq-broker.service"
        sudo systemctl stop rocketmq-broker.service 
    else
        echo "Starting rocketmq-broker.service"
        sudo systemctl start rocketmq-broker.service 
    fi
    services="rocketmq-broker.service"
fi

if [ -z "${services}" ]; then
    echo "rocketmq is not installed"
    sleep 3
else
    sudo systemctl status $services
fi
