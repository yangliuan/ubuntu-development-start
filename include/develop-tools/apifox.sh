#!/bin/bash
Install_Apifox() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url='https://cdn.apifox.cn/download/Apifox-linux-manual-latest.tar.gz' && Download_src
    tar -zxvf Apifox-linux-manual-latest.tar.gz
    mv -fv apifox-${apifox_ver} /opt/apifox
    chown -R ${run_user}.${run_user} /opt/apifox
    chmod -R 775 /opt/apifox
    rm -rfv apifox-${apifox_ver} Apifox-linux-manual-latest.tar.gz
    cp -rfv ${oneinstack_dir}/desktop/apifox.desktop /usr/share/applications/
    
    popd > /dev/null
}

Uninstall_Apifox() {
    rm -rf /opt/apifox /usr/share/applications/apifox.desktop
}

