#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_MPHP() {
  if [ -e "${php_install_dir}/sbin/php-fpm" ]; then
    if [ -e "${php_install_dir}${mphp_ver}/bin/phpize" ]; then
      echo "${CWARNING}PHP${mphp_ver} already installed! ${CEND}"
    else
      [ -e "/lib/systemd/system/php-fpm.service" ] && /bin/mv /lib/systemd/system/php-fpm.service{,_bk}
      [ -e "/etc/init.d/php-fpm" ] && /bin/mv /etc/init.d/php-fpm{,_bk}
      php_install_dir=${php_install_dir}${mphp_ver}
      case "${mphp_ver}" in
        53)
          . /devbase/language/php/php/php-5.3.sh
          Install_PHP53 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        54)
          . /devbase/language/php/php/php-5.4.sh
          Install_PHP54 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        55)
          . /devbase/language/php/php/php-5.5.sh
          Install_PHP55 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        56)
          . /devbase/language/php/php/php-5.6.sh
          Install_PHP56 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        70)
          . /devbase/language/php/php/php-7.0.sh
          Install_PHP70 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        71)
          . /devbase/language/php/php/php-7.1.sh
          Install_PHP71 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        72)
          . /devbase/language/php/php/php-7.2.sh
          Install_PHP72 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        73)
          . /devbase/language/php/php/php-7.3.sh
          Install_PHP73 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        74)
          . /devbase/language/php/php/php-7.4.sh
          Install_PHP74 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        80)
          . /devbase/language/php/php/php-8.0.sh
          Install_PHP80 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        81)
          . /devbase/language/php/php/php-8.1.sh
          Install_PHP81 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
        82)
          . /devbase/language/php/php/php-8.1.sh
          Install_PHP81 2>&1 | tee -a ${ubdevenv_dir}/install.log
          ;;
      esac
      if [ -e "${php_install_dir}/sbin/php-fpm" ]; then
        service php-fpm stop
        sed -i "s@/dev/shm/php-cgi.sock@/dev/shm/php${mphp_ver}-cgi.sock@" ${php_install_dir}/etc/php-fpm.conf
        [ -e "/lib/systemd/system/php-fpm.service" ] && /bin/mv /lib/systemd/system/php-fpm.service /lib/systemd/system/php${mphp_ver}-fpm.service
        [ -e "/etc/init.d/php-fpm" ] && /bin/mv /etc/init.d/php-fpm /etc/init.d/php${mphp_ver}-fpm
        [ -e "/lib/systemd/system/php-fpm.service_bk" ] && /bin/mv /lib/systemd/system/php-fpm.service{_bk,}
        [ -e "/etc/init.d/php-fpm_bk" ] && /bin/mv /etc/init.d/php-fpm{_bk,}
        #sed -i "s@${php_install_dir}/bin:@@" /etc/profile
      fi
    fi
  else
    echo "${CWARNING}To use the multiple PHP versions, You need to use PHP-FPM! ${CEND}"
  fi
}
