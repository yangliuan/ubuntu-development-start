#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start mongodb
####################################################################
"

sudo systemctl start mongodb.service
sudo systemctl status mongodb.service