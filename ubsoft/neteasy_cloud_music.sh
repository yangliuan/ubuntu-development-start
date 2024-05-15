#!/bin/bash
Install_NeteasyCloudMusic() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    echo "Download netease-cloud-music ..."
    src_url="https://d1.music.126.net/dmusic/netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb" && Download_src
    dpkg -i netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb
    apt-get -y install -f
    chown -R ${run_user}:${run_group} /opt/netease
    #rm -rfv netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb
    popd > /dev/null

    if [[ ${Ubuntu_ver} =~ ^2[2-3]$ ]]; then
        Patch_NeteasyCloudMusic
    fi
}

Uninstall_NeteasyCloudMusic() {
    dpkg -P netease-cloud-music
}

#support for ubuntu2204
#REF https://blog.csdn.net/leibris/article/details/124895824
Patch_NeteasyCloudMusic() {
    if [ -e /opt/netease/netease-cloud-music/netease-cloud-music.bash ]; then
        apt-get -y install libqt5webchannel5
        sed -i 's@export LD_LIBRARY_PATH="${HERE}"/libs@export LD_LIBRARY_PATH="${HERE}"/libs:$LD_LIBRARY_PATH@' /opt/netease/netease-cloud-music/netease-cloud-music.bash
        sed -i "s@exec@cd /lib/x86_64-linux-gnu/\nexec@g" /opt/netease/netease-cloud-music/netease-cloud-music.bash
    fi
}

Install_NeteasyCloudMusicElectron() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download netease-cloud-music-electron ..."
    src_url="https://artifacts.encm.cf/electron-ncm_v0.9.38-9-gef149b3_linux.tar.gz" && Download_src
    tar -zxvf electron-ncm_v0.9.38-9-gef149b3_linux.tar.gz
    mv Electron\ NCM-linux-x64/ /opt/electron-netease-cloud-music
    cp -rv ${ubdevenv_dir}/icon/electron-netease-cloud-music.svg /opt/electron-netease-cloud-music
    chown -Rv ${run_user}:${run_group} /opt/electron-netease-cloud-music
    cp -rv ${ubdevenv_dir}/desktop/electron-netease-cloud-music.desktop /usr/share/applications
    chown -Rv ${run_user}:${run_group} /usr/share/applications/electron-netease-cloud-music.desktop
    chmod -Rv 755 /usr/share/applications/electron-netease-cloud-music.desktop
    popd > /dev/null
}

Uninstall_NeteasyCloudMusicElectron() {
    rm -rfv /opt/electron-netease-cloud-music
    rm -rfv /usr/share/applications/electron-netease-cloud-music.desktop
}