#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                  install language develop environment      
####################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

oneinstack_dir=$(dirname "`readlink -f $0`")
pushd ${oneinstack_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/check_os.sh
. ./include/check_dir.sh
. ./include/download.sh
. ./include/get_char.sh

xcachepwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`

ARG_NUM=$#

# choice php
while :; do echo
read -e -p "Do you want to install PHP? [y/n]: " php_flag
if [[ ! ${php_flag} =~ ^[y,n]$ ]]; then
    echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
else
    if [ "${php_flag}" == 'y' ]; then
    while :; do echo
        echo 'Please select a version of the PHP:'
        echo -e "\t${CMSG} 1${CEND}. Install php-5.3"
        echo -e "\t${CMSG} 2${CEND}. Install php-5.4"
        echo -e "\t${CMSG} 3${CEND}. Install php-5.5"
        echo -e "\t${CMSG} 4${CEND}. Install php-5.6"
        echo -e "\t${CMSG} 5${CEND}. Install php-7.0"
        echo -e "\t${CMSG} 6${CEND}. Install php-7.1"
        echo -e "\t${CMSG} 7${CEND}. Install php-7.2"
        echo -e "\t${CMSG} 8${CEND}. Install php-7.3"
        echo -e "\t${CMSG} 9${CEND}. Install php-7.4"
        echo -e "\t${CMSG}10${CEND}. Install php-8.0"
        echo -e "\t${CMSG}11${CEND}. Install php-8.1"
        read -e -p "Please input a number:(Default 7 press Enter) " php_option
        php_option=${php_option:-7}
        php_suffix=([1]=53 [2]=54 [3]=55 [4]=56 [5]=70 [6]=71 [7]=72 [8]=73 [9]=74 [10]=80 [11]=81)
        if [[ ! ${php_option} =~ ^[1-9]$|^1[0-1]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~11${CEND}"
        else
            #根据选项增加php安装目录后缀
            php_install_dir="${php_install_dir}${php_suffix[$php_option]}"
            [ -e "${php_install_dir}/bin/phpize" ] && { echo "${CWARNING}PHP already installed! ${CEND}"; unset php_option; break; }
        break
        fi
    done
    fi
    break
fi
done

# check php ver
if [ -e "${php_install_dir}/bin/phpize" ]; then
    PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
    PHP_main_ver=${PHP_detail_ver%.*}
fi

# PHP opcode cache and extensions
if [[ ${php_option} =~ ^[1-9]$|^1[0-1]$ ]] || [ -e "${php_install_dir}/bin/phpize" ]; then
while :; do echo
    read -e -p "Do you want to install opcode cache of the PHP? [y/n]: " phpcache_flag
    if [[ ! ${phpcache_flag} =~ ^[y,n]$ ]]; then
    echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
    if [ "${phpcache_flag}" == 'y' ]; then
        if [ "${php_option}" == '1' -o "${PHP_main_ver}" == '5.3' ]; then
        while :; do
            echo 'Please select a opcode cache of the PHP:'
            echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
            echo -e "\t${CMSG}2${CEND}. Install APCU"
            echo -e "\t${CMSG}3${CEND}. Install XCache"
            echo -e "\t${CMSG}4${CEND}. Install eAccelerator-0.9"
            read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
            phpcache_option=${phpcache_option:-1}
            if [[ ! ${phpcache_option} =~ ^[1-4]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~4${CEND}"
            else
            break
            fi
        done
        fi
        if [ "${php_option}" == '2' -o "${PHP_main_ver}" == '5.4' ]; then
        while :; do
            echo 'Please select a opcode cache of the PHP:'
            echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
            echo -e "\t${CMSG}2${CEND}. Install APCU"
            echo -e "\t${CMSG}3${CEND}. Install XCache"
            echo -e "\t${CMSG}4${CEND}. Install eAccelerator-1.0-dev"
            read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
            phpcache_option=${phpcache_option:-1}
            if [[ ! ${phpcache_option} =~ ^[1-4]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~4${CEND}"
            else
            break
            fi
        done
        fi
        if [ "${php_option}" == '3' -o "${PHP_main_ver}" == '5.5' ]; then
        while :; do
            echo 'Please select a opcode cache of the PHP:'
            echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
            echo -e "\t${CMSG}2${CEND}. Install APCU"
            echo -e "\t${CMSG}3${CEND}. Install XCache"
            read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
            phpcache_option=${phpcache_option:-1}
            if [[ ! ${phpcache_option} =~ ^[1-3]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~3${CEND}"
            else
            break
            fi
        done
        fi
        if [ "${php_option}" == '4' -o "${PHP_main_ver}" == '5.6' ]; then
        while :; do
            echo 'Please select a opcode cache of the PHP:'
            echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
            echo -e "\t${CMSG}2${CEND}. Install XCache"
            echo -e "\t${CMSG}3${CEND}. Install APCU"
            read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
            phpcache_option=${phpcache_option:-1}
            if [[ ! ${phpcache_option} =~ ^[1-3]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~3${CEND}"
            else
            break
            fi
        done
        fi
        if [[ ${php_option} =~ ^[5-9]$|^1[0-1]$ ]] || [[ "${PHP_main_ver}" =~ ^7.[0-4]$|^8.[0-1]$ ]]; then
        while :; do
            echo 'Please select a opcode cache of the PHP:'
            echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
            echo -e "\t${CMSG}2${CEND}. Install APCU"
            read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
            phpcache_option=${phpcache_option:-1}
            if [[ ! ${phpcache_option} =~ ^[1-2]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~2${CEND}"
            else
            break
            fi
        done
        fi
    fi
    break
    fi
done

# set xcache passwd
if [ "${phpcache_option}" == '3' ]; then
    while :; do
    read -e -p "Please input xcache admin password: " xcachepwd
    (( ${#xcachepwd} >= 5 )) && { xcachepwd_md5=$(echo -n "${xcachepwd}" | md5sum | awk '{print $1}') ; break ; } || echo "${CFAILURE}xcache admin password least 5 characters! ${CEND}"
    done
fi

# PHP extension
while :; do
    echo
    echo 'Please select PHP extensions:'
    echo -e "\t${CMSG} 0${CEND}. Do not install"
    echo -e "\t${CMSG} 1${CEND}. Install zendguardloader(PHP<=5.6)"
    echo -e "\t${CMSG} 2${CEND}. Install ioncube"
    echo -e "\t${CMSG} 3${CEND}. Install sourceguardian(PHP<=7.2)"
    echo -e "\t${CMSG} 4${CEND}. Install imagick"
    echo -e "\t${CMSG} 5${CEND}. Install gmagick"
    echo -e "\t${CMSG} 6${CEND}. Install fileinfo"
    echo -e "\t${CMSG} 7${CEND}. Install imap"
    echo -e "\t${CMSG} 8${CEND}. Install ldap"
    echo -e "\t${CMSG} 9${CEND}. Install phalcon(PHP>=5.5)"
    echo -e "\t${CMSG}10${CEND}. Install yaf(PHP>=7.0)"
    echo -e "\t${CMSG}11${CEND}. Install redis"
    echo -e "\t${CMSG}12${CEND}. Install memcached"
    echo -e "\t${CMSG}13${CEND}. Install memcache"
    echo -e "\t${CMSG}14${CEND}. Install mongodb"
    echo -e "\t${CMSG}15${CEND}. Install swoole"
    echo -e "\t${CMSG}16${CEND}. Install xdebug(PHP>=5.5)"
    echo -e "\t${CMSG}17${CEND}. Install event(PHP>=5.4)"
    read -e -p "Please input numbers:(Default '4 6 11 12' press Enter) " phpext_option
    phpext_option=${phpext_option:-'4 6 11 12'}
    [ "${phpext_option}" == '0' ] && break
    array_phpext=(${phpext_option})
    array_all=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17)
    for v in ${array_phpext[@]}
    do
    [ -z "`echo ${array_all[@]} | grep -w ${v}`" ] && phpext_flag=1
    done
    if [ "${phpext_flag}" == '1' ]; then
    unset phpext_flag
    echo; echo "${CWARNING}input error! Please only input number 4 11 12 and so on${CEND}"; echo
    continue
    else
    [ -n "`echo ${array_phpext[@]} | grep -w 1`" ] && pecl_zendguardloader=1
    [ -n "`echo ${array_phpext[@]} | grep -w 2`" ] && pecl_ioncube=1
    [ -n "`echo ${array_phpext[@]} | grep -w 3`" ] && pecl_sourceguardian=1
    [ -n "`echo ${array_phpext[@]} | grep -w 4`" ] && pecl_imagick=1
    [ -n "`echo ${array_phpext[@]} | grep -w 5`" ] && pecl_gmagick=1
    [ -n "`echo ${array_phpext[@]} | grep -w 6`" ] && pecl_fileinfo=1
    [ -n "`echo ${array_phpext[@]} | grep -w 7`" ] && pecl_imap=1
    [ -n "`echo ${array_phpext[@]} | grep -w 8`" ] && pecl_ldap=1
    [ -n "`echo ${array_phpext[@]} | grep -w 9`" ] && pecl_phalcon=1
    [ -n "`echo ${array_phpext[@]} | grep -w 10`" ] && pecl_yaf=1
    [ -n "`echo ${array_phpext[@]} | grep -w 11`" ] && pecl_redis=1
    [ -n "`echo ${array_phpext[@]} | grep -w 12`" ] && pecl_memcached=1
    [ -n "`echo ${array_phpext[@]} | grep -w 13`" ] && pecl_memcache=1
    [ -n "`echo ${array_phpext[@]} | grep -w 14`" ] && pecl_mongodb=1
    [ -n "`echo ${array_phpext[@]} | grep -w 15`" ] && pecl_swoole=1
    [ -n "`echo ${array_phpext[@]} | grep -w 16`" ] && pecl_xdebug=1
    [ -n "`echo ${array_phpext[@]} | grep -w 17`" ] && pecl_event=1
    break
    fi
done
fi

# check Nodejs
while :; do echo
    read -e -p "Do you want to install Nodejs? [y/n]: " nodejs_flag
    if [[ ! ${nodejs_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        # choice Nodejs install method
        if [ "${nodejs_flag}" == 'y' ]; then
            while :; do echo
                echo 'Please select method:'
                echo -e "\t${CMSG}1${CEND}. official install"
                echo -e "\t${CMSG}2${CEND}. use nvm"
                read -e -p "Please input a number:(Default 1 press Enter) " nodejs_method
                nodejs_method=${nodejs_method:-1}
                if [[ ! ${nodejs_method} =~ ^[1-2]$ ]]; then
                    echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                else
                    break
                fi
            done
        fi
        break
    fi
done


# check go
while :; do echo
    read -e -p "Do you want to install Go? [y/n]: " go_flag
    if [[ ! ${go_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        # choice go install method
        if [ "${go_flag}" == 'y' ]; then
            while :; do echo
                echo 'Please select method:'
                echo -e "\t${CMSG}1${CEND}. official install"
                echo -e "\t${CMSG}2${CEND}. use gvm"
                read -e -p "Please input a number:(Default 1 press Enter) " go_method
                go_method=${go_method:-1}
                if [[ ! ${go_method} =~ ^[1-2]$ ]]; then
                    echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                else
                    break
                fi
            done
        fi
        break
    fi
done

# check python
while :; do echo
    read -e -p "Do you want to install python? [y/n]: " python_flag
    if [[ ! ${python_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break
    fi
done

# PHP
case "${php_option}" in
  1)
    . include/php/php-5.3.sh
    Install_PHP53 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/php/php-5.4.sh
    Install_PHP54 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/php/php-5.5.sh
    Install_PHP55 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/php/php-5.6.sh
    Install_PHP56 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  5)
    . include/php/php-7.0.sh
    Install_PHP70 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  6)
    . include/php/php-7.1.sh
    Install_PHP71 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  7)
    . include/php/php-7.2.sh
    Install_PHP72 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  8)
    . include/php/php-7.3.sh
    Install_PHP73 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  9)
    . include/php/php-7.4.sh
    Install_PHP74 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  10)
    . include/php/php-8.0.sh
    Install_PHP80 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  11)
    . include/php/php-8.1.sh
    Install_PHP81 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# PHP addons
PHP_addons() {
  # PHP opcode cache
  case "${phpcache_option}" in
    1)
      . include/php/extension/zendopcache.sh
      Install_ZendOPcache 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    2)
      . include/php/extension/apcu.sh
      Install_APCU 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    3)
      . include/php/extension/xcache.sh
      Install_XCache 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    4)
      . include/php/extension/eaccelerator.sh
      Install_eAccelerator 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
  esac

  # ZendGuardLoader
  if [ "${pecl_zendguardloader}" == '1' ]; then
    . include/php/extension/ZendGuardLoader.sh
    Install_ZendGuardLoader 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # ioncube
  if [ "${pecl_ioncube}" == '1' ]; then
    . include/php/extension/ioncube.sh
    Install_ionCube 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # SourceGuardian
  if [ "${pecl_sourceguardian}" == '1' ]; then
    . include/php/extension/sourceguardian.sh
    Install_SourceGuardian 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # imagick
  if [ "${pecl_imagick}" == '1' ]; then
    . include/php/extension/ImageMagick.sh
    Install_ImageMagick 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_pecl_imagick 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # gmagick
  if [ "${pecl_gmagick}" == '1' ]; then
    . include/php/extension/GraphicsMagick.sh
    Install_GraphicsMagick 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_pecl_gmagick 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # fileinfo
  if [ "${pecl_fileinfo}" == '1' ]; then
    . include/php/extension/pecl_fileinfo.sh
    Install_pecl_fileinfo 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # imap
  if [ "${pecl_imap}" == '1' ]; then
    . include/php/extension/pecl_imap.sh
    Install_pecl_imap 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # ldap
  if [ "${pecl_ldap}" == '1' ]; then
    . include/php/extension/pecl_ldap.sh
    Install_pecl_ldap 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # calendar
  if [ "${pecl_calendar}" == '1' ]; then
    . include/php/extension/pecl_calendar.sh
    Install_pecl_calendar 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # phalcon
  if [ "${pecl_phalcon}" == '1' ]; then
    . include/php/extension/pecl_phalcon.sh
    Install_pecl_phalcon 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # yaf
  if [ "${pecl_yaf}" == '1' ]; then
    . include/php/extension/pecl_yaf.sh
    Install_pecl_yaf 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # yar
  if [ "${pecl_yar}" == '1' ]; then
    . include/php/extension/pecl_yar.sh
    Install_pecl_yar 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_memcached
  if [ "${pecl_memcached}" == '1' ]; then
    . include/database/cache/memcached.sh
    Install_pecl_memcached 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_memcache
  if [ "${pecl_memcache}" == '1' ]; then
    . include/database/cache/memcached.sh
    Install_pecl_memcache 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_redis
  if [ "${pecl_redis}" == '1' ]; then
    . include/database/cache/redis.sh
    Install_pecl_redis 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_mongodb
  if [ "${pecl_mongodb}" == '1' ]; then
    . include/php/extension/pecl_mongodb.sh
    Install_pecl_mongodb 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # swoole
  if [ "${pecl_swoole}" == '1' ]; then
    . include/php/extension/pecl_swoole.sh
    Install_pecl_swoole 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # xdebug
  if [ "${pecl_xdebug}" == '1' ]; then
    . include/php/extension/pecl_xdebug.sh
    Install_pecl_xdebug 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # event
  if [ "${pecl_event}" == '1' ]; then
    . include/php/extension/pecl_event.sh
    Install_pecl_event 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_pgsql
  if [ -e "${pgsql_install_dir}/bin/psql" ]; then
    . include/php/extension/pecl_pgsql.sh
    Install_pecl_pgsql 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi
}

[ "${mphp_addons_flag}" != 'y' ] && PHP_addons

# mphp
if [ "${mphp_flag}" == 'y' ]; then
  . include/php/mphp.sh
  Install_MPHP 2>&1 | tee -a ${oneinstack_dir}/install.log
  php_install_dir=${php_install_dir}${mphp_ver}
  PHP_addons
fi

# nodejs
case "${nodejs_method}" in
  1)
    . include/nodejs/node.sh
    Install_Node 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/nodejs/nvm.sh
    Install_Nvm 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# go
case "${go_method}" in
  1)
    . include/go/go.sh
    Install_Go 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/go/gvm.sh
    Install_Gvm 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# python
if [ "${python}" == 'y']; then
  . include/python/python.sh
  Install_Python 2>&1 | tee -a ${oneinstack_dir}/install.log
fi


endTime=`date +%s`
((installTime=($endTime-$startTime)/60))
echo "####################Congratulations########################"
echo "Total OneinStack Install Time: ${CQUESTION}${installTime}${CEND} minutes"
[[ "${php_option}" =~ ^[1-9]$|^1[0-1]$ ]] && echo -e "\n$(printf "%-32s" "PHP install dir:")${CMSG}${php_install_dir}${CEND}"
[ "${phpcache_option}" == '1' ] && echo "$(printf "%-32s" "Opcache Control Panel URL:")${CMSG}http://${IPADDR}/ocp.php${CEND}"
[ "${phpcache_option}" == '2' ] && echo "$(printf "%-32s" "APC Control Panel URL:")${CMSG}http://${IPADDR}/apc.php${CEND}"
[ "${phpcache_option}" == '3' -a -e "${php_install_dir}/etc/php.d/04-xcache.ini" ] && echo "$(printf "%-32s" "xcache Control Panel URL:")${CMSG}http://${IPADDR}/xcache${CEND}"
[ "${phpcache_option}" == '3' -a -e "${php_install_dir}/etc/php.d/04-xcache.ini" ] && echo "$(printf "%-32s" "xcache user:")${CMSG}admin${CEND}"
[ "${phpcache_option}" == '3' -a -e "${php_install_dir}/etc/php.d/04-xcache.ini" ] && echo "$(printf "%-32s" "xcache password:")${CMSG}${xcachepwd}${CEND}"
[ "${phpcache_option}" == '4' -a -e "${php_install_dir}/etc/php.d/02-eaccelerator.ini" ] && echo "$(printf "%-32s" "eAccelerator Control Panel URL:")${CMSG}http://${IPADDR}/control.php${CEND}"
[ "${phpcache_option}" == '4' -a -e "${php_install_dir}/etc/php.d/02-eaccelerator.ini" ] && echo "$(printf "%-32s" "eAccelerator user:")${CMSG}admin${CEND}"
[ "${phpcache_option}" == '4' -a -e "${php_install_dir}/etc/php.d/02-eaccelerator.ini" ] && echo "$(printf "%-32s" "eAccelerator password:")${CMSG}eAccelerator${CEND}"
[ "${python}" == 'y'] && echo -e "\n$(printf "%-32s" "python install dir:")${CMSG}${python_install_dir}${CEND}"


if [ ${ARG_NUM} == 0 ]; then
  while :; do echo
    echo "${CMSG}Please restart the server and see if the services start up fine.${CEND}"
    read -e -p "Do you want to restart OS ? [y/n]: " reboot_flag
    if [[ ! "${reboot_flag}" =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      break
    fi
  done
fi

[ "${reboot_flag}" == 'y' ] && reboot