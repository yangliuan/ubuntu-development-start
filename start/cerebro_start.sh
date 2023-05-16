#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start cerebro
####################################################################
"

sudo systemctl start cerebro.service
sudo systemctl status cerebro.service