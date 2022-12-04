#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start postgresql
####################################################################
"
sudo systemctl start postgresql.service
sudo systemctl status postgresql.service