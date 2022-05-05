#!/bin/bash

Install_Supervisor() {
    apt install supervisor
    cp -rfv ${oneinstack_dir}/desktop/supervisord.desktop /usr/share/applications
    systemctl disable supervisor.service
}

Uninstall_Supervisor() {
    apt autoremove supervisor
    rm -rfv /usr/share/applications/supervisord.desktop
}