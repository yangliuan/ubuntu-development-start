#!/bin/bash
Install_Postman() {
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download postman ..."
    src_url=https://dl.pstmn.io/download/latest/linux64 && Download_src
    tar -zxvf linux64
    mv -fv Postman /opt/postman
    chown -Rv ${run_user}.${run_group} /opt/postman
    cp -rfv ${oneinstack_dir}/desktop/postman.desktop /usr/share/applications/
    rm -rfv linux64
    popd > /dev/null
}

Unstall_Postman() {
    rm -rfv /opt/postman
    rm -rfv /usr/share/applications/postman.desktop
}