#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_composer() {
  if [ -e "${php_install_dir}/bin/phpize" ]; then
    if [ -e "/usr/local/bin/composer" ]; then
      echo "${CWARNING}PHP Composer already installed! ${CEND}"
    else
      [ ! -d "${oneinstack_dir}/src/composer" ] && mkdir ${oneinstack_dir}/src/composer
      pushd ${oneinstack_dir}/src/composer > /dev/null
      wget -c https://getcomposer.org/download/${composer_old_ver}/composer.phar -O composer${composer_old_ver}.phar > /dev/null 2>&1
      wget -c https://getcomposer.org/download/${composer_ver}/composer.phar -O composer${composer_ver}.phar > /dev/null 2>&1
      cp -fv composer${composer_ver}.phar /usr/local/bin/composer
      chmod +x /usr/local/bin/composer
      
      if [ -e "/usr/local/bin/composer" ]; then
        echo; echo "${CSUCCESS}PHP Composer installed successfully! ${CEND}"
      else
        echo; echo "${CFAILURE}PHP Composer install failed, Please try again! ${CEND}"
      fi
      popd > /dev/null
    fi
  fi
}

Uninstall_composer() {
  if [ -e "/usr/local/bin/composer" ]; then
    rm -f /usr/local/bin/composer
    echo; echo "${CMSG}Composer uninstall completed${CEND}";
  else
    echo; echo "${CWARNING}Composer does not exist! ${CEND}"
  fi
}
