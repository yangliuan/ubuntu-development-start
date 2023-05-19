#!/bin/bash
clear
printf "
################################################################################
                               start elasticsearch
################################################################################
"

sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch.service