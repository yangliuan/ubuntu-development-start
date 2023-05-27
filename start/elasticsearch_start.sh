#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            start elasticsearch                               #
################################################################################
"
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch.service