#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start lamp    
####################################################################
"

sudo systemctl start httpd.service
sudo systemctl start php-fpm.service
sudo systemctl start mysqld.service