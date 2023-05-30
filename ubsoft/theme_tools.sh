#!/bin/bash
Install_ThemeTools() {
    if [ "${Ubuntu_ver}" == "22" ]; then
        apt-get -y install gnome-tweaks
    else
        apt-get -y install gnome-tweak-tool
    fi
    
    apt-get -y install chrome-gnome-shell
    apt-get -y install gnome-shell-extensions
}

Uninstall_ThemeTools() {
    if [ "${Ubuntu_ver}" == "22" ]; then
        apt-get -y autoremove gnome-tweaks
    else
        apt-get -y autoremove gnome-tweak-tool
    fi
    
    apt-get -y autoremove chrome-gnome-shell
    apt-get -y autoremove gnome-shell-extensions
}
