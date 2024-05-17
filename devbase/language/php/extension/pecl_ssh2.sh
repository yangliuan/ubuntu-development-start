#!/bin/bash
#https://pecl.php.net/package/ssh2
#https://www.php.net/manual/zh/book.ssh2.php
Install_pecl_ssh2() {
    if [ -e "${php_install_dir}/bin/phpize" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
        PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
        phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
        PHP_main_ver=${PHP_detail_ver%.*}

        if [[ "${PHP_main_ver}" =~ ^7.[0-4]$|^8.[0-2]$ ]]; then
            src_url=https://pecl.php.net/get/ssh2-${pecl_ssh2_ver}.tgz && Download_src
            tar xzf ssh2-${pecl_ssh2_ver}.tgz
            pushd ssh2-${pecl_ssh2_ver} > /dev/null
        else
            src_url=https://pecl.php.net/get/ssh2-${pecl_ssh2_oldver}.tgz && Download_src
            tar xzf ssh2-${pecl_ssh2_oldver}.tgz
            pushd ssh2-${pecl_ssh2_oldver} > /dev/null
        fi

        ${php_install_dir}/bin/phpize
        ./configure --with-php-config=${php_install_dir}/bin/php-config --with-ssh2
        make -j ${THREAD} && make install
        popd > /dev/null
        
        if [ -f "${phpExtensionDir}/ssh2.so" ]; then
            echo "extension=ssh2.so" > ${php_install_dir}/etc/php.d/ssh2.ini
            echo "${CSUCCESS}PHP ssh2 module installed successfully! ${CEND}"
            rm -rf ssh2-${pecl_ssh2_ver} ssh2-${pecl_ssh2_oldver}
        else
            echo "${CFAILURE}PHP ssh2 module install failed, Please contact the author! ${CEND}" && lsb_release -a
        fi
        popd > /dev/null
    fi
}

Uninstall_pecl_ssh2() {
    if [ -e "${php_install_dir}/etc/php.d/ssh2.ini" ]; then
        rm -rf ${php_install_dir}/etc/php.d/ssh2.ini
        echo; echo "${CMSG}PHP ssh2 module uninstall completed${CEND}"
    else
        echo; echo "${CWARNING}PHP ssh2 module does not exist! ${CEND}"
    fi
}