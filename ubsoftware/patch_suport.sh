#!/bin/bash
Install_PatchSuport() {
    if [ -f "/var/lock/patch.lock" ]; then
        echo 'ubuntu 2204 patched'
    else
        Install_Appimage
        Install_XdgDesktopPortalGnome
        Install_Ntfs3g
        ResetTimeForWindow
        Patch_Lock
    fi
}

Patch_Lock() {
    [ ! -d "/var/lock" ] || mkdir -p /var/lock
    touch /var/lock/patch.lock
    date +"%Y-%m-%d %H:%M:%S" > /var/lock/patch.lock
}

#无法运行appimage问题
#REF https://coolandroid.blog.csdn.net/article/details/124403162?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-124403162-blog-124639425.pc_relevant_multi_platform_featuressortv2dupreplace&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-124403162-blog-124639425.pc_relevant_multi_platform_featuressortv2dupreplace&utm_relevant_index=1
Install_Appimage() {
    apt-get install -y fuse libfuse2
    modprobe fuse >/dev/null 2>&1
    groupadd fuse >/dev/null 2>&1
    usermod -a -G fuse ${run_user} >/dev/null 2>&1
}

#浏览器上传下载卡住问题
#REF https://askubuntu.com/questions/1402530/running-any-chromium-based-browser-in-ubuntu-22-04-freezes
Install_XdgDesktopPortalGnome() {
    apt-get install -y xdg-desktop-portal-gnome
}

#ntfs支持
#https://github.com/tuxera/ntfs-3g/wiki
Install_Ntfs3g() {
    apt-get install -y ntfs-3g
}

#防止gnome依赖出现问题导致设置中心无法使用
Reinstall_GnomeCenter (){
    apt-get install -y gnome-control-center --reinstall
}

#双系统保持时间一致
#REF https://www.cnblogs.com/xiaotong-sun/p/16138941.html
ResetTimeForWindow() {
    apt-get install -y ntpdate
    ntpdate time.windows.com
    hwclock --localtime --systohc
}
