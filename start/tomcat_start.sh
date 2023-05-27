#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start tomcat                                   #
################################################################################
"
sudo service tomcat start
sudo service tomcat status