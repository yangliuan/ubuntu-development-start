#!/bin/bash
#https://github.com/fossfreedom/indicator-sysmonitor
Install_IndicatorSysmonitor() {
    apt-get install -y python3-psutil gir1.2-appindicator3-0.1
    pushd ${ubdevenv_dir}/src > /dev/null
    src_url="http://mirror.yangliuan.cn/indicator-sysmonitor.tar.xz" && Download_src
    tar xJf indicator-sysmonitor.tar.xz
    pushd indicator-sysmonitor > /dev/null
    make install
    popd > /dev/null
    rm -rf indicator-sysmonitor
    #chown -R ${run_user}.${run_group} /usr/bin/indicator-sysmonitor /usr/lib/indicator-sysmonitor /usr/share/applications/indicator-sysmonitor.desktop
    chmod -R 755 /usr/bin/indicator-sysmonitor /usr/lib/indicator-sysmonitor /usr/share/applications/indicator-sysmonitor.desktop
    popd > /dev/null
    #nohup indicator-sysmonitor &
}

Uninstall_IndicatorSysmonitor() {
    apt-get autoremove -y gir1.2-appindicator3-0.1
    rm -rf /usr/lib/indicator-sysmonitor /usr/bin/indicator-sysmonitor
}
