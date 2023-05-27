#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start apached httpd                               #
################################################################################
"
sudo service httpd start
sudo service httpd status