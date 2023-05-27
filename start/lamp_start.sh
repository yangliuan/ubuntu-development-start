#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start lamp                                   #
################################################################################
"
sudo systemctl start httpd.service
sudo systemctl start php-fpm.service
sudo systemctl start mysqld.service
sudo systemctl status httpd.service php-fpm.service mysqld.service