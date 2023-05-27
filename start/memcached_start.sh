#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start memcached                                 #
################################################################################
"
sudo service memcached start
sudo service memcached status