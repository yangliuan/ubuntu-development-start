#!/bin/bash
Install_navicat_preminu(){
   pushd ${oneinstack_dir}/src > /dev/null
   echo "Download navicat preminu15..."
   src_url="https://download.navicat.com.cn/download/navicat15-premium-cs.AppImage" && Download_src
   
   if [ ! -e "/opt/navicat" ]; then
      mkdir /opt/navicat
   fi
   mv -fv navicat15-premium-cs.AppImage /opt/navicat/
   chown -Rv ${run_user}.${run_group} /opt/navicat/navicat15-premium-cs.AppImage
   chmod -Rv 755 /opt/navicat/navicat15-premium-cs.AppImage
   rm -rfv /home/${run_user}/.config/dconf /home/${run_user}/.config/navicat
   cp -rfv ${oneinstack_dir}/icon/navicat.png /opt/navicat/
   cp -rfv ${oneinstack_dir}/desktop/navicat.desktop /usr/share/applications/
}