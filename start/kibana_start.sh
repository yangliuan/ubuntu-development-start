#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start kibana                                  #
################################################################################
"
sudo systemctl start kibana.service
sudo systemctl status kibana.service