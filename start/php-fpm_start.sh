#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start php-fpm
####################################################################
"

sudo systemctl start php-fpm.service 
sudo systemctl status php-fpm.service