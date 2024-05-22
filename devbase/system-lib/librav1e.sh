#!/bin/bash
Install_Librav1e() {
    pushd ${ubdevenv_dir}/src/devbase/library > /dev/null
    src_url=https://github.com/xiph/rav1e/releases/download/v${librav1e_ver}/librav1e-${librav1e_ver}-linux-generic.tar.gz && Download_src
    tar -zxvf librav1e-${librav1e_ver}-linux-generic.tar.gz
    mv -fv include/rav1e /usr/include/
    mv -fv lib/pkgconfig/rav1e.pc /usr/lib/x86_64-linux-gnu/pkgconfig/
    mv -fv lib/librav1e.a lib/librav1e.so lib/librav1e.so.0 lib/librav1e.so.0.6.6 /usr/lib
    rm -rfv include lib
    popd > /dev/null
}

Uninstall_Librav1e() {
    rm -rf /usr/include/rav1e
    rm -rf /usr/lib/x86_64-linux-gnu/pkgconfig/rav1e.pc
    rm -rf /usr/lib/librav1e.so.0.6.6 /usr/lib/librav1e.so.0 /usr/lib/librav1e.a
}