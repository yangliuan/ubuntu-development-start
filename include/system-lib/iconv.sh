#!/bin/bash
#https://www.gnu.org/software/libiconv/
#https://www.php.net/manual/zh/iconv.installation.php

Install_Libiconv() {
    if [ ! -e "${libiconv_install_dir}/lib/libiconv.la" ]; then
        pushd ${oneinstack_dir}/src > /dev/null
        tar xzf libiconv-${libiconv_ver}.tar.gz
        pushd libiconv-${libiconv_ver} > /dev/null
        ./configure --prefix=${libiconv_install_dir}
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libiconv-${libiconv_ver}
        ln -s ${libiconv_install_dir}/lib/libiconv.so.2 /usr/lib64/libiconv.so.2
    fi
}

