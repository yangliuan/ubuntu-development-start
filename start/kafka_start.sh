#!/bin/bash
clear
printf "
################################################################################
                             start zookeeper kafka
################################################################################
"

sudo systemctl start kafka.service
sudo systemctl status kafka.service