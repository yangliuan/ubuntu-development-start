#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start mongodb
####################################################################
"

sudo systemctl start mongod.service
sudo systemctl status mongod.service