#!/bin/bash
clear
printf "
################################################################################
                                start cerebro
################################################################################
"

sudo systemctl start cerebro.service
sudo systemctl status cerebro.service