#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                   sqlite3                                    #
################################################################################
"
if [ -e "/usr/local/bin/sqlite3" ]; then
    sqlite3
else
    echo "sqlite3 is not installed"
    sleep 3
fi 
