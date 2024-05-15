#!/bin/bash
#https://linux.wps.cn/
Install_Wps() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    echo "Download wps ..."
    #11.1.0.11719
    #https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/11719/wps-office_11.1.0.11719_amd64.deb?t=1715734578&k=c5b18a0b20f299d22f017259d73c902e
    src_url="https://wps-linux-personal.wpscdn.cn/wps/download/ep/Linux2019/${wps_sub_ver}/wps-office_${wps_ver}_amd64.deb" && Download_src
    dpkg -i wps-office_${wps_ver}_amd64.deb
    apt-get -y install -f
    #rm -rfv wps-office_${wps_ver}_amd64.deb
    
    #install wps font
    src_url="http://mirror.yangliuan.cn/wps_symbol_fonts.zip" && Download_src
    unzip wps_symbol_fonts.zip -d /usr/share/fonts
    fc-cache
    chown -Rv ${run_user}:${run_group} /opt/kingsoft
    popd > /dev/null
}

Uninstall_Wps() {
    dpkg -P wps-office
}