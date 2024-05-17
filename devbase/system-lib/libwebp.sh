#!/bin/bash
#DDC https://developers.google.com/speed/webp/docs/compiling#building
Install_Libwebp() {
    if [ ! -e "/usr/local/lib/libwebp.la" ]; then
        pushd ${ubdevenv_dir}/src/devbase/library > /dev/null
        #apt-get install -y libtiff-dev libgif-dev
        src_url=https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${libwebp_ver}.tar.gz && Download_src
        tar zxvf libwebp-${libwebp_ver}.tar.gz
        pushd libwebp-${libwebp_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null

        if [ -e "/usr/local/lib/libwebp.la" ]; then
            echo "${CSUCCESS}libwebp installed successfully! ${CEND}"
            rm -rf libwebp-${libwebp_ver}
            ldconfig /usr/local/lib/
        else
            echo "${CFAILURE}libwebp install failed, Please contact the author! ${CEND}" && lsb_release -a
        fi

        popd > /dev/null
    fi 
}

Uninstall_Libwebp() {
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