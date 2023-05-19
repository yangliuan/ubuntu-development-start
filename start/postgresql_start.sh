#!/bin/bash
clear
printf "
################################################################################
                                start postgresql
################################################################################
"
sudo systemctl start postgresql.service
sudo systemctl status postgresql.service