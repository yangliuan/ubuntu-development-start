#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start beats                                  #
################################################################################
"
services=""
if [ -e "/lib/systemd/system/filebeat.service" ]; then
    if sudo systemctl is-active --quiet filebeat.service; then
        echo "Stopping filebeat.service"
        sudo systemctl stop filebeat.service
    else
        echo "Starting filebeat.service"
        sudo systemctl start filebeat.service
    fi
    services="filebeat.service"
fi

if [ -e "/lib/systemd/system/packetbeat.service" ]; then
    if sudo systemctl is-active --quiet packetbeat.service; then
        echo "Stopping packetbeat.service"
        sudo systemctl stop packetbeat.service
    else
        echo "Starting packetbeat.service"
        sudo systemctl start packetbeat.service
    fi
    services="${services}packetbeat.service "
fi

if [ -e "/lib/systemd/system/metricbeat.service" ]; then
    if sudo systemctl is-active --quiet metricbeat.service; then
        echo "Stopping metricbeat.service"
        sudo systemctl stop metricbeat.service
    else
        echo "Starting metricbeat.service"
        sudo systemctl start metricbeat.service
    fi
    services="${services}metricbeat.service "
fi

if [ -e "/lib/systemd/system/heartbeat-elastic.service" ]; then
    if sudo systemctl is-active --quiet heartbeat-elastic.service; then
        echo "Stopping heartbeat-elastic.service"
        sudo systemctl stop heartbeat-elastic.service
    else
        echo "Starting heartbeat-elastic.service"
        sudo systemctl start heartbeat-elastic.service
    fi
    services="${services}heartbeat-elastic.service "
fi

if [ -e "/lib/systemd/system/auditbeat.service" ]; then
    if sudo systemctl is-active --quiet auditbeat.service; then
        echo "Stopping auditbeat.service"
        sudo systemctl stop auditbeat.service
    else
        echo "Starting auditbeat.service"
        sudo systemctl start auditbeat.service
    fi
    services="${services}auditbeat.service"
fi

if [ -z "${services}" ]; then
    echo "beats is not installed"
    sleep 3
else
    sudo systemctl status $services
fi
