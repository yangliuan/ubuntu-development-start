#!/bin/bash
Install_navicat_preminu(){
   pushd ${oneinstack_dir}/src > /dev/null
   echo "Download navicat preminu15..."
   src_url="https://download.navicat.com.cn/download/navicat15-premium-cs.AppImage" && Download_src
   
   if [ ! -e "/opt/navicat15" ]; then
      mkdir /opt/navicat15
   fi
   mv -fv navicat15-premium-cs.AppImage /opt/navicat
}