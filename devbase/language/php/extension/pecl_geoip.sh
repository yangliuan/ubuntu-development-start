#!/bin/bash
Install_Geoip() {
    apt-get -y install libgeoip-dev
}

Uninstall_Geoip() {
    apt-get -y remove libgeoip-dev
}

Install_pecl_geoip() {
    if [ -e "${php_install_dir}/bin/phpize" ]; then
        PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
        PHP_main_ver=${PHP_detail_ver%.*}
        pushd ${ubdevenv_dir}/src > /dev/null
        src_url=https://pecl.php.net/get/geoip-${pecl_geoip_ver}.tgz && Download_src
        tar xzf geoip-${pecl_geoip_ver}.tgz
        geoip-${pecl_geoip_ver}.tgz  > /dev/null
        ${php_install_dir}/bin/phpize
        ./configure --with-php-config=${php_install_dir}/bin/php-config
        make -j ${THREAD} && make install
        popd > /dev/null

        if [ -f "${phpExtensionDir}/geoip.so" ]; then
            echo 'extension=geoip.so' > ${php_install_dir}/etc/php.d/geoip.ini
            echo "${CSUCCESS}PHP geoip module installed successfully! ${CEND}"
            rm -rf geoip-${pecl_geoip_ver}.tgz
        else
            echo "${CFAILURE}PHP geoip module install failed, Please contact the author! ${CEND}" && lsb_release -a
        fi
    fi
}

Uninstall_pecl_geoip() {
    if [ -e "${php_install_dir}/etc/php.d/geoip.ini" ]; then
        rm -rf ${php_install_dir}/etc/php.d/geoip.ini
        echo; echo "${CMSG}PHP eaccelerator module uninstall completed${CEND}"
    else
        echo; echo "${CWARNING}PHP eaccelerator module does not exist! ${CEND}"
    fi
}