#!/bin/bash
#PECL_DOC 

Install_pecl_redis() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${oneinstack_dir}/src > /dev/null
    phpExtensionDir=`${php_install_dir}/bin/php-config --extension-dir`
    if [ "$(${php_install_dir}/bin/php-config --version | awk -F. '{print $1}')" == '5' ]; then
      tar xzf redis-${pecl_redis_oldver}.tgz
      pushd redis-${pecl_redis_oldver} > /dev/null
    else
      tar xzf redis-${pecl_redis_ver}.tgz
      pushd redis-${pecl_redis_ver} > /dev/null
    fi
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config
    make -j ${THREAD} && make install
    popd > /dev/null
    if [ -f "${phpExtensionDir}/redis.so" ]; then
      echo 'extension=redis.so' > ${php_install_dir}/etc/php.d/redis.ini
      echo "${CSUCCESS}PHP Redis module installed successfully! ${CEND}"
      rm -rf redis-${pecl_redis_ver} redis-${pecl_redis_oldver}
    else
      echo "${CFAILURE}PHP Redis module install failed, Please contact the author! ${CEND}" && lsb_release -a
    fi
    popd > /dev/null
  fi
}

Uninstall_pecl_redis() {
  if [ -e "${php_install_dir}/etc/php.d/redis.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/redis.ini
    echo; echo "${CMSG}PHP redis module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP redis module does not exist! ${CEND}"
  fi
}