#!/bin/bash
Install_Fcitx() {
    if [ ! -f "/usr/bin/fcitx" ]; then
        apt-get install -y fcitx
    fi
}

Uninstall_Fcitx() {
    apt-get autoremove -y fcitx
}