#!/bin/bash
Install_Apr() {
    pushd ${ubdevenv_dir}/src/devbase/webserver > /dev/null
    if [ ! -e "${apr_install_dir}/bin/apr-1-config" ]; then
        tar xzf apr-${apr_ver}.tar.gz
        pushd apr-${apr_ver} > /dev/null
        ./configure --prefix=${apr_install_dir}
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf apr-${apr_ver}
    fi
    popd > /dev/null
}

Uninstall_Apr() {
    rm -rfv ${apr_install_dir}
}