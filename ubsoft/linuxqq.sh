#!/bin/bash
#https://im.qq.com/linuxqq/index.shtml
Install_LinuxQQ() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download linux qq ..."
    # https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_3.2.7_240428_amd64_01.deb
    src_url="https://dldir1.qq.com/qqfile/qq/QQNT/${linuxqq_link_token}/linuxqq_${linuxqq_ver}_amd64_01.deb" && Download_src
    dpkg -i linuxqq_${linuxqq_ver}_amd64_01.deb
    apt-get -y install -f
    #rm -rfv linuxqq_${linuxqq_ver}_amd64.deb
    chown -Rv ${run_user}:${run_group} /opt/QQ
    popd > /dev/null
}

Uninstall_LinuxQQ() {
    dpkg -P linuxqq
    [ -d "/opt/QQ" ] && rm -rf /opt/QQ
}