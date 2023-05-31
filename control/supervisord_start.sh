#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start supervisor                               #
################################################################################
"
sudo systemctl start supervisor.service
sudo systemctl status supervisor.service