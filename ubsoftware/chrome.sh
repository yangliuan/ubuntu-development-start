#!/bin/bash
Install_Chrome() {
    pushd ${start_dir}/src > /dev/null

    echo "Download chrome ..."
    src_url="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" && Download_src
    dpkg -i google-chrome-stable_current_amd64.deb
    apt-get install -f
    #rm -rfv google-chrome-stable_current_amd64.deb
    
    popd > /dev/null
}

Uninstall_Chrome() {
    dpkg -P google-chrome-stable
}