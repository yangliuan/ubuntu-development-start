#!/bin/bash
clear
printf "
################################################################################
                                start pureftpd
################################################################################
"

sudo systemctl start pureftpd.service
sudo systemctl status pureftpd.service