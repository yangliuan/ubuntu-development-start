#!/bin/bash
#https://doc.libsodium.org/
Install_Libsodium() {
    if [ ! -e "/usr/local/lib/libsodium.la" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null 
        tar xzf libsodium-${libsodium_ver}.tar.gz
        pushd libsodium-${libsodium_ver} > /dev/null
        ./configure --disable-dependency-tracking --enable-minimal
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libsodium-${libsodium_ver}
    fi
}