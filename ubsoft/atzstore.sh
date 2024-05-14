#!/bin/bash
#https://www.atzlinux.com/allpackages.htm
Install_AtzStore() {
    pushd ${ubdevenv_dir}/src > /dev/null
    src_url="https://www.atzlinux.com/atzlinux/pool/main/a/atzlinux-archive-keyring/atzlinux-v12-archive-keyring_lastest_all.deb" && Download_src
    dpkg -i "atzlinux-v12-archive-keyring_lastest_all.deb"
    apt-get update
    apt-get install -y atzlinux-store-v12
    popd > /dev/null
}

Uninstall_AtzStore() {

}


