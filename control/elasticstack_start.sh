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
    if sudo systemctl is-active --quiet elasticsearch.service; then
        echo "Stopping elasticsearch.service"
        sudo systemctl stop elasticsearch.service 
    else
        echo "Starting elasticsearch.service"
        sudo systemctl start elasticsearch.service 
    fi
    services="elasticsearch.service "
fi

if [ -e "/lib/systemd/system/kibana.service" ]; then
    if sudo systemctl is-active --quiet kibana.service; then
        echo "Stopping kibana.service"
        sudo systemctl stop kibana.service 
    else
        echo "Starting kibana.service"
        sudo systemctl start kibana.service 
    fi
    services="${services}kibana.service "
fi

if [ -e "/lib/systemd/system/logstash.service" ]; then
    if sudo systemctl is-active --quiet logstash.service; then
        echo "Stopping logstash.service"
        sudo systemctl stop logstash.service 
    else
        echo "Starting logstash.service"
        sudo systemctl start logstash.service 
    fi
    services="${services}logstash.service "
fi

if [ -e "/lib/systemd/system/filebeat.service" ]; then
    if sudo systemctl is-active --quiet filebeat.service; then
        echo "Stopping filebeat.service"
        sudo systemctl stop filebeat.service 
    else
        echo "Starting filebeat.service"
        sudo systemctl start filebeat.service 
    fi
    services="${services}filebeat.service "
fi

if [ -e "/lib/systemd/system/packetbeat.service" ]; then
    if sudo systemctl is-active --quiet packetbbeat.service; then
        echo "Stopping packetbbeat.service"
        sudo systemctl stop packetbbeat.service 
    else
        echo "Starting packetbbeat.service"
        sudo systemctl start packetbbeat.service 
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
    echo "elastic stack is not installed"
    sleep 3
else
    sudo systemctl status $services
fi
