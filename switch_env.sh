#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
                      Switch Develop Environment
#######################################################################
"
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
oneinstack_dir=$(dirname "`readlink -f $0`")
pushd ${oneinstack_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/get_char.sh

Show_Help() {
  echo "Usage: $0  command ...[parameters]....
  --php                 switch php version
  --composer            switch composer version
  --composer_mirrors    switch composer mirrors
  --npm_registry        switch npm registry
  --nginx               switch nginx
  "
}

ARG_NUM=$#
TEMP=`getopt -o hvV --long php,composer,composer_mirrors,npm_registry,nginx -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
eval set -- "${TEMP}"
while :; do
  [ -z "$1" ] && break;
  case "$1" in
    --php)
      switch_php_flag=y; shift 1
      ;;
    --composer)
      switch_composer_flag=y; shift 1
      ;;
    --composer_mirrors)
      switch_mirrors_flag=y; shift 1
      ;;
    --npm_registry)
      switch_registry_flag=y; shift 1
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
    while :; do echo
        read -e -p "Do you want to switch php ? [y/n](n): " switch_php_flag
        switch_php_flag=${switch_php_flag:-n}
        if [[ ! ${switch_php_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            if [ "${switch_php_flag}" == 'y' ]; then
                while :; do echo
                    read -e -p "Do you want to switch composer ? [y/n](n): " switch_composer_flag
                    switch_composer_flag=${switch_composer_flag:-n}
                    if [[ ! ${switch_composer_flag} =~ ^[y,n]$ ]]; then
                        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
                    else
                        break;
                    fi
                done

                while :; do echo
                    read -e -p "Do you want to switch composer mirrors? [y/n](n): " switch_mirrors_flag
                    switch_mirrors_flag=${switch_mirrors_flag:-n}
                    if [[ ! ${switch_mirrors_flag} =~ ^[y,n]$ ]]; then
                        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
                    else
                        break;
                    fi
                done
            fi
            break;
        fi
    done

    while :; do echo
        read -e -p "Do you want to switch npm registry? [y/n](n): " switch_registry_flag
        switch_registry_flag=${switch_registry_flag:-n}
        if [[ ! ${switch_registry_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            break;
        fi
    done

    while :; do echo
        read -e -p "Do you want to switch nginx? [y/n](n): " switch_nginx_flag
        switch_nginx_flag=${switch_nginx_flag:-n}
        if [[ ! ${switch_nginx_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            break;
        fi
    done
fi

if [ "${switch_php_flag}" == 'y' ]; then
    . include/language/php/switch_php.sh
    Switch_PHP
fi

if [ "${switch_composer_flag}" == 'y' ]; then
    . include/language/php/switch_composer.sh
    Switch_Composer
fi

if [ "${switch_mirrors_flag}" == 'y' ]; then
    . include/language/php/switch_composer.sh
    Switch_Composer_Mirrors
fi

if [ "${switch_registry_flag}" == 'y' ]; then
    . include/language/nodejs/switch_npm_registry.sh
    Switch_NpmRegistry
fi

if [ "${switch_nginx_flag}" == 'y' ]; then
    . include/webserver/switch_nginx.sh
    Switch_Nginx
fi