#!/bin/bash
Install_PatchSuport() {
    if [ -f "${ubdevenv_dir}/data/ubsoftpatch.lock" ]; then
        echo "ubuntu ${ubuntu_name} patched"
    else
        Install_Appimage
        Install_XdgDesktopPortalGnome
        Install_Ntfs3g
        ResetTimeForWindow
        Patch_Lock
    fi
}

Patch_Lock() {
    touch ${ubdevenv_dir}/data/ubsoftpatch.lock
    date +"%Y-%m-%d %H:%M:%S" > ${ubdevenv_dir}/data/ubsoftpatch.lock
    chmod -R 611 ${ubdevenv_dir}/data/ubsoftpatch.lock
}

#support run application then extension to Appimage
#Rerf  https://askubuntu.com/questions/1403811/appimage-on-ubuntu-22-04
Install_Appimage() {
    add-apt-repository -y universe
    apt-get update && apt-get upgrade
    apt-get install -y libfuse2
}

#browser crush when downloading or uploading
#Rerf https://askubuntu.com/questions/1402530/running-any-chromium-based-browser-in-ubuntu-22-04-freezes
Install_XdgDesktopPortalGnome() {
    if ! dpkg -s xdg-desktop-portal-gnome >/dev/null 2>&1; then
        apt-get install -y xdg-desktop-portal-gnome
    fi
}

#ntfs support
#https://github.com/tuxera/ntfs-3g/wiki
Install_Ntfs3g() {
    if ! dpkg -s ntfs-3g >/dev/null 2>&1; then
        apt-get install -y ntfs-3g
    fi
}

#Dual system hold time is the same
#Rerf https://www.cnblogs.com/xiaotong-sun/p/16138941.html
ResetTimeForWindow() {
    apt-get install -y ntpdate
    ntpdate time.windows.com

    if [[ "$Ubuntu_ver" == "24" ]]; then
        apt-get install util-linux-extra
        hwclock --localtime --systohc
    fi
}

#https://github.com/linux-surface/linux-surface/wiki/Installation-and-Setup
Surface_Support() {
    if [ ! -e "/etc/apt/trusted.gpg.d/linux-surface.gpg" ];then
        #First you need to import the keys we use to sign packages.
        wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | gpg --dearmor | dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg
    fi

    if [ ! -e "/etc/apt/sources.list.d/linux-surface.list" ];then
        #After this you can add the repository configuration and update APT.
        echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" | tee /etc/apt/sources.list.d/linux-surface.list
    fi
    
    #update
    apt-get update
    #
    apt-get install -y linux-image-surface linux-headers-surface libwacom-surface iptsd
    apt-get install -y linux-surface-secureboot-mok
}

#https://github.com/linux-surface/linux-surface/wiki/Known-Issues-and-FAQ#apt-update-fails-on-ubuntudebian-based-distributions-with-error-401-unauthorized
# AptUrlFix() {
#     add-apt-repository ppa:gpxbv/apt-urlfix
#     apt-get update
#     apt-get install apt
# }

Reinstall_GnomeCenter (){
    apt-get install -y gnome-control-center --reinstall
}
