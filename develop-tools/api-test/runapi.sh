#!/bin/bash
Install_Runapi() {
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download runapi..."    
    src_url="https://www.showdoc.cc/server/api/common/visitfile/sign/0e73b106b92346fcd7809de0ee71f0ff?showdoc=.zip" && Download_src
    unzip 0e73b106b92346fcd7809de0ee71f0ff\?showdoc\=.zip -d runapi
    mkdir /opt/runapi
    mv -v runapi/runapi.AppImage /opt/runapi/
    rm -rfv runapi
    cp -rfv ${oneinstack_dir}/icon/runapi.png /opt/runapi/
    chown -Rv ${run_user}.${run_group} /opt/runapi/
    cp -rfv ${oneinstack_dir}/desktop/runapi.desktop /usr/share/applications/
    chown -Rv ${run_user}.${run_group} /usr/share/applications/runapi.desktop
    popd > /dev/null
}

Uninstall_Runapi() {
    rm -rfv /opt/runapi/
    rm -rfv /usr/share/applications/runapi.desktop
}