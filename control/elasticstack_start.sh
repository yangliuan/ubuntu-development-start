#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start elastic stack                               #
################################################################################
"
services=""
if [ -e "/lib/systemd/system/elasticsearch.service" ]; then
    sudo systemctl start elasticsearch.service
    services="elasticsearch.service"
fi

if [ -e "/lib/systemd/system/kibana.service" ]; then
    sudo systemctl start kibana.service
    services="${services}kibana.service "
fi

if [ -e "/lib/systemd/system/logstash.service" ]; then
    sudo systemctl start logstash.service
    services="${services}logstash.service "
fi

if [ -e "/lib/systemd/system/filebeat.service" ]; then
    sudo systemctl start filebeat.service
    services="${services}filebeat.service "
fi

if [ -e "/lib/systemd/system/packetbeat.service" ]; then
    sudo systemctl start packetbeat.service
    services="${services}packetbeat.service "
fi

if [ -e "/lib/systemd/system/metricbeat.service" ]; then
    sudo systemctl start metricbeat.service
    services="${services}metricbeat.service "
fi

if [ -e "/lib/systemd/system/heartbeat-elastic.service" ]; then
    sudo systemctl start heartbeat-elastic.service
    services="${services}heartbeat-elastic.service "
fi

if [ -e "/lib/systemd/system/auditbeat.service" ]; then
    sudo systemctl start auditbeat.service
    services="${services}auditbeat.service"
fi

sudo systemctl status $services