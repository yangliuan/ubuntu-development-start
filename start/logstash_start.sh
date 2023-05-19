#!/bin/bash
clear
printf "
################################################################################
                                start logstash
################################################################################
"

sudo systemctl start logstash.service
sudo systemctl status logstash.service