#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start lnpm                                   #
################################################################################
"
sudo systemctl start nginx.service
sudo systemctl start php-fpm.service
sudo systemctl start mysqld.service
sudo systemctl status nginx.service php-fpm.service mysqld.service