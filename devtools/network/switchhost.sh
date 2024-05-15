#!/bin/bash
#https://github.com/oldj/SwitchHosts
#host管理工具
Install_SwitchHost() {
    pushd ${ubdevenv_dir}/src/devtools > /dev/null
    
    echo "Download switchhost..."
    src_url="http://mirror.yangliuan.cn/SwitchHosts_linux_x86_64_4.1.0.6076.AppImage" && Download_src
    
    if [ ! -e "/opt/switchhost" ]; then
        mkdir /opt/switchhost
    fi

    cp -fv SwitchHosts_linux_x86_64_4.1.0.6076.AppImage /opt/switchhost/SwitchHosts_linux_x86_64.AppImage
    cp -rfv ${ubdevenv_dir}/icon/switchhost.png /opt/switchhost/
    cp -rfv ${ubdevenv_dir}/desktop/switchhost.desktop /usr/share/applications/
    chown -Rv ${run_user}:${run_group} /opt/switchhost /usr/share/applications/switchhost.desktop
    chmod -Rv 755 /opt/switchhost

    popd > /dev/null
}

Uninstall_SwitchHost() {
    rm -rfv /opt/switchhost/
    rm -rfv /usr/share/applications/switchhost.desktop 
}
