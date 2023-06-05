#!/bin/bash
#https://curl.se/
Install_Libcurl_PHP5() {
    if [ ! -e "${curl_install_dir}/lib/libcurl.la" ]; then
        pushd ${ubdevenv_dir}/src > /dev/null
        tar xzf curl-${curl_ver}.tar.gz
        pushd curl-${curl_ver} > /dev/null
        [ -e "/usr/local/lib/libnghttp2.so" ] && with_nghttp2='--with-nghttp2=/usr/local'
        ./configure --prefix=${curl_install_dir} ${php5_with_ssl} ${with_nghttp2}
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf curl-${curl_ver}
        popd > /dev/null
    fi
}