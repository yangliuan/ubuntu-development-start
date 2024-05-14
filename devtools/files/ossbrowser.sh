#!/bin/bash
Install_Ossbrowser() {
    pushd ${ubdevenv_dir}/src > /dev/null

    echo "Download ossbrowser..."    
    src_url="https://gosspublic.alicdn.com/oss-browser/1.16.0/oss-browser-linux-x64.zip" && Download_src
    unzip oss-browser-linux-x64.zip
    mv -fv oss-browser-linux-x64 /opt/oss-browser
    cp -rfv ${ubdevenv_dir}/desktop/oss-browser.desktop /usr/share/applications/
    chown -Rv ${run_user}:${run_group} /usr/share/applications/oss-browser.desktop /opt/oss-browser
    chmod -Rv 755 /opt/oss-browser
    sudo apt-get install libgconf-2-4
    
    popd > /dev/null
}

Uninstall_Ossbrowser() {
    rm -rfv /opt/oss-browser
    rm -rfv /usr/share/applications/oss-browser.desktop
}