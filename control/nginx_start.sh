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

if [ -e "/lib/systemd/system/nginx.service" -a -d "${nginx_install_dir}" ]; then
    # is nginx
    if grep -q "${nginx_install_dir}" /lib/systemd/system/nginx.service; then
        if sudo systemctl is-active --quiet nginx.service; then
            echo "Stopping nginx.service"
            sudo systemctl stop nginx.service
        else
            echo "Startping nginx.service"
            sudo systemctl start nginx.service
        fi
        sudo systemctl status nginx.service
    else
        echo "switch to nginx"
        stop_nginx_service
        sudo rm -rf /lib/systemd/system/nginx.service
        sudo cp ${ubdevenv_dir}/init.d/nginx.service /lib/systemd/system/
        sudo sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /lib/systemd/system/nginx.service
        sudo systemctl daemon-reload
        enable_nginxenv
        disable_openrestyenv
        disable_tengineenv
        sudo systemctl start nginx.service
        sudo systemctl status nginx.service
    fi
else
    echo "nginx is not installed"
    sleep 3
fi 
