#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start elasticsearch
####################################################################
"

sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch.service