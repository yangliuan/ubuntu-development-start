#!/bin/bash
clear
printf "
################################################################################
                                start rabbitmq
################################################################################
"

sudo systemctl start rocketmq-namesrv.service
sudo systemctl start rocketmq-broker.service
sudo systemctl status rocketmq-namesrv.service rocketmq-broker.service