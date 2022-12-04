#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                     start zookeeper kafka
####################################################################
"
sudo systemctl start zookeeper.service
sudo systemctl start kafka.service