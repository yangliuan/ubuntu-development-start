#!/bin/bash
#https://www.atzlinux.com/allpackages.htm
Install_AtzStore() {
    pushd ${ubdevenv_dir}/src > /dev/null
    src_url="https://www.atzlinux.com/atzlinux/pool/main/a/atzlinux-archive-keyring/atzlinux-v12-archive-keyring_lastest_all.deb" && Download_src
    dpkg -i "atzlinux-v12-archive-keyring_lastest_all.deb"
    apt update
    apt install atzlinux-store-v12
}
