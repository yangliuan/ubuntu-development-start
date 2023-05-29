#!/bin/bash
#https://pecl.php.net/package/gRPC
#https://grpc.io/docs/languages/php/quickstart/
#https://protobuf.dev/reference/php/api-docs/Google/Protobuf.html
Install_pecl_grpc() {
    if [ -e "${php_install_dir}/bin/phpize" ]; then
        pushd ${oneinstack_dir}/src > /dev/null
        PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
        phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
        PHP_main_ver=${PHP_detail_ver%.*}

        if [[ "${PHP_main_ver}" =~ 7.[0-4]$|^8.[0-2]$ ]]; then
            src_url=https://pecl.php.net/get/grpc-${grpc_ver}.tgz && Download_src
            tar xzf grpc-${grpc_ver}.tgz
            pushd grpc-${grpc_ver} > /dev/null
            ${php_install_dir}/bin/phpize
            ./configure --with-php-config=${php_install_dir}/bin/php-config
            make -j ${THREAD} && make install
            popd > /dev/null

            if [ -f "${phpExtensionDir}/grpc.so" ]; then
                echo 'extension=grpc.so' > ${php_install_dir}/etc/php.d/grpc.ini
                echo "${CSUCCESS}PHP grpc module installed successfully! ${CEND}"
                rm -rf grpc-${grpc_ver}
            else
                echo "${CFAILURE}PHP grpc module install failed, Please contact the author! ${CEND}" && lsb_release -a
            fi
        else
            echo "${CWARNING}Your php ${PHP_detail_ver} does not support grpc! ${CEND}";
        fi
        popd > /dev/null
    fi
}

Uninstall_pecl_grpc() {
    if [ -e "${php_install_dir}/etc/php.d/grpc.ini" ]; then
        rm -f ${php_install_dir}/etc/php.d/grpc.ini
        echo; echo "${CMSG}PHP grpc module uninstall completed${CEND}"
    else
        echo; echo "${CWARNING}PHP grpc module does not exist! ${CEND}"
    fi
}