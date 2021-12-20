#!/bin/bash
Install_Vbox(){
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download virtualbox ..."
    src_url="https://download.virtualbox.org/virtualbox/${virtualbox_ver}/virtualbox-6.1_${virtualbox_ver}-148432~Ubuntu~eoan_amd64.deb" && Download_src
    dpkg -i virtualbox-6.1_6.1.30-148432~Ubuntu~eoan_amd64.deb
    apt install -f
    rm -rfv virtualbox-6.1_6.1.30-148432~Ubuntu~eoan_amd64.deb
    src_url="https://download.virtualbox.org/virtualbox/${virtualbox_ver}/Oracle_VM_VirtualBox_Extension_Pack-${virtualbox_ver}.vbox-extpack" && Download_src
    mv -fv Oracle_VM_VirtualBox_Extension_Pack-6.1.30.vbox-extpack /home/${run_user}/Downloads/
    popd > /dev/null
}