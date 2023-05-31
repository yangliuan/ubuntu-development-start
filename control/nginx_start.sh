#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  start nginx                                 #
################################################################################
"
sudo systemctl start nginx.service
sudo systemctl status nginx.service