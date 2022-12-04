#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start lamp    
####################################################################
"

systemctl start httpd.service
systemctl start php-fpm.service
systemctl start mysqld.service