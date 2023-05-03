#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                     start kafka zookeeper
####################################################################
"
sudo systemctl start zookeeper.service