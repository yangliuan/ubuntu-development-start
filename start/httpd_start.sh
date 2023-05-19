#!/bin/bash
clear
printf "
################################################################################
                                start apached httpd
################################################################################
"

sudo service httpd start
sudo service httpd status