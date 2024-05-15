#!/bin/bash
#https://github.com/flameshot-org/flameshot
Install_Flameshot() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    
    echo "Download flameshot ..."
    src_url="http://mirror.yangliuan.cn/flameshot-${flameshot_ver}-1.debian-10.amd64.deb" && Download_src
    dpkg -i flameshot-${flameshot_ver}-1.debian-10.amd64.deb
    apt-get -y install -f
    #rm -rfv flameshot-${flameshot_ver}-1.debian-10.amd64.deb
    
    popd > /dev/null
}

Uninstall_Flameshot() {
    dpkg -P flameshot-${flameshot_ver}-1.debian-10.amd64.deb
}