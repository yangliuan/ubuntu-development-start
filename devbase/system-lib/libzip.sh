#!/bin/bash
#https://github.com/P-H-C/phc-winner-argon2
Install_Libzip() {
    if [ ! -e "/usr/local/lib/libzip.la" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
        tar xzf libzip-${libzip_ver}.tar.gz
        pushd libzip-${libzip_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libzip-${libzip_ver}
    fi
}