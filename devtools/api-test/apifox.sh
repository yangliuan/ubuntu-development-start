#!/bin/bash
#https://apifox.com/
Install_Apifox() {
    pushd ${ubdevenv_dir}/src > /dev/null
    src_url='https://cdn.apifox.cn/download/Apifox-linux-manual-latest.tar.gz' && Download_src
    [ ! -d apifox ] && mkdir apifox
    #去掉第一层目录结构 DOC:https://wangchujiang.com/linux-command/c/tar.html
    tar -zxvf Apifox-linux-manual-latest.tar.gz --strip-components 1 -C apifox
    mv -fv apifox /opt/
    chmod -R 775 /opt/apifox
    cp -rfv ${ubdevenv_dir}/desktop/apifox.desktop /usr/share/applications/
    chown -R ${run_user}.${run_group} /opt/apifox /usr/share/applications/apifox.desktop
    popd > /dev/null
}

Uninstall_Apifox() {
    rm -rfv /opt/apifox /usr/share/applications/apifox.desktop
}

