#!/bin/bash
# PECL_DOC:https://pecl.php.net/package/memcache
# PHP_DOC:https://www.php.net/manual/zh/book.memcache.php

Install_pecl_memcache() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
    phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
    PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
    PHP_main_ver=${PHP_detail_ver%.*}
    if [ "$(${php_install_dir}/bin/php-config --version | awk -F. '{print $1}')" == '5' ]; then
      tar xzf memcache-3.0.8.tgz
      pushd memcache-3.0.8 > /dev/null
    elif [ "$(${php_install_dir}/bin/php-config --version | awk -F. '{print $1}')" == '7' ]; then
      #git clone https://github.com/websupport-sk/pecl-memcache.git
      tar xzf memcache-${pecl_memcache_oldver}.tgz
      pushd memcache-${pecl_memcache_oldver} > /dev/null
    else
      tar xzf memcache-${pecl_memcache_ver}.tgz
      pushd memcache-${pecl_memcache_ver} > /dev/null
    fi
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config
    make -j ${THREAD} && make install
    popd > /dev/null
    if [ -f "${phpExtensionDir}/memcache.so" ]; then
      echo "extension=memcache.so" > ${php_install_dir}/etc/php.d/memcache.ini
      echo "${CSUCCESS}PHP memcache module installed successfully! ${CEND}"
      rm -rf memcache-3.0.8 memcache-${pecl_memcache_ver} memcache-${pecl_memcache_oldver}
    else
      echo "${CFAILURE}PHP memcache module install failed, Please contact the author! ${CEND}" && lsb_release -a
    fi
    popd > /dev/null
  fi
}

Uninstall_pecl_memcache() {
  if [ -e "${php_install_dir}/etc/php.d/memcache.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/memcache.ini
    echo; echo "${CMSG}PHP memcache module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP memcache module does not exist! ${CEND}"
  fi
}

