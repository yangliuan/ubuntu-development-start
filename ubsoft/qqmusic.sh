#!/bin/bash
#https://y.qq.com/download/download.html
Install_QQmusic() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null

    echo "Download qqmusic ..."
    src_url="https://dldir1.qq.com/music/clntupate/linux/deb/qqmusic_${qqmusic_ver}_amd64.deb" && Download_src
    dpkg -i qqmusic_${qqmusic_ver}_amd64.deb
    apt-get -y install -f
    chown -Rv ${run_user}:${run_group} /opt/qqmusic
    #rm -rfv qqmusic_${qqmusic_ver}_amd64.deb
    popd > /dev/null
    if [[ ${Ubuntu_ver} =~ ^2[2-3]$ ]]; then
        Patch_QQmusic
    fi
}

Uninstall_QQmusic() {
    dpkg -P qqmusic
}

#support for ubuntu2204
#REF https://blog.csdn.net/qq_45677678/article/details/125361156
Patch_QQmusic() {
    if [ -e /usr/share/applications/qqmusic.desktop ]; then
        sed -i "s@Exec=/opt/qqmusic/qqmusic %U@Exec=/opt/qqmusic/qqmusic --no-sandbox %U@g" /usr/share/applications/qqmusic.desktop
    fi
}