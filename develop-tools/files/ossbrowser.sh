#!/bin/bash
Install_Ossbrowser() {
    pushd ${oneinstack_dir}/src > /dev/null

    echo "Download ossbrowser..."    
    src_url="https://gosspublic.alicdn.com/oss-browser/1.16.0/oss-browser-linux-x64.zip?spm=a2c4g.11186623.0.0.4c296404EQSSj3&file=oss-browser-linux-x64.zip" && Download_src
    unzip oss-browser-linux-x64.zip\?spm\=a2c4g.11186623.0.0.4c296404EQSSj3\&file\=oss-browser-linux-x64.zip
    rm -rfv oss-browser-linux-x64.zip\?spm\=a2c4g.11186623.0.0.4c296404EQSSj3\&file\=oss-browser-linux-x64.zip
    chown -Rv ${run_user}.${run_group} oss-browser-linux-x64
    chmod -Rv 755 oss-browser-linux-x64
    mv -v oss-browser-linux-x64 /opt/oss-browser
    cp -rfv ${oneinstack_dir}/desktop/oss-browser.desktop /usr/share/applications/
    sudo apt-get install libgconf-2-4
    
    popd > /dev/null
}

Uninstall_Ossbrowser() {
    rm -rfv /opt/oss-browser
    rm -rfv /usr/share/applications/oss-browser.desktop
}