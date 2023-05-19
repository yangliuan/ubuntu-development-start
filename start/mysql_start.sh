#!/bin/bash
clear
printf "
################################################################################
                                start mysqld
################################################################################
"
sudo systemctl start mysqld.service
sudo systemctl status mysqld.service