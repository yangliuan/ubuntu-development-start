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

Reinstall_GnomeCenter (){
    apt-get install -y gnome-control-center --reinstall
}
