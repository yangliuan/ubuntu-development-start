#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start rabbitmq
####################################################################
"

sudo systemctl start rocketmq-namesrv.service
sudo systemctl start rocketmq-broker.service
sudo systemctl status rocketmq-namesrv.service
sudo systemctl status rocketmq-broker.service