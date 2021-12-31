#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/local/php/bin:
clear
printf "
#######################################################################
                      Switch PHP Develop Environment
#######################################################################
"
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
oneinstack_dir=$(dirname "`readlink -f $0`")
pushd ${oneinstack_dir} > /dev/null
. ./include/color.sh
. ./include/get_char.sh
. ./include/devtools/php.sh
. ./include/devtools/composer.sh


Switch_PHP

while :; do echo
    read -e -p "Do you want to switch composer ? [y/n](n): " switch_composer_flag
    switch_composer_flag=${switch_composer_flag:-n}
    if [[ ! ${switch_composer_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break;
    fi
done

if [ "${switch_composer_flag}" == 'y' ]; then
    Switch_Composer
fi

while :; do echo
    read -e -p "Do you want to switch composer mirrors? [y/n](n): " switch_mirrors_flag
    switch_mirrors_flag=${switch_mirrors_flag:-n}
    if [[ ! ${switch_mirrors_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break;
    fi
done

if [ "${switch_mirrors_flag}" == 'y' ]; then
    Switch_Composer_Mirrors
fi