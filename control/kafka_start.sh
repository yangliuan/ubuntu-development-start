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
    sudo systemctl start zookeeper-inkafka.service
    services="zookeeper-inkafka.service "
fi

if [ -e "/lib/systemd/system/kafka.service" ]; then
    sudo systemctl start kafka.service
    services="${services}kafka.service"
fi

sudo systemctl status $services