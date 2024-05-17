#!/bin/bash
Install_Mhash() {
    if [ ! -e "/usr/local/include/mhash.h" -a ! -e "/usr/include/mhash.h" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
        tar xzf mhash-${mhash_ver}.tar.gz
        pushd mhash-${mhash_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf mhash-${mhash_ver}
        popd > /dev/null
    fi
}