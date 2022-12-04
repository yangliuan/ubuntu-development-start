#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start redis-server
####################################################################
"
sudo systemctl start redis-server.service
sudo systemctl status redis-server.service