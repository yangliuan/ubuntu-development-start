#!/bin/bash

Install_pecl_event() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    pushd ${oneinstack_dir}/src > /dev/null
    PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
    phpExtensionDir=$(${php_install_dir}/bin/php-config --extension-dir)
    PHP_main_ver=${PHP_detail_ver%.*}

    if [[ "${PHP_main_ver}" =~ ^5.3$ ]]; then
      #5.3版本只能装libevent
      src_url=https://pecl.php.net/get/libevent-0.1.0.tgz && Download_src
      tar xzf libevent-0.1.0.tgz
      pushd libevent-0.1.0 > /dev/null
      ${php_install_dir}/bin/phpize
      ./configure --with-php-config=${php_install_dir}/bin/php-config
      make -j ${THREAD} && make install
      popd > /dev/null

      if [ -f "${phpExtensionDir}/libevent.so" ]; then
        echo 'extension=libevent.so' > ${php_install_dir}/etc/php.d/libevent.ini
        echo "${CSUCCESS}PHP libevent module installed successfully! ${CEND}"
        rm -rf libevent-0.1.0
      else
        echo "${CFAILURE}PHP libevent module install failed, Please contact the author! ${CEND}" && lsb_release -a
      fi

    else
      src_url=https://pecl.php.net/get/event-${event_ver}.tgz && Download_src
      tar xzf event-${event_ver}.tgz
      pushd event-${event_ver} > /dev/null
      ${php_install_dir}/bin/phpize
      ./configure --with-php-config=${php_install_dir}/bin/php-config
      make -j ${THREAD} && make install
      popd > /dev/null

      if [ -f "${phpExtensionDir}/event.so" ]; then
        echo 'extension=event.so' > ${php_install_dir}/etc/php.d/event.ini
        echo "${CSUCCESS}PHP event module installed successfully! ${CEND}"
        rm -rf event-${event_ver}
      else
        echo "${CFAILURE}PHP event module install failed, Please contact the author! ${CEND}" && lsb_release -a
      fi

    else
      echo "${CWARNING}Your php ${PHP_detail_ver} does not support event or libevent! ${CEND}";
    fi

    popd > /dev/null
  fi
}

Uninstall_pecl_event() {
  if [ -e "${php_install_dir}/etc/php.d/event.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/event.ini
    echo; echo "${CMSG}PHP event module uninstall completed${CEND}"
  elif [ -e "${php_install_dir}/etc/php.d/libevent.ini" ]; then
    rm -f ${php_install_dir}/etc/php.d/libevent.ini
    echo; echo "${CMSG}PHP libevent module uninstall completed${CEND}"
  else
    echo; echo "${CWARNING}PHP event module does not exist! ${CEND}"
  fi
}
