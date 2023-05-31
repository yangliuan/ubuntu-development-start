#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                             start redis-server                               #
################################################################################
"
sudo systemctl start redis-server.service
sudo systemctl status redis-server.service