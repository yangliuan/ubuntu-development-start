#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  start php-fpm                               #
################################################################################
"
sudo systemctl start php-fpm.service 
sudo systemctl status php-fpm.service