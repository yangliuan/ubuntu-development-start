#!/bin/bash
clear
printf "
################################################################################
                                start nginx
################################################################################
"
sudo systemctl start nginx.service
sudo systemctl status nginx.service