#!/bin/bash
Install_Conky() {
    apt-get -y install conky
    cp -rfv ${start_dir}/config/conky /etc/
}

Uninstall_Conky() {
    apt-get -y autoremove conky
}