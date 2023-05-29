#!/bin/bash
#https://apifox.com/
Install_Apifox() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url='https://cdn.apifox.cn/download/Apifox-linux-manual-latest.tar.gz' && Download_src
    [ ! -d apifox ] && mkdir apifox
    #去掉第一层目录结构 DOC:https://wangchujiang.com/linux-command/c/tar.html
    tar -zxvf Apifox-linux-manual-latest.tar.gz --strip-components 1 -C apifox
    mv -fv apifox /opt/
    chown -R ${run_user}.${run_user} /opt/apifox
    chmod -R 775 /opt/apifox
    rm -rfv apifox Apifox-linux-manual-latest.tar.gz
    cp -rfv ${oneinstack_dir}/desktop/apifox.desktop /usr/share/applications/
    
    popd > /dev/null
}

Uninstall_Apifox() {
    rm -rfv /opt/apifox /usr/share/applications/apifox.desktop
}

