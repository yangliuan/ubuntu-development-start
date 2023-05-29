#!/bin/bash
#https://page.dingtalk.com/wow/z/dingtalk/simple/ddhomedownlaod#/
Install_Dingtalk() {
    pushd ${start_dir}/src > /dev/null
    echo "Download dingtalk ..."
    src_url="https://dtapp-pub.dingtalk.com/dingtalk-desktop/xc_dingtalk_update/linux_deb/Release/com.alibabainc.dingtalk_${dingtalk_ver}_amd64.deb" && Download_src
    dpkg -i com.alibabainc.dingtalk_${dingtalk_ver}_amd64.deb
    apt-get -y install -f
    #rm -rfv com.alibabainc.dingtalk_${dingtalk_ver}_amd64.deb
    popd > /dev/null
}

Uninstall_Dingtalk() {
    dpkg -P com.alibabainc.dingtalk
}
