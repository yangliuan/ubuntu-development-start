#!/bin/bash
Install_Icu4c() {
    pushd ${ubdevenv_dir}/src/devbase/library > /dev/null
    if ! command -v icu-config > /dev/null 2>&1 || icu-config --version | grep '^3.' || [ "${Ubuntu_ver}" == "20" ]; then
        tar xzf icu4c-${icu4c_ver}-src.tgz
            pushd icu/source > /dev/null
            ./configure --prefix=/usr/local
            make -j ${THREAD} && make install
            popd > /dev/null
        rm -rf icu
    fi
    popd > /dev/null
}

Uninstall_Icu4c() {
    rm -rf /usr/local/lib/icu/${icu4c_ver}
    pushd /usr/local/lib/pkgconfig > /dev/null
    rm -rf icu-uc.pc icu-i18n.pc icu-io.pc
    popd > /dev/null
    rm -rf /usr/local/share/man/man1/icu-config.1
}