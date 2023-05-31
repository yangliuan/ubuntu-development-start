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
    sudo systemctl start filebeat.service
    services+="filebeat.service "
fi

if [ -e "/lib/systemd/system/packetbeat.service" ]; then
    sudo systemctl start packetbeat.service
    services+="packetbeat.service "
fi

if [ -e "/lib/systemd/system/metricbeat.service" ]; then
    sudo systemctl start metricbeat.service
    services+="metricbeat.service "
fi

if [ -e "/lib/systemd/system/heartbeat-elastic.service" ]; then
    sudo systemctl start heartbeat-elastic.service
    services+="heartbeat-elastic.service "
fi

if [ -e "/lib/systemd/system/auditbeat.service" ]; then
    sudo systemctl start auditbeat.service
    services+="auditbeat.service "
fi

# 输出所有服务的状态
sudo systemctl status $services
