#!/bin/bash
Install_NeteasyCloudMusic() {
    pushd ${start_dir}/src > /dev/null

    echo "Download netease-cloud-music ..."
    src_url="https://d1.music.126.net/dmusic/netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb" && Download_src
    dpkg -i netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb
    apt-get -y install -f
    #rm -rfv netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb
    
    popd > /dev/null

    if [ "${Ubuntu_ver}" == "22" ]; then
        Patch_NeteasyCloudMusicFor2204
    fi
}

Uninstall_NeteasyCloudMusic() {
    dpkg -P netease-cloud-music
}

#support for ubuntu2204
#REF https://blog.csdn.net/leibris/article/details/124895824
Patch_NeteasyCloudMusicFor2204() {
    if [ -e /opt/netease/netease-cloud-music/netease-cloud-music.bash ]; then
        apt-get -y install libqt5webchannel5
        sed -i 's@export LD_LIBRARY_PATH="${HERE}"/libs@export LD_LIBRARY_PATH="${HERE}"/libs:$LD_LIBRARY_PATH@' /opt/netease/netease-cloud-music/netease-cloud-music.bash
        sed -i "s@exec@cd /lib/x86_64-linux-gnu/\nexec@g" /opt/netease/netease-cloud-music/netease-cloud-music.bash
    fi
}