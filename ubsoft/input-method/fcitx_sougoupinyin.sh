#!/bin/bash
#https://shurufa.sogou.com/linux
#https://www.ufans.top/index.php/archives/376/
Install_Sougoupinyin() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download sougou pinyin..."
    src_url="http://mirror.yangliuan.cn/sogoupinyin_${sougoupinyin_ver}_amd64.deb" && Download_src
    Install_Fcitx
    dpkg -i sogoupinyin_${sougoupinyin_ver}_amd64.deb
    apt-get -y install libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 libgsettings-qt1
    apt-get -y install -f
    #rm -rfv sogoupinyin_${sougoupinyin_ver}_amd64.deb
    chown -Rv ${run_user}:${run_group} /opt/sogoupinyin
    popd > /dev/null
}

Uninstall_Sougoupinyin() {
    dpkg -P sogoupinyin
    apt-get autoremove
    #apt-get remove libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 libgsettings-qt1
    rm -rfv /opt/sogoupinyin
}