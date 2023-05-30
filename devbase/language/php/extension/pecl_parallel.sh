#!/bin/bash
# https://github.com/krakjoe/parallel
# https://www.php.net/parallel
# https://pecl.php.net/package/parallel

Install_pecl_parallel() { 
    if [ -e "${php_install_dir}/bin/phpize" ]; then
        pushd ${ubdevenv_dir}/src > /dev/null
        PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
        phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
        PHP_main_ver=${PHP_detail_ver%.*}

        if [[ "${PHP_main_ver}" =~ 7.[2-4]$ ]]; then
            src_url=https://pecl.php.net/get/parallel-1.1.4.tgz && Download_src
            tar xzf parallel-1.1.4.tgz
            pushd parallel-1.1.4 > /dev/null
            ${php_install_dir}/bin/phpize
            ./configure --with-php-config=${php_install_dir}/bin/php-config
            make -j ${THREAD} && make install
            popd > /dev/null
        elif [[ "${PHP_main_ver}" =~ 8.[0-2]$ ]];then
            src_url=https://pecl.php.net/get/parallel-${parallel_ver}.tgz && Download_src
            tar xzf parallel-${parallel_ver}.tgz
            pushd parallel-${parallel_ver}
            ${php_install_dir}/bin/phpize
            ./configure --with-php-config=${php_install_dir}/bin/php-config
            make -j ${THREAD} && make install
            popd > /dev/null
        else
            echo; echo "${CWARNING}Your php ${PHP_detail_ver} does not support parallel! ${CEND}";
        fi

        if [ -f "${phpExtensionDir}/parallel.so" ]; then
            echo 'extension=parallel.so' > ${php_install_dir}/etc/php.d/parallel.ini
            echo "${CSUCCESS}PHP parallel module installed successfully! ${CEND}"
            
            if [[ "${PHP_main_ver}" =~ 7.[2-4]$ ]]; then
                rm -rf parallel-1.1.4
            else
                rm -rf parallel-${parallel_ver}
            fi
        else
            echo "${CFAILURE}PHP event module install failed, Please contact the author! ${CEND}" && lsb_release -a
        fi

        popd > /dev/null
    fi
}

Uninstall_pecl_parallel() {
    if [ -e "${php_install_dir}/etc/php.d/parallel.ini" ]; then
        rm -f ${php_install_dir}/etc/php.d/parallel.ini
        echo; echo "${CMSG}PHP parallel module uninstall completed${CEND}"
    fi
}
