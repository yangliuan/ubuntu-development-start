#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start logstash                                 #
################################################################################
"
sudo systemctl start logstash.service
sudo systemctl status logstash.service