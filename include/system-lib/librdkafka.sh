#!/bin/bash
#repo https://github.com/confluentinc/librdkafka
Install_Librdkafka() {
    if [ ! -e "/usr/local/lib/librdkafka.so" ]; then
        pushd ${oneinstack_dir}/src > /dev/null
        if [ ! -e "librdkafka-${librdkafka_ver}.tar.gz" ]; then
            src_url=https://github.com/confluentinc/librdkafka/archive/refs/tags/v${librdkafka_ver}.tar.gz && Download_src
            mv v${librdkafka_ver}.tar.gz librdkafka-${librdkafka_ver}.tar.gz
        fi
        
        tar -zxvf v${librdkafka_ver}.tar.gz
        pushd librdkafka-${librdkafka_ver}  > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null

        if [ -e "/usr/local/lib/librdkafka.so" ]; then
            echo "${CSUCCESS}librdkafka installed successfully! ${CEND}"
            rm -rf librdkafka-${librdkafka_ver}
            ldconfig /usr/local/lib/
        else
            echo "${CFAILURE}librdkafka install failed, Please contact the author! ${CEND}" && lsb_release -a
        fi

        popd > /dev/null
    fi
}

Uninstall_Librdkafka() {
    pushd /usr/local/lib > /dev/null
    rm -rfv librdkafka++.a librdkafka.a librdkafka++.so librdkafka.so librdkafka++.so.1 librdkafka.so.1 librdkafka-static.a
    popd > /dev/null

    pushd /usr/local/lib/pkgconfig > /dev/null
    rm -rfv rdkafka++.pc rdkafka.pc rdkafka++-static.pc rdkafka-static.pc
    popd > /dev/null

    rm -rfv /usr/local/include/librdkafka /usr/local/share/doc/librdkafka
}