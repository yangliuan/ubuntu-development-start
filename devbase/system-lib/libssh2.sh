#!/bin/bash
#https://libssh2.org/
Install_Libssh2() {
    if [ ! -e "/usr/local/lib/libssh2.la" ]; then
        pushd ${ubdevenv_dir}/src > /dev/null
        src_url=https://libssh2.org/download/libssh2-${libssh2_ver}.tar.gz && Download_src
        tar -zxvf libssh2-${libssh2_ver}.tar.gz
        pushd libssh2-${libssh2_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
    
        if [ -e "/usr/local/lib/libssh2.la" ]; then
            echo "${CSUCCESS}libssh2 installed successfully! ${CEND}"
            rm -rf libssh2-${libssh2_ver}
            ldconfig /usr/local/lib/
        else
            echo "${CFAILURE}libssh2 install failed, Please contact the author! ${CEND}" && lsb_release -a
        fi

        popd > /dev/null
    fi
}

Uninstall_Libssh2() {
    pushd /usr/local/lib > /dev/null
    rm -rf libssh2.a libssh2.la libssh2.so libssh2.so.1 libssh2.so.1.0.1
    popd > /dev/null

    pushd /usr/local/include > /dev/null
    rm -rf libssh2.h libssh2_publickey.h libssh2_sftp.h
    popd > /dev/null
    
    rm -rfv /usr/local/lib/pkgconfig/libssh2.pc
    ldconfig /usr/local/lib/
}