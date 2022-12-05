#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start lnmp    
####################################################################
"

sudo systemctl start nginx.service
sudo systemctl start php-fpm.service
sudo systemctl start mysqld.service
sudo systemctl status nginx.service php-fpm.service mysqld.service