#!/bin/bash
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                               start tenigne                                  #
################################################################################
"
ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")
. ${ubdevenv_dir}/options.conf
. ${ubdevenv_dir}/devbase/webserver/switch_nginx.sh

stop_nginx_service
#update systemed
sudo rm -rf /lib/systemd/system/nginx.service
sudo cp ${ubdevenv_dir}/init.d/nginx.service /lib/systemd/system/
sudo sed -i "s@/usr/local/nginx@${tengine_install_dir}@g" /lib/systemd/system/nginx.service
sudo systemctl daemon-reload
#update env
disbale_nginxenv
disable_openrestyenv
enable_tengineenv

sudo systemctl start nginx.service
sudo systemctl status nginx.service