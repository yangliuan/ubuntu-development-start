#!/bin/bash
Install_Kvazaar() {
    pushd ${ubdevenv_dir}/src/devbase/library > /dev/null
    src_url=https://github.com/ultravideo/kvazaar/releases/download/v${kvazaar_ver}/kvazaar-${kvazaar_ver}.tar.gz && Download_src

    if [ ! -e "/usr/local/bin/kvazaar" ]; then
        tar -zxvf kvazaar-${kvazaar_ver}.tar.gz
        pushd kvazaar-${kvazaar_ver} > /dev/null
        ./autogen.sh
        ./configure
        make -j ${THREAD} && make install
        ldconfig
        popd > /dev/null
        rm -rf kvazaar-${kvazaar_ver}
    fi 

    popd > /dev/null
}

Uninstall_Kvazaar() {
    rm -rf /usr/local/bin/kvazaar /usr/local/include/kvazaar.h /usr/local/lib/pkgconfig/ /usr/local/share/doc/kvazaar /usr/local/share/man/man1/kvazaar.1
}