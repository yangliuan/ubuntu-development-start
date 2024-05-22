#!/bin/bash
#https://im.qq.com/linuxqq/index.shtml
Install_LinuxQQ() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    echo "Download linux qq ..."    
    src_url="https://dldir1.qq.com/qqfile/qq/QQNT/Linux/QQ_${linuxqq_ver}_amd64_01.deb" && Download_src
    dpkg -i QQ_${linuxqq_ver}_amd64_01.deb
    chown -Rv ${run_user}:${run_group} /opt/QQ
    popd > /dev/null
}

Uninstall_LinuxQQ() {
    dpkg -P linuxqq
    [ -d "/opt/QQ" ] && rm -rf /opt/QQ
}