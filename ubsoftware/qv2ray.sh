#!/bin/bash
Install_Qv2ray() {
    pushd ${start_dir}/src > /dev/null
    echo "Download qv2ray ..."
    #文档地址https://qv2ray.net/lang/zh/getting-started/
    src_url="http://mirror.yangliuan.cn/qv2ray.tar.xz" && Download_src
    tar xJf qv2ray.tar.xz

    if [ ! -e "/home/${run_user}/.config/qv2ray" ]; then
      mkdir /home/${run_user}/.config/qv2ray
    fi

    if [ ! -e "/home/${run_user}/.config/qv2ray/plugins" ]; then
      mkdir /home/${run_user}/.config/qv2ray/plugins
    fi

    #内核文件
    mv -fv qv2ray/vcore/ /home/${run_user}/.config/qv2ray/
    #插件文件
    mv -fv qv2ray/plugins/* /home/${run_user}/.config/qv2ray/plugins/
    rm -rf qv2ray/plugins
    #覆盖原始geoip文件
    mv -fv qv2ray/geoip/* /home/${run_user}/.config/qv2ray/vcore
    rm -rf qv2ray/geoip
    #appimage
    mv -fv qv2ray/ /opt/
    cp -rfv ${start_dir}/desktop/qv2ray.desktop /usr/share/applications/

    #修改文件权限
    chown -R ${run_user}.${run_group} /home/${run_user}/.config/qv2ray/vcore
    chown -R ${run_user}.${run_group} /opt/qv2ray
    chmod u+x /opt/qv2ray
    chown -R ${run_user}.${run_group} /home/${run_user}/.config/qv2ray/
    chmod -R 755 /home/${run_user}/.config/qv2ray/
    chown -R ${run_user}.${run_group} /home/${run_user}/.config/qv2ray/plugins
    chmod -R 755 /home/${run_user}/.config/qv2ray/plugins
    chmod -R 755 /usr/share/applications/qv2ray.desktop
    popd > /dev/null
}

Uninstall_Qv2ray() {
    rm -rfv /home/${run_user}/.config/qv2ray
    rm -rfv /opt/qv2ray
    rm -rfv /usr/share/applications/qv2ray.desktop
}