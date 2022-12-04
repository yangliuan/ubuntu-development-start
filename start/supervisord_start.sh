#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start supervisor
####################################################################
"

sudo systemctl start supervisor.service
sudo systemctl status supervisor.service