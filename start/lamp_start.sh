#!/bin/bash
clear
printf "
################################################################################
                                  start lamp    
################################################################################
"

sudo systemctl start httpd.service
sudo systemctl start php-fpm.service
sudo systemctl start mysqld.service
sudo systemctl status httpd.service php-fpm.service mysqld.service