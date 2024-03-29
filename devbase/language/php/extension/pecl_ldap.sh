#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_pecl_ldap() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${ubdevenv_dir}/src > /dev/null
    phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
    PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
    src_url=https://secure.php.net/distributions/php-${PHP_detail_ver}.tar.gz && Download_src
    tar xzf php-${PHP_detail_ver}.tar.gz
    pushd php-${PHP_detail_ver}/ext/ldap > /dev/null
    apt-get -y install libldap2-dev
    ln -s /usr/lib/${SYS_BIT_c}-linux-gnu/libldap.so /usr/lib/
    ln -s /usr/lib/${SYS_BIT_c}-linux-gnu/liblber.so /usr/lib/
    ${php_install_dir}/bin/phpize
    ./configure --with-php-config=${php_install_dir}/bin/php-config --with-ldap ${With_libdir}
    make -j ${THREAD} && make install
    popd > /dev/null
    if [ -f "${phpExtensionDir}/ldap.so" ]; then
      echo 'extension=ldap.so' > ${php_install_dir}/etc/php.d/ldap.ini
      echo "${CSUCCESS}PHP ldap module installed successfully! ${CEND}"
      rm -rf php-${PHP_detail_ver}
    else
      echo "${CFAILURE}PHP ldap module install failed, Please contact the author! ${CEND}" && lsb_release -a
    fi
    popd > /dev/null
  fi
}

Uninstall_pecl_ldap() {
  if [ -e "${php_install_dir}/etc/php.d/ldap.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/ldap.ini
    echo; echo "${CMSG}PHP ldap module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP ldap module does not exist! ${CEND}"
  fi
}
