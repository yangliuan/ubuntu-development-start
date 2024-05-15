#!/bin/bash
Install_Vbox() {
    pushd ${ubdevenv_dir}/src/devtools > /dev/null
    echo "Download virtualbox ..."
    src_url="https://download.virtualbox.org/virtualbox/${virtualbox_ver_base}.${virtualbox_ver}/virtualbox-${virtualbox_ver_base}_${virtualbox_ver_base}.${virtualbox_ver}-${virtualbox_ver_sn}~Ubuntu~${ubuntu_name}_amd64.deb" && Download_src
    dpkg -i virtualbox-${virtualbox_ver_base}_${virtualbox_ver_base}.${virtualbox_ver}-${virtualbox_ver_sn}~Ubuntu~${ubuntu_name}_amd64.deb
    apt-get -y install -f
    #rm -rfv virtualbox-${virtualbox_ver_base}_${virtualbox_ver_base}.${virtualbox_ver}-${virtualbox_ver_sn}~Ubuntu~${ubuntu_name}_amd64.deb
    src_url="https://download.virtualbox.org/virtualbox/${virtualbox_ver_base}.${virtualbox_ver}/Oracle_VM_VirtualBox_Extension_Pack-${virtualbox_ver_base}.${virtualbox_ver}.vbox-extpack" && Download_src
    cp -fv Oracle_VM_VirtualBox_Extension_Pack-${virtualbox_ver_base}.${virtualbox_ver}.vbox-extpack /home/${run_user}/Downloads/
    popd > /dev/null
}

Uninstall_Vbox() {
    dpkg -P  virtualbox-${virtualbox_ver_base}
}