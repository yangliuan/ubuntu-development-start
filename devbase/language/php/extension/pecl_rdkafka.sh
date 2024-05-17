#!/bin/bash
#DOC https://arnaud.le-blanc.net/php-rdkafka-doc/phpdoc/index.html
#Repo https://github.com/arnaud-lb/php-rdkafka
#https://pecl.php.net/package/rdkafka
Install_pecl_rdkafka() {
    if [ -e "${php_install_dir}/bin/phpize" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
        PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
        phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
        PHP_main_ver=${PHP_detail_ver%.*}

        if [[ "${PHP_main_ver}" =~ ^5.[3-6]$|^7.[0-4]$|^8.[0-2]$ ]]; then
            src_url=https://pecl.php.net/get/rdkafka-${pecl_rdkafka_ver}.tgz && Download_src
            tar xzf rdkafka-${pecl_rdkafka_ver}.tgz
            pushd rdkafka-${pecl_rdkafka_ver} > /dev/null
            ${php_install_dir}/bin/phpize
            ./configure --with-php-config=${php_install_dir}/bin/php-config
            make -j ${THREAD} && make install
            popd > /dev/null
            rm -rfv rdkafka-${pecl_rdkafka_ver}

            if [ -f "${phpExtensionDir}/rdkafka.so" ]; then
                echo 'extension=rdkafka.so' > ${php_install_dir}/etc/php.d/rdkafka.ini
                echo "${CSUCCESS}PHP rdkafka module installed successfully! ${CEND}"
                rm -rf rdkafka-${pecl_rdkafka_ver}
            else
                echo "${CFAILURE}PHP rdkafka module install failed, Please contact the author! ${CEND}" && lsb_release -a
            fi
        else
            echo "${CWARNING}Your php ${PHP_detail_ver} does not support rdkafka! ${CEND}";
        fi
        popd > /dev/null
    fi
}

Uninstall_pecl_rdkafka() {
    if [ -e "${php_install_dir}/etc/php.d/rdkafka.ini" ]; then
        rm -f ${php_install_dir}/etc/php.d/rdkafka.ini
        echo; echo "${CMSG}PHP rdkafka module uninstall completed${CEND}"
    else
        echo; echo "${CWARNING}PHP rdkafka module does not exist! ${CEND}"
    fi
}