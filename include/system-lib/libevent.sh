#!/bin/bash
# PC:https://libevent.org/
# REF: https://noknow.info/it/os/install_libevent_from_source
# REF: https://www.cnblogs.com/WindSun/p/12142656.html
Install_Libevent() {
    if [ ! -e "${libevent_install_dir}/lib/libevent-2.1.so.7" ]; then
        pushd ${oneinstack_dir}/src > /dev/null
        src_url=https://github.com/libevent/libevent/releases/download/release-${libevent_ver}-stable/libevent-${libevent_ver}-stable.tar.gz && Download_src
        tar -zxvf libevent-${libevent_ver}-stable.tar.gz
        pushd libevent-${libevent_ver}-stable > /dev/null
        ./configure --prefix=${libevent_install_dir}
        make -j ${THREAD} && make install
        ln -s ${libevent_install_dir}/lib/libevent-2.1.so.7 /usr/lib64/libevent-2.1.so.7
        popd > /dev/null

        if [ -e "${libevent_install_dir}/lib/libevent-2.1.so.7" ]; then
            echo "${CSUCCESS}libevent installed successfully!${CEND}" 
            rm -rf libevent-${libevent_ver}-stable
        else
            echo "${CFAILURE}libevent install failed, Please contact the author! ${CEND}" && lsb_release -a
            kill -9 $$; exit 1;
        fi

        popd > /dev/null
    fi
}