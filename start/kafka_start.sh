#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start zookeeper kafka                             #
################################################################################
"
sudo systemctl start kafka.service
sudo systemctl status kafka.service