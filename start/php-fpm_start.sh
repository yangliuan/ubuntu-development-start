#!/bin/bash
clear
printf "
################################################################################
                                start php-fpm
################################################################################
"

sudo systemctl start php-fpm.service 
sudo systemctl status php-fpm.service