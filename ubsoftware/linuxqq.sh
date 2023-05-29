#!/bin/bash
#https://im.qq.com/linuxqq/index.shtml
Install_LinuxQQ() {
    pushd ${start_dir}/src > /dev/null
    echo "Download linux qq ..."
    src_url="https://dldir1.qq.com/qqfile/qq/QQNT/${linuxqq_link_token}/linuxqq_${linuxqq_ver}_amd64.deb" && Download_src
    dpkg -i linuxqq_${linuxqq_ver}_amd64.deb
    apt-get -y install -f
    #rm -rfv linuxqq_${linuxqq_ver}_amd64.deb
    chmod -R 777  /opt/QQ
    popd > /dev/null
}

Uninstall_LinuxQQ() {
    dpkg -P linuxqq
    [ -d "/opt/QQ" ] && rm -rf /opt/QQ
}