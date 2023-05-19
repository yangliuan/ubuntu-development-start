#!/bin/bash
clear
printf "
################################################################################
                                start rabbitmq
################################################################################
"

sudo systemctl start rabbitmq-server.service
sudo systemctl status rabbitmq-server.service