#!/bin/bash
#https://www.postman.com/
Install_Postman() {
    pushd ${ubdevenv_dir}/src/devtools > /dev/null

    echo "Download postman ..."
    if [ ! -e "postman-linux64.tar.gz" ]; then
        src_url=https://dl.pstmn.io/download/latest/linux64 && Download_src
        mv linux64 postman-linux64.tar.gz
    fi
    
    tar -zxvf postman-linux64.tar.gz
    mv -fv Postman /opt/postman
    cp -rfv ${ubdevenv_dir}/desktop/postman.desktop /usr/share/applications/
    chown -Rv ${run_user}:${run_group} /opt/postman /usr/share/applications/postman.desktop
    #rm -rfv linux64
    
    popd > /dev/null
}

Uninstall_Postman() {
    rm -rfv /opt/postman
    rm -rfv /usr/share/applications/postman.desktop
}