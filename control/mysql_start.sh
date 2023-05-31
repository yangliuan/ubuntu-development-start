#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  start mysqld                                #
################################################################################
"
sudo systemctl start mysqld.service
sudo systemctl status mysqld.service