#!/bin/bash
Install_navicat_premium() {
   pushd ${ubdevenv_dir}/src > /dev/null

   echo "Download navicat preminu${navicat_ver}..."
   src_url="https://download.navicat.com.cn/download/navicat${navicat_ver}-premium-cs.AppImage" && Download_src
   
   if [ ! -e "/opt/navicat" ]; then
      mkdir /opt/navicat
   fi
   # reset time
   rm -rfv /home/${run_user}/.config/dconf /home/${run_user}/.config/navicat
   cp -fv navicat${navicat_ver}-premium-cs.AppImage /opt/navicat/navicat-premium-cs.AppImage
   cp -rfv ${ubdevenv_dir}/icon/navicat.svg /opt/navicat/
   cp -rfv ${ubdevenv_dir}/desktop/Navicat.Premium.16.desktop /home/${run_user}/.local/share/applications
   chown -Rv ${run_user}.${run_group} /opt/navicat /home/${run_user}/.local/share/applications/desktop/Navicat.Premium.16.desktop
   chmod -Rv 755 /opt/navicat

   popd > /dev/null
}

Uninstall_navicat_permium() {
   rm -rfv /opt/navicat/
   rm -rfv /usr/share/applications/navicat.desktop
   rm -rf /home/${run_user}/.local/share/applications/Navicat.Premium.16.desktop
   rm -rf /home/${run_user}/.local/share/applications/Navicat.Premium.16.mime.desktop
}