#!/bin/bash
#https://linux.wps.cn/
Install_Wps() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download wps ..."
    src_url="https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/${wps_sub_ver}/wps-office_${wps_ver}_amd64.deb" && Download_src
    dpkg -i wps-office_${wps_ver}_amd64.deb
    apt-get -y install -f
    #rm -rfv wps-office_${wps_ver}_amd64.deb
    
    #install wps font
    src_url="http://mirror.yangliuan.cn/wps_symbol_fonts.zip" && Download_src
    unzip wps_symbol_fonts.zip -d /usr/share/fonts
    fc-cache
    chown -Rv ${run_user}.${run_group} /opt/kingsoft
    popd > /dev/null
}

Uninstall_Wps() {
    dpkg -P wps-office
}