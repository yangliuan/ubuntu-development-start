#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
                      Switch PHP Develop Environment
#######################################################################
"
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
oneinstack_dir=$(dirname "`readlink -f $0`")
pushd ${oneinstack_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/get_char.sh

while :; do echo
    read -e -p "Do you want to switch php ? [y/n](n): " switch_php_flag
    switch_php_flag=${switch_php_flag:-n}
    if [[ ! ${switch_php_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
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
        break;
    fi
done

if [ "${switch_php_flag}" == 'y' ]; then
    ./include/php/switch_php.sh
    Switch_Composer
fi

if [ "${switch_composer_flag}" == 'y' ]; then
    ./include/php/switch_composer.sh
    Switch_Composer
fi

if [ "${switch_mirrors_flag}" == 'y' ]; then
    ./include/php/switch_composer.sh
    Switch_Composer_Mirrors
fi