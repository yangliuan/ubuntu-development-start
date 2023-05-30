#!/bin/bash
#https://www.gnu.org/software/libiconv/
#https://www.php.net/manual/zh/iconv.installation.php

Install_Libiconv() {
    if [ ! -e "${libiconv_install_dir}/lib/libiconv.la" ]; then
        pushd ${ubdevenv_dir}/src > /dev/null
        tar xzf libiconv-${libiconv_ver}.tar.gz
        pushd libiconv-${libiconv_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libiconv-${libiconv_ver}
    fi
}

