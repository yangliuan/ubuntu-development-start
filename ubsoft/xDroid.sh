#!/bin/bash
#安卓模拟器
#DOC:https://www.linzhuotech.com/Product/download
Install_xDroid() {
    pushd ${ubdevenv_dir}/src/ubsoft > /dev/null
    echo "Download xDroid ..."
    src_url="https://d6.injdk.cn/xdroid/xDroidInstall-x86_64-v${xDroid_ver}-${xDroid_release_time}.run.tar.gz" && Download_src
    tar -zxvf xDroidInstall-x86_64-v${xDroid_ver}-${xDroid_release_time}.run.tar.gz
    sudo -u ${run_user} ./xDroidInstall-x86_64-v${xDroid_ver}-${xDroid_release_time}.run
    #rm -rf xDroidInstall-x86_64-v${xDroid_ver}.run.tar.gz xDroidInstall-x86_64-v${xDroid_ver}.run
    popd > /dev/null
}

Uninstall_xDroid() {
   [ -d "/opt/xdroid/uninstall" ] && sudo -u ${run_user} /opt/xdroid/uninstall
}