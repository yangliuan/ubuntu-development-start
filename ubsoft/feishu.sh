#!/bin/bash
#https://www.feishu.cn/download
Install_Feishu() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download feishu ..."
    src_url=" https://sf3-cn.feishucdn.com/obj/ee-appcenter/${feishu_link_token}/Feishu-linux_x64-${feishu_ver}.deb" && Download_src
    dpkg -i Feishu-linux_x64-${feishu_ver}.deb
    apt-get -y install -f
    chown -R ${run_user}:${run_user} /opt/bytedance
    #rm -rfv Feishu-linux_x64-${feishu_ver}.deb
    popd > /dev/null
}

Uninstall_Feishu() {
    dpkg -P bytedance-feishu-stable
}