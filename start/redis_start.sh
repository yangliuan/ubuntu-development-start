#!/bin/bash
clear
printf "
################################################################################
                                start redis-server
################################################################################
"
sudo systemctl start redis-server.service
sudo systemctl status redis-server.service