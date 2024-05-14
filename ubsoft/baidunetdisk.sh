#!/bin/bash
Install_Baidunetdisk() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download baidunetdisk ..."
    src_url="https://issuepcdn.baidupcs.com/issue/netdisk/LinuxGuanjia/${baidunetdisk_ver}/baidunetdisk_${baidunetdisk_ver}_amd64.deb" && Download_src
    dpkg -i baidunetdisk_${baidunetdisk_ver}_amd64.deb
    apt-get install -f
    chown -Rv ${run_user}:${run_group} /opt/baidunetdisk
    #rm -rfv baidunetdisk_${baidunetdisk_ver}_amd64.deb
    popd > /dev/null
}

Uninstall_Baidunetdisk() {
    dpkg -P baidunetdisk
}