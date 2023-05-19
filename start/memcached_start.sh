#!/bin/bash
clear
printf "
################################################################################
                                start memcached
################################################################################
"

sudo service memcached start
sudo service memcached status