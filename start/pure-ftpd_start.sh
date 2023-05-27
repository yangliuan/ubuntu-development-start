#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start pureftpd                                #
################################################################################
"
sudo systemctl start pureftpd.service
sudo systemctl status pureftpd.service