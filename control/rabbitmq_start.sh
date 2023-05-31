#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start rabbitmq                                #
################################################################################
"
sudo systemctl start rabbitmq-server.service
sudo systemctl status rabbitmq-server.service