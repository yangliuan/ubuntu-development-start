#!/bin/bash
#https://www.cursor.so/ 基于chatgpt的编辑器
Install_Cursor() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url='https://dl.todesktop.com/230313mzl4w4u92/linux/appImage/x64' && Download_src
    [ ! -d /opt/cursor ] && mkdir /opt/cursor
    mv x64 /opt/cursor/Cursor.AppImage
    cp -fv ${oneinstack_dir}/icon/cursor.svg /opt/cursor/
    chown -R ${run_user}.${run_user} /opt/cursor
    chmod -R 775 /opt/cursor
    cp -rfv ${oneinstack_dir}/desktop/cursor.desktop /usr/share/applications/
    
    popd > /dev/null
}

Uninstall_Cursor() {
    rm -rf /opt/cursor /usr/share/applications/cursor.desktop
}