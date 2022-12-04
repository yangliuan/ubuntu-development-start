#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start mysqld
####################################################################
"
sudo systemctl start mysqld.service
sudo systemctl status mysqld.service