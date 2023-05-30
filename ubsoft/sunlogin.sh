#!/bin/bash
#https://sunlogin.oray.com/download/linux?type=personal
Install_Sunlogin() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download sunlogin ..."
    src_url="https://down.oray.com/sunlogin/linux/SunloginClient_${sunlogin_ver}_amd64.deb" && Download_src
    dpkg -i SunloginClient_${sunlogin_ver}_amd64.deb
    apt-get -y install -f
    #rm -rfv SunloginClient_${sunlogin_ver}_amd64.deb
    popd > /dev/null
}

Uninstall_Sunlogin() {
    dpkg -P sunloginclient
}