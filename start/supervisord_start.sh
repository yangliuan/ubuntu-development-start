#!/bin/bash
clear
printf "
################################################################################
                                start supervisor
################################################################################
"

sudo systemctl start supervisor.service
sudo systemctl status supervisor.service