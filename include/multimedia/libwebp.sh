#!/bin/bash
#DDC https://developers.google.com/speed/webp/docs/compiling#building
Install_Libwebp() {
    if [ ! -e "/usr/local/lib/libwebp.la" ]; then
        pushd ${oneinstack_dir}/src > /dev/null
        apt-get install libtiff-dev libgif-dev
        src_url=https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${libwebp_ver}.tar.gz && Download_src
        tar zxvf libwebp-${libwebp_ver}.tar.gz
        pushd libwebp-${libwebp_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libwebp-${libwebp_ver}
        popd > /dev/null
        ldconfig /usr/local/lib/
    fi 
}

Uninstall_Libwebp() {
    apt-get autoremove libtiff-dev libgif-dev
    pushd /usr/local/lib > /dev/null
    rm -rf libwebp.a libwebpdemux.a libwebpdemux.a libwebpdemux.la libwebpdemux.so \
    libwebpdemux.so.2 libwebpdemux.so.2.0.11 libwebp.la libwebpmux.a libwebpmux.la \
    libwebpmux.so libwebpmux.so.3 libwebpmux.so.3.0.10 libwebp.so libwebp.so.7 \
    libwebp.so.7.1.5
    popd > /dev/null
    pushd /usr/local/bin > /dev/null
    rm -rf cwebp dwebp webpinfo webpmux
    ldconfig /usr/local/lib/
}