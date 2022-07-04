#!/bin/bash
Install_Apifox() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url='https://cdn.apifox.cn/download/Apifox-linux-deb-latest.zip' && Download_src
    unzip Apifox-linux-deb-latest.zip
    dpkg -i apifox_${apifox_ver}_amd64.deb
    rm -rfv Apifox-linux-deb-latest.zip apifox_${apifox_ver}_amd64.deb
    cp -rfv ${oneinstack_dir}/desktop/apifox.desktop /usr/share/applications/
    popd > /dev/null
}

Uninstall_Apifox() {
    dpkg -P apifox
}

