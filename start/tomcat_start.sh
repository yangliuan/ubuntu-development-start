#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          start tomcat
####################################################################
"

sudo service tomcat start
sudo service tomcat status