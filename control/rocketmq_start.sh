#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start rabbitmq                                 #
################################################################################
"
sudo systemctl start rocketmq-namesrv.service
sudo systemctl start rocketmq-broker.service
sudo systemctl status rocketmq-namesrv.service rocketmq-broker.service