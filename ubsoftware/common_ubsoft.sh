#!/bin/bash
#uninstall dont need software
Remove_Unneed(){
    for unneed in ${unneed_soft}; do
        dpkg -l | grep -q ${unneed} && apt-get purge -y ${unneed}
    done
    apt-get -y autoremove
}

Install_Custome_SnapApp(){
    for csnap in ${snap_custome_packages}; do
        snap install ${csnap}
    done
}

Uninstall_Custome_SnapApp(){
    for csnap in ${snap_custome_packages}; do
        snap remove ${csnap}
    done
}

Install_Custome_AptApp(){
    for csnap in ${snap_custome_packages}; do
        apt-get install -y ${csnap}
    done
}

Uninstall_Custome_AptApp(){
    for capt in ${apt_custome_packages}; do
        apt-get install -y ${csnap}
    done
    apt-get -y autoremove
}
