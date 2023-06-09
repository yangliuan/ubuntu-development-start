#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  start nginx                                 #
################################################################################
"
ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")
. ${ubdevenv_dir}/options.conf
. ${ubdevenv_dir}/devbase/webserver/switch_nginx.sh

stop_nginx_service
#update systemed
sudo rm -rf /lib/systemd/system/nginx.service
sudo cp ${ubdevenv_dir}/init.d/nginx.service /lib/systemd/system/
sudo sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /lib/systemd/system/nginx.service
sudo systemctl daemon-reload
#update env
enable_nginxenv
disable_openrestyenv
disable_tengineenv

sudo systemctl start nginx.service
sudo systemctl status nginx.service