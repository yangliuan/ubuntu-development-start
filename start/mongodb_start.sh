#!/bin/bash
clear
printf "
################################################################################
                                start mongodb
################################################################################
"

sudo systemctl start mongod.service
sudo systemctl status mongod.service