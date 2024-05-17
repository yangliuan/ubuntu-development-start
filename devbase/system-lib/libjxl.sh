#!/bin/bash
#https://github.com/libjxl/libjxl
Install_Libjxl() {
    pushd ${ubdevenv_dir}/src/devbase/library > /dev/null
    src_url=https://github.com/libjxl/libjxl/releases/download/v${libjxl_ver}/jxl-debs-amd64-ubuntu-22.04-v${libjxl_ver}.tar.gz && Download_src
    apt-get install -y libhwy-dev libtcmalloc-minimal4
    tar -zxvf jxl-debs-amd64-ubuntu-22.04-v${libjxl_ver}.tar.gz
    dpkg -i libjxl_${libjxl_ver}_amd64.deb libjxl-dev_${libjxl_ver}_amd64.deb
        
    rm -rf libjxl-gdk-pixbuf-dbgsym_${libjxl_ver}_amd64.ddeb libjxl-gdk-pixbuf_${libjxl_ver}_amd64.deb libjxl-gimp-plugin_${libjxl_ver}_amd64.deb libjxl-dbgsym_${libjxl_ver}_amd64.ddeb jxl_${libjxl_ver}_amd64.deb libjxl_${libjxl_ver}_amd64.deb libjxl-dev_${libjxl_ver}_amd64.deb libjxl-gimp-plugin-dbgsym_${libjxl_ver}_amd64.ddeb jxl-dbgsym_${libjxl_ver}_amd64.ddeb
    popd > /dev/null
}

Uninstall_Libjxl() {
    dpkg -p libjxl_${libjxl_ver}_amd64.deb libjxl-dev_${libjxl_ver}_amd64.deb
}
