#!/bin/bash
# swoole debug tools
# Repo:https://github.com/swoole/yasd
# Doc: https://huanghantao.github.io/yasd-wiki/#/
# Video:
# 介绍 https://www.bilibili.com/video/BV1kF411E7tk?spm_id_from=333.337.search-card.all.click&vd_source=161c4503364159edc690958e99016a1d
# IDE https://www.bilibili.com/video/BV1tq4y1t7ep?spm_id_from=333.337.search-card.all.click&vd_source=161c4503364159edc690958e99016a1d
# CMD https://www.bilibili.com/video/BV1AS4y1k7NH?spm_id_from=333.337.search-card.all.click&vd_source=161c4503364159edc690958e99016a1d

Install_Yasd() {
    apt-get install libboost-all-dev

    if [ -e "${php_install_dir}/bin/phpize" ]; then
        pushd ${oneinstack_dir}/src > /dev/null
        phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
        PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)

        if [ [ "${PHP_main_ver}" =~ ^7.[2-4]$|^8.[0-1]$ ] ]; then
            src_url=https://github.com/swoole/yasd/archive/refs/tags/v${yasd_ver}.tar.gz && Download_src
            tar -zxvf v${yasd_ver}.tar.gz
            pushd yasd-${yasd_ver} > /dev/null
            ${php_install_dir}/bin/phpize
            ./configure --with-php-config=${php_install_dir}/bin/php-config
            make -j ${THREAD} && make install

            if [ -f "${phpExtensionDir}/yasd.so" ]; then
            cat > ${php_install_dir}/etc/php.d/yasd.ini << EOF
[yasd]
zend_extension=yasd
yasd.debug_mode=remote
yasd.remote_host=127.0.0.1
yasd.remote_port=9000
EOF
                echo "${CSUCCESS}PHP yasd module installed successfully! ${CEND}"
                rm -rf yasd-${yasd_ver}
            else
                echo "${CFAILURE}PHP yasd module install failed, Please contact the author! ${CEND}" && lsb_release -a
            fi
        fi

        echo "${CWARNING}Your php ${PHP_detail_ver} does not support yasd! ${CEND}";
        popd > /dev/null
    fi
}

Uninstall_Yasd() {
    apt-get autoremove libboost-all-dev
    if [ -e "${php_install_dir}/etc/php.d/yasd.ini" ]; then
        rm -f ${php_install_dir}/etc/php.d/yasd.ini
        echo; echo "${CMSG}PHP yasd module uninstall completed${CEND}"
    else
        echo; echo "${CWARNING}PHP yasd module does not exist! ${CEND}"
    fi
}
