#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start logstash
####################################################################
"

sudo systemctl start logstash.service
sudo systemctl status logstash.service