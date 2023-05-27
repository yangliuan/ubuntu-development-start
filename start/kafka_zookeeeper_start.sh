#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start kafka zookeeper                             #
################################################################################
"
sudo systemctl start zookeeper.service
sudo systemctl status zookeeper.service