#!/bin/bash
clear
printf "
################################################################################
                               start kafka zookeeper
################################################################################
"
sudo systemctl start zookeeper.service
sudo systemctl status zookeeper.service