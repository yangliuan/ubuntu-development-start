#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                start openssh                                 #
################################################################################
"
sudo systemctl start ssh.service
sudo systemctl status ssh.service