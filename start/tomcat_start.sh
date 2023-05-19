#!/bin/bash
clear
printf "
################################################################################
                                 start tomcat
################################################################################
"

sudo service tomcat start
sudo service tomcat status