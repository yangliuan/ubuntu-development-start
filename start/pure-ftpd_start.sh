#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start pureftpd
####################################################################
"

sudo systemctl start pureftpd.service
sudo systemctl status pureftpd.service