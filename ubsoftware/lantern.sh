#!/bin/bash
Install_Lantern() {
    pushd ${start_dir}/src > /dev/null

    echo "Download lantern ..."
    src_url="http://mirror.yangliuan.cn/lantern-installer-64-bit.deb" && Download_src
    dpkg -i lantern-installer-64-bit.deb
    apt-get -y install -f
    #rm -rfv lantern-installer-64-bit.deb
    
    popd > /dev/null
}

Uninstall_Lantern() {
    dpkg -P lantern
}