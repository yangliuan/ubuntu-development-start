#!/bin/bash
Install_AprUtil() {
    pushd ${ubdevenv_dir}/src/devbase/webserver > /dev/null
    if [ ! -e "${apr_install_dir}/bin/apu-1-config" ]; then
        tar xzf apr-util-${apr_util_ver}.tar.gz
        pushd apr-util-${apr_util_ver} > /dev/null
        ./configure --prefix=${apr_install_dir} --with-apr=${apr_install_dir}
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf apr-util-${apr_util_ver}
    fi
    popd > /dev/null
}

Uninstall_AprUtil() {
    rm -rfv ${apr_install_dir}
}