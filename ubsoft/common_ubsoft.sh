#!/bin/bash
#uninstall dont need software
Remove_Unneed(){
    for unneed in ${unneed_soft}; do
        dpkg -l | grep -q ${unneed} && apt-get purge -y ${unneed}
    done
    apt-get -y autoremove
}

Install_custom_SnapApp(){
    for csnap in ${snap_custom_packages}; do
        snap install ${csnap}
    done
}

Uninstall_custom_SnapApp(){
    for csnap in ${snap_custom_packages}; do
        snap remove ${csnap}
    done
}

Install_custom_AptApp(){
    for capt in ${apt_custom_packages}; do
        apt-get install -y ${capt}
    done
}

Uninstall_custom_AptApp(){
    for capt in ${apt_custom_packages}; do
        apt-get purge -y ${capt}
    done
    apt-get -y autoremove
}
