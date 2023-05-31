#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                 start cerebro                                #
################################################################################
"
sudo systemctl start cerebro.service
sudo systemctl status cerebro.service