#!/bin/bash
#https://github.com/fossfreedom/indicator-sysmonitor
Install_IndicatorSysmonitor() {
    apt-get install -y python3-psutil gir1.2-appindicator3-0.1
    pushd ${start_dir}/src > /dev/null
    src_url="http://mirror.yangliuan.cn/indicator-sysmonitor.tar.xz" && Download_src
    tar xJf indicator-sysmonitor.tar.xz
    pushd indicator-sysmonitor > /dev/null
    make install
    popd > /dev/null
    rm -rf indicator-sysmonitor
    popd > /dev/null
    #nohup indicator-sysmonitor &
}

Uninstall_IndicatorSysmonitor() {
    apt-get autoremove -y gir1.2-appindicator3-0.1
    rm -rf /usr/lib/indicator-sysmonitor /usr/bin/indicator-sysmonitor
}
