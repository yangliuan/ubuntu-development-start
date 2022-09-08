#!/bin/bash
Install_Vbox() {
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download virtualbox ..."
    src_url="https://download.virtualbox.org/virtualbox/${virtualbox_ver_base}.${virtualbox_ver}/virtualbox-${virtualbox_ver_base}_${virtualbox_ver_base}.${virtualbox_ver}-${virtualbox_ver_sn}~Ubuntu~${ubuntu_name}_amd64.deb" && Download_src
    dpkg -i virtualbox-${virtualbox_ver_base}_${virtualbox_ver_base}.${virtualbox_ver}-${virtualbox_ver_sn}~Ubuntu~${ubuntu_name}_amd64.deb
    apt install -f
    rm -rfv virtualbox-${virtualbox_ver_base}_${virtualbox_ver_base}.${virtualbox_ver}-${virtualbox_ver_sn}~Ubuntu~${ubuntu_name}_amd64.deb
    src_url="https://download.virtualbox.org/virtualbox/${virtualbox_ver_base}.${virtualbox_ver}/Oracle_VM_VirtualBox_Extension_Pack-${virtualbox_ver_base}.${virtualbox_ver}.vbox-extpack" && Download_src
    mv -fv Oracle_VM_VirtualBox_Extension_Pack-${virtualbox_ver_base}.${virtualbox_ver}.vbox-extpack /home/${run_user}/Downloads/
    popd > /dev/null
}

Uninstall_Vbox() {
    dpkg -P  virtualbox-${virtualbox_ver_base}
    apt-get autoremove
}