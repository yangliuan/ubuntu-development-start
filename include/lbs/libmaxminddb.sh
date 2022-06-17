#!/bin/bash
Install_libmaxminddb() {
    pushd ${oneinstack_dir}/src > /dev/null
    
    if [ ! -f "libmaxminddb-${libmaxminddb_ver}.tar.gz" ]; then
        src_url=https://github.com/maxmind/libmaxminddb/releases/download/${libmaxminddb_ver}/libmaxminddb-${libmaxminddb_ver}.tar.gz && Download_src
    fi

    tar xzf libmaxminddb-${libmaxminddb_ver}.tar.gz
    cd libmaxminddb-${libmaxminddb_ver}
    ./configure
    make -j ${THREAD} && make install
    rm -rf libmaxminddb-${libmaxminddb_ver}
    popd > /dev/null
}

Uninstall_libmaxminddb() {
    rm -rf /usr/local/libmaxminddb
}