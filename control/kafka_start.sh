#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start kafka & zookeeper                           #
################################################################################
"
services=""
if [ -e "/lib/systemd/system/zookeeper-inkafka.service" ]; then
    if sudo systemctl is-active --quiet zookeeper-inkafka.service.service; then
        echo "Stopping zookeeper-inkafka.service"
        sudo systemctl stop zookeeper-inkafka.service 
    else
        echo "Starting zookeeper-inkafka.service."
        sudo systemctl start zookeeper-inkafka.service 
    fi
    services="zookeeper-inkafka.service "
fi

if [ -e "/lib/systemd/system/kafka.service" ]; then
    if sudo systemctl is-active --quiet kafka.service; then
        echo "Stopping kafka.service"
        sudo systemctl stop kafka.service 
    else
        echo "Starting kafka.service"
        sudo systemctl start kafka.service. 
    fi
    services="${services}kafka.service"
fi

if [ -z "${services}" ]; then
    echo "apache kafka is not installed"
    sleep 3
else
    sudo systemctl status $services
fi