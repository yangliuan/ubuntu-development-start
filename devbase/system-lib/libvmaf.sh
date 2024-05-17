#!/bin/bash
#DOC: https://github.com/Netflix/vmaf/blob/master/libvmaf/README.md
Install_Libvmaf() {
    if [ ! -e "/usr/local/include/libvmaf" ]; then
        pushd ${ubdevenv_dir}/src/devbase/library > /dev/null
        apt-get -y install meson nasm ninja-build doxygen xxd
        
        if [ ! -e "libvmaf-${libvmaf_ver}.tar.gz" ]; then
            src_url=https://github.com/Netflix/vmaf/archive/v${libvmaf_ver}.tar.gz && Download_src
            mv v${libvmaf_ver}.tar.gz libvmaf-${libvmaf_ver}.tar.gz
        fi

        tar -zxvf libvmaf-${libvmaf_ver}.tar.gz > /dev/null
        pushd vmaf-${libvmaf_ver}/libvmaf > /dev/null
        meson build --buildtype release
        ninja -vC build
        ninja -vC build install
        popd > /dev/null
        rm -rf vmaf-${libvmaf_ver}
        popd > /dev/null
    fi
}

Uninstall_Libvmaf() {
    pushd /usr/local/lib/x86_64-linux-gnu > /dev/null
    rm -rfv libvmaf.so.1.1.1 libvmaf.a libvmaf.so libvmaf.so.1 libvmaf.so.1.1.1 pkgconfig/libvmaf.pc
    popd > /dev/null
    rm -rfv /usr/local/include/libvmaf /usr/local/bin/vmaf
}