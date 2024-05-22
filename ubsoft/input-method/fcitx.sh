#!/bin/bash
Install_Fcitx() {
    if [ ! -f "/usr/bin/fcitx" ]; then
        apt-get install -y fcitx
    fi
}

Uninstall_Fcitx() {
    apt-get autoremove -y fcitx
}

Install_Fcitx5Pinyin() {
    if [ ! -f "/usr/bin/fcitx5" ]; then
        apt-get install -y fcitx5 fcitx5-pinyin
    fi
}

Uninstall_Fcitx5Pinyin(){
    apt-get autoremove -y fcitx5 fcitx5-pinyin
}
