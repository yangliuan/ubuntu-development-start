#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                          Switch Development Environment                      #
################################################################################
"
ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")

pushd ${ubdevenv_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/get_char.sh

Show_Help() {
  echo "Usage: $0  command ...[parameters]....
  --php                 switch php version
  --php_extension       switch php extension
  --composer            switch composer version
  --composer_mirrors    switch composer mirrors
  --npm_registry        switch npm mirrors
  --nginx               switch nginx type
  "
}

ARG_NUM=$#
TEMP=`getopt -o hvV --long php,php_extension,composer,composer_mirrors,npm_registry,nginx -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
eval set -- "${TEMP}"
while :; do
  [ -z "$1" ] && break;
  case "$1" in
    --php)
      switch_php_flag=y; shift 1
      ;;
    --php_extension)
      switch_php_extension_flag=y; shift 1
      ;;
    --composer)
      switch_composer_flag=y; shift 1
      ;;
    --composer_mirrors)
      switch_composer_mirrors_flag=y; shift 1
      ;;
    --npm_mirrors)
      switch_npm_mirrors_flag=y; shift 1
      ;;
    --nginx)
      switch_nginx_flag=y; shift 1
      ;;
    --)
      shift
      ;;
    *)
      echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
      ;;
  esac
done

if [ ${ARG_NUM} == 0 ]; then
    while :; do
      echo
      echo "Please select an action:"
      echo -e "\t${CMSG}1${CEND}. switch php version"
      echo -e "\t${CMSG}2${CEND}. switch php extension"
      echo -e "\t${CMSG}3${CEND}. switch composer version"
      echo -e "\t${CMSG}4${CEND}. switch composer mirrors"
      echo -e "\t${CMSG}5${CEND}. switch npm mirrors"
      echo -e "\t${CMSG}6${CEND}. switch nginx type"
      read -e -p "Please input a number:(Default 1 press Enter) " ACTION
      if [[ ! "${ACTION}" =~ ^[1-6]$ ]]; then
        echo "${CWARNING}input error! Please only input number 1~6${CEND}"
      else
        [ "${ACTION}" == '1' ] && switch_php_flag=y
        [ "${ACTION}" == '2' ] && switch_php_extension_flag=y
        [ "${ACTION}" == '3' ] && switch_composer_flag=y
        [ "${ACTION}" == '4' ] && switch_composer_mirrors_flag=y
        [ "${ACTION}" == '5' ] && switch_npm_mirrors_flag=y
        [ "${ACTION}" == '6' ] && switch_nginx_flag=y
        break
      fi
  done
fi

if [ "${switch_php_flag}" == 'y' ]; then
    . include/language/php/switch_php.sh
    Switch_PHP
    while :; do echo
        read -e -p "Do you want to switch composer version ? [y/n](n): " switch_composer_flag
        switch_composer_flag=${switch_composer_flag:-n}
        if [[ ! ${switch_composer_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            break;
        fi
    done
fi

if [ "${switch_composer_flag}" == 'y' ]; then
    . include/language/php/switch_composer.sh
    Switch_Composer
    while :; do echo
        read -e -p "Do you want to switch composer mirrors? [y/n](n): " switch_composer_mirrors_flag
        switch_composer_mirrors_flag=${switch_composer_mirrors_flag:-n}
        if [[ ! ${switch_composer_mirrors_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            break;
        fi
    done
fi

if [ "${switch_composer_mirrors_flag}" == 'y' ]; then
    . include/language/php/switch_composer.sh
    Switch_Composer_Mirrors
fi

if [ "${switch_php_extension_flag}" == 'y' ]; then
    . include/language/php/switch_extension.sh
    Switch_Extension
fi

if [ "${switch_npm_mirrors_flag}" == 'y' ]; then
    . include/language/nodejs/switch_npm_registry.sh
    Switch_NpmRegistry
fi

if [ "${switch_nginx_flag}" == 'y' ]; then
    . include/webserver/switch_nginx.sh
    Switch_Nginx
fi