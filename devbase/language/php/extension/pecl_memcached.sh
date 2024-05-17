#!/bin/bash
# PECL_DOC:https://pecl.php.net/package/memcached
# PHP_DOC:https://www.php.net/manual/zh/book.memcached.php
# 使用了libmemcached库提供的api与memcached服务端进行交互 推荐使用

Install_pecl_memcached() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
    phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
    # php memcached extension
    tar xzf libmemcached-${libmemcached_ver}.tar.gz
    patch -d libmemcached-${libmemcached_ver} -p0 < libmemcached-build.patch
    pushd libmemcached-${libmemcached_ver} > /dev/null
    [ "${PM}" == 'apt-get' ] && sed -i "s@lthread -pthread -pthreads@lthread -lpthread -pthreads@" ./configure
    ./configure --with-memcached=${memcached_install_dir}
    make -j ${THREAD} && make install
    popd > /dev/null
    rm -rf libmemcached-${libmemcached_ver}

    if [ "$(${php_install_dir}/bin/php-config --version | awk -F. '{print $1}')" == '5' ]; then
      tar xzf memcached-${pecl_memcached_oldver}.tgz
      pushd memcached-${pecl_memcached_oldver} > /dev/null
    else
      tar xzf memcached-${pecl_memcached_ver}.tgz
      pushd memcached-${pecl_memcached_ver} > /dev/null
    fi
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config
    make -j ${THREAD} && make install
    popd > /dev/null
    if [ -f "${phpExtensionDir}/memcached.so" ]; then
      cat > ${php_install_dir}/etc/php.d/memcached.ini << EOF
extension=memcached.so
memcached.use_sasl=1
EOF
      echo "${CSUCCESS}PHP memcached module installed successfully! ${CEND}"
      rm -rf memcached-${pecl_memcached_oldver} memcached-${pecl_memcached_ver}
    else
      echo "${CFAILURE}PHP memcached module install failed, Please contact the author! ${CEND}" && lsb_release -a
    fi
    popd > /dev/null
  fi
}

Uninstall_pecl_memcached() {
  if [ -e "${php_install_dir}/etc/php.d/memcached.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/memcached.ini
    echo; echo "${CMSG}PHP memcached module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP memcached module does not exist! ${CEND}"
  fi
}