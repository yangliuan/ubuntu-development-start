#!/bin/bash
Install_SwitchHost(){
    #https://github.com/oldj/SwitchHosts
    #host管理工具
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download switchhost..."
    src_url="http://mirror.yangliuan.cn/SwitchHosts_linux_x86_64_4.1.0.6076.AppImage" && Download_src
    
    if [ ! -e "/opt/switchhost" ]; then
        mkdir /opt/switchhost
    fi

    mv -fv SwitchHosts_linux_x86_64_4.1.0.6076.AppImage /opt/switchhost/SwitchHosts_linux_x86_64.AppImage
    cp -rfv ${oneinstack_dir}/icon/switchhost.png /opt/switchhost/
    cp -rfv ${oneinstack_dir}/desktop/switchhost.desktop /usr/share/applications/
    chown -Rv ${run_user}.${run_group} /opt/switchhost
    chmod -Rv 755 /opt/switchhost

    popd > /dev/null
}