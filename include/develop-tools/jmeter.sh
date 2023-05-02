#!/bin/bash
#https://jmeter.apache.org/
Install_Jmeter() {
    pushd ${oneinstack_dir}/src > /dev/null

    echo "Download jmeter ..."
    src_url="http://mirror.yangliuan.cn/apache-jmeter-${jmeter_ver}.zip" && Download_src
    unzip apache-jmeter-${jmeter_ver}.zip
    mv -fv apache-jmeter-${jmeter_ver} /opt/jmeter
    cp -rfv ${oneinstack_dir}/desktop/jmeter.desktop /usr/share/applications/
    chown -Rv ${run_user}.${run_group} /opt/jmeter
    chmod -Rv 755 /opt/jmeter
    #rm -rfv apache-jmeter-${jmeter_ver}.zip
    
    popd > /dev/null
}

Uninstall_Jmeter() {
    rm -rfv /opt/jmeter
    rm -rfv /usr/share/applications/jmeter.desktop
}