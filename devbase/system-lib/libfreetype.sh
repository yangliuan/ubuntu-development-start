#!/bin/bash
#https://freetype.org/
Install_Libfreetype() {
    if [ ! -e "${freetype_install_dir}/lib/libfreetype.la" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
        tar xzf freetype-${freetype_ver}.tar.gz
        pushd freetype-${freetype_ver} > /dev/null
        ./configure --prefix=${freetype_install_dir} --enable-freetype-config
        make -j ${THREAD} && make install
        ln -sf ${freetype_install_dir}/include/freetype2/* /usr/include/
        [ -d /usr/lib/pkgconfig ] && /bin/cp ${freetype_install_dir}/lib/pkgconfig/freetype2.pc /usr/lib/pkgconfig/
        popd > /dev/null
        rm -rf freetype-${freetype_ver}
        popd > /dev/null
    fi
}

Uninstall_Libfreetype() {
    rm -rf ${freetype_install_dir} /usr/lib/pkgconfig/freetype2.pc
}