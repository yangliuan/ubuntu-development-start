#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack
#       https://www.php.net/manual/zh/book.gmagick.php
Install_pecl_gmagick() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
    phpExtensionDir=`${php_install_dir}/bin/php-config --extension-dir`
    if [ "`${php_install_dir}/bin/php-config --version | awk -F. '{print $1}'`" == '5' ]; then
      tar xzf gmagick-${gmagick_oldver}.tgz
      pushd gmagick-${gmagick_oldver} > /dev/null
    else
      tar xzf gmagick-${gmagick_ver}.tgz
      pushd gmagick-${gmagick_ver} > /dev/null
    fi
    export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config --with-gmagick=${gmagick_install_dir}
    make -j ${THREAD} && make install
    popd > /dev/null
    if [ -f "${phpExtensionDir}/gmagick.so" ]; then
      echo 'extension=gmagick.so' > ${php_install_dir}/etc/php.d/gmagick.ini
      echo "${CSUCCESS}PHP gmagick module installed successfully! ${CEND}"
      rm -rf gmagick-${gmagick_ver} gmagick-${gmagick_oldver}
    else
      echo "${CFAILURE}PHP gmagick module install failed, Please contact the author! ${CEND}" && lsb_release -a
    fi
    popd > /dev/null
  fi
}

Uninstall_pecl_gmagick() {
  if [ -e "${php_install_dir}/etc/php.d/gmagick.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/gmagick.ini
    echo; echo "${CMSG}PHP gmagick module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP gmagick module does not exist! ${CEND}"
  fi
}
