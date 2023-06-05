#!/bin/bash
#https://github.com/P-H-C/phc-winner-argon2
Install_Libargon2() {
    if [ ! -e "/usr/local/lib/pkgconfig/libargon2.pc" ]; then
        [ ${pwd} != ${ubdevenv_dir}/src ] && [ pushd ${ubdevenv_dir}/src > /dev/null ]
        pushd ${ubdevenv_dir}/src > /dev/null
        tar xzf argon2-${argon2_ver}.tar.gz
        pushd argon2-${argon2_ver} > /dev/null
        make -j ${THREAD} && make install
        [ ! -d /usr/local/lib/pkgconfig ] && mkdir -p /usr/local/lib/pkgconfig
        /bin/cp libargon2.pc /usr/local/lib/pkgconfig/
        popd > /dev/null
        rm -rf argon2-${argon2_ver}
        popd > /dev/null
    fi
}

