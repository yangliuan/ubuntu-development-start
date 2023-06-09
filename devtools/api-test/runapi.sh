#!/bin/bash
Install_Runapi() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download runapi..."
    if [ ! -e "runapi.deb" ]; then
        src_url="https://www.showdoc.com.cn/server/api/attachment/visitFile?sign=e0fb3d738511c03fafd73ef9e484a0d4" && Download_src
        mv visitFile?sign=e0fb3d738511c03fafd73ef9e484a0d4 runapi.deb
    fi
    dpkg -i runapi.deb
    [ -d "/opt/runapi" ] && chown -R ${run_user}.${run_group} /opt/runapi
    popd > /dev/null
}

Uninstall_Runapi() {
    dpkg -P runapi
}