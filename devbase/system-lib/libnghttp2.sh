#!/bin/bash
Install_Libnghttp2() {
    pushd ${ubdevenv_dir}/src/devbase/webserver > /dev/null
    if [ ! -e "/usr/local/lib/libnghttp2.so" ]; then
        tar xzf nghttp2-${nghttp2_ver}.tar.gz
        pushd nghttp2-${nghttp2_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        [ -z "`grep /usr/local/lib /etc/ld.so.conf.d/*.conf`" ] && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
        ldconfig
        rm -rf nghttp2-${nghttp2_ver}
    fi
    popd > /dev/null
}

Uninstall_Libnghttp2() {
    rm -rfv /usr/local/lib/libnghttp2.so
}