#!/bin/bash
#github https://github.com/zq1997/deepin-wine
#software source https://deepin-wine.i-m.dev/
Install_DeepinWine() {
    # 添加架构
    ARCHITECTURE=$(dpkg --print-architecture && dpkg --print-foreign-architectures)
    if ! echo "$ARCHITECTURE" | grep -qE 'amd64|i386'; then
        echo "必须amd64/i386机型才能移植deepin-wine"
        return 1
    fi
    echo "$ARCHITECTURE" | grep -qE 'i386' || sudo dpkg --add-architecture i386
    apt-get -y update

    LIST_FILE="/etc/apt/sources.list.d/deepin-wine.i-m.dev.list"

    # 添加软件源
    tee "$LIST_FILE" >/dev/null << "EOF"
    deb [trusted=yes] https://deepin-wine.i-m.dev /
EOF

    # 添加XDG_DATA_DIRS配置，使得应用图标能正常显示
    tee "/etc/profile.d/deepin-wine.i-m.dev.sh" >/dev/null << "EOF"
XDG_DATA_DIRS=${XDG_DATA_DIRS:-/usr/local/share:/usr/share}
for deepin_dir in /opt/apps/*/entries; do
    if [ -d "$deepin_dir/applications" ]; then
        XDG_DATA_DIRS="$XDG_DATA_DIRS:$deepin_dir"
    fi
done
export XDG_DATA_DIRS
EOF

    # 刷新软件源
    apt-get update -y --no-list-cleanup -o Dir::Etc::sourcelist="$LIST_FILE" -o Dir::Etc::sourceparts="-"
    apt-get install -y deepin-elf-verify deepin-wine-helper:i386 deepin-wine-runtime deepin-wine6-stable
    apt-get install -y -f

    echo "${CSUCCESS} deepin-wine installed successed！ ${CEND}"
}

Uninstall_DeepinWine() {
    apt-get autoremove -y deepin-elf-verify deepin-wine-helper:i386 deepin-wine-runtime deepin-wine6-stable
    rm -rfv /etc/apt/preferences.d/deepin-wine.i-m.dev.pref
    rm -rfv /etc/apt/sources.list.d/deepin-wine.i-m.dev.list
    rm -rfv /etc/profile.d/deepin-wine.i-m.dev.sh
    apt-get -y update
}

Install_Deepin_Wechat() {
    pushd ${ubdevenv_dir}/src > /dev/null
    #apt-get install -y com.qq.weixin.deepin com.qq.weixin.work.deepin
    [ ! -e "com.qq.weixin.deepin_3.7.0.30deepin17_i386.deb" ] && apt-get download -y com.qq.weixin.deepin
    dpkg -i com.qq.weixin.deepin_3.7.0.30deepin17_i386.deb
    apt-get install -y -f
    [ ! -e "com.qq.weixin.work.deepin_4.0.16.6007deepin21_i386.deb" ] && apt-get download -y com.qq.weixin.work.deepin
    dpkg -i com.qq.weixin.work.deepin_4.0.16.6007deepin21_i386.deb
    apt-get install -y -f

    #解决无法发送图片问题
    apt-get install -y libjpeg62:i386
    apt-get install -y libjpeg62
    #字体问题
    apt-get install -y fonts-wqy-microhei fonts-wqy-zenhei
    #
    apt-mark hold -y libqt5core5a libqt5dbus5 libqt5gui5 libqt5network5 libqt5qml5 libqt5qmlmodels5 libqt5quick5 libqt5webchannel5 libqt5widgets5
    popd > /dev/null
}

Uninstall_Deepin_Wechat() {
    apt-get -y autoremove com.qq.weixin.deepin com.qq.weixin.work.deepin
    rm -rfv /home/${run_user}/Documents/Tencent Files
    rm -rfv /home/${run_user}/Documents/WeChat Files
}