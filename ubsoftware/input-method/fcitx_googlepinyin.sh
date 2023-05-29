#!/bin/bash
# https://www.google.cn/inputtools/services/features/input-method.html#tab=pinyin
Install_GooglePinyin() {
    Install_Fcitx
    apt-get -y install fcitx-googlepinyin
}

Uninstall_GooglePinyin() {
    apt-get -y autoremove fcitx-googlepinyin
} 