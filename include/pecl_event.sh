#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_pecl_event() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${oneinstack_dir}/src > /dev/null
    PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
    PHP_main_ver=${PHP_detail_ver%.*}
    if [[ "${PHP_main_ver}" != 5.3 ]]; then
      phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
      src_url=https://pecl.php.net/get/event-${event_ver}.tgz && Download_src
      tar xzf event-${event_ver}.tgz
      pushd event-${event_ver}.tgz > /dev/null
      ${php_install_dir}/bin/phpize
      ./configure --with-php-config=${php_install_dir}/bin/php-config
      make -j ${THREAD} && make install
      popd > /dev/null
      if [ -f "${phpExtensionDir}/event.so" ]; then
        echo 'extension=event.so' > ${php_install_dir}/etc/php.d/08-event.ini
        echo "${CSUCCESS}PHP event module installed successfully! ${CEND}"
        rm -rf event-${event_ver}
      else
        echo "${CFAILURE}PHP event module install failed, Please contact the author! ${CEND}" && lsb_release -a
      fi
    else
      echo "${CWARNING}Your php ${PHP_detail_ver} does not support event! ${CEND}";
    fi
    popd > /dev/null
  fi
}

Uninstall_pecl_event() {
  if [ -e "${php_install_dir}/etc/php.d/08-event.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/08-event.ini
    echo; echo "${CMSG}PHP event module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP event module does not exist! ${CEND}"
  fi
}
