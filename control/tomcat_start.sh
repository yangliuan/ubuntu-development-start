#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start tomcat                                   #
################################################################################
"
if [ -e "/etc/init.d/tomcat" ]; then
    if sudo systemctl is-active --quiet tomcat.service; then
        echo "Stopping tomcat.service"
        sudo systemctl stop tomcat.service 
    else
        echo "Starting tomcat.service"
        sudo systemctl start tomcat.service 
    fi
    sudo systemctl status tomcat.service
else
    echo "tomcat is not installed"
    sleep 3
fi