#!/bin/bash
clear
printf "
################################################################################
                                 start kibana
################################################################################
"

sudo systemctl start kibana.service
sudo systemctl status kibana.service