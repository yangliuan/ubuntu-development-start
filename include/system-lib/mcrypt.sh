#!/bin/bash
#https://mcrypt.sourceforge.net/
#https://sourceforge.net/projects/mcrypt/files/

Install_Libmcrypt() {
    if [ ! -e "/usr/local/bin/libmcrypt-config" -a ! -e "/usr/bin/libmcrypt-config" ]; then
        tar xzf libmcrypt-${libmcrypt_ver}.tar.gz
        pushd libmcrypt-${libmcrypt_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        ldconfig
        pushd libltdl > /dev/null
        ./configure --enable-ltdl-install
        make -j ${THREAD} && make install
        popd > /dev/null
        popd > /dev/null
        rm -rf libmcrypt-${libmcrypt_ver}
    fi
}

Install_Mcrypt() {
    if [ ! -e "/usr/local/bin/mcrypt" -a ! -e "/usr/bin/mcrypt" ]; then
        tar xzf mcrypt-${mcrypt_ver}.tar.gz
        pushd mcrypt-${mcrypt_ver} > /dev/null
        ldconfig
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf mcrypt-${mcrypt_ver}
    fi
}