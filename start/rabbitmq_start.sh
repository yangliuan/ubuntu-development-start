#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start rabbitmq
####################################################################
"

sudo systemctl start rabbitmq-server.service
sudo systemctl status rabbitmq-server.service