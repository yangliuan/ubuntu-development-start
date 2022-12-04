#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start nginx
####################################################################
"
sudo systemctl start nginx.service
sudo systemctl status nginx.service