#!/bin/bash
Install_Runapi(){
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download runapi..."    
    src_url="https://www.showdoc.cc/server/api/common/visitfile/sign/0e73b106b92346fcd7809de0ee71f0ff?showdoc=.zip" && Download_src
    unzip 0e73b106b92346fcd7809de0ee71f0ff\?showdoc\=.zip -d runapi
    rm -rfv 0e73b106b92346fcd7809de0ee71f0ff\?showdoc\=.zip
    mkdir /opt/runapi
    mv -v runapi/runapi.AppImage /opt/runapi/
    rm -rfv runapi
    cp -rfv ${oneinstack_dir}/icon/runapi.png /opt/runapi/
    cp -rfv ${oneinstack_dir}/desktop/runapi.desktop /usr/share/applications/
    chown -Rv ${run_user}.${run_group} runapi/
    chmod -Rv 777 runapi/*
    popd > /dev/null
}