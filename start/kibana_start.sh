#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start kibana
####################################################################
"

sudo systemctl start kibana.service
sudo systemctl status kibana.service