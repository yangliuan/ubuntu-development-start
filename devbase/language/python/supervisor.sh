#!/bin/bash
Install_Supervisor() {
    apt-get -y install supervisor
    cp -rfv ${ubdevenv_dir}/desktop/supervisord.desktop /usr/share/applications
    systemctl disable supervisor.service
    chmod -R 777 /etc/supervisor
}

Uninstall_Supervisor() {
    apt-get -y remove supervisor
    rm -rfv /usr/share/applications/supervisord.desktop
}