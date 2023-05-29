#!/bin/bash
#https://doc.libsodium.org/
Install_Libsodium() {
    if [ ! -e "/usr/local/lib/libsodium.la" ]; then
        [ ${pwd} != ${oneinstack_dir}/src ] && [ pushd ${oneinstack_dir}/src > /dev/null ]
        tar xzf libsodium-${libsodium_ver}.tar.gz
        pushd libsodium-${libsodium_ver} > /dev/null
        ./configure --disable-dependency-tracking --enable-minimal
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libsodium-${libsodium_ver}
    fi
}