#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start postgresql                              #
################################################################################
"
sudo systemctl start postgresql.service
sudo systemctl status postgresql.service