#!/bin/bash
Install_ClashForWindow() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null

    echo "Download xmrth clash ..."
    src_url="https://down.xmrth.xyz/Clash.for.Windows-0.20.15-x64-linux.tar.gz" && Download_src
    tar -zxvf Clash.for.Windows-0.20.15-x64-linux.tar.gz
    mv "Clash for Windows-0.20.15-x64-linux" /opt/clash
    cp ${ubdevenv_dir}/icon/clash.png /opt/clash/clash.png
    cp -rfv ${ubdevenv_dir}/desktop/clash.desktop  /usr/share/applications/
    chmod -R 755 /usr/share/applications/clash.desktop
    chown -R ${run_user}:${run_group} /opt/clash
    chmod -R 755 /opt/clash

    popd > /dev/null
}

Uninstall_ClashForWindow() {
    rm -rfv /usr/share/applications/clash.desktop
    rm -rfv /opt/clash
}