#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear

printf "
#######################################################################
#                 install Devtools for Ubuntu 16+                     #
#                                                                     #
#######################################################################
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

# check redis-desktop-manager
while :; do echo
    read -e -p "Do you want to install redis-desktop-manager? [y/n]: " redis_desktop_manager_flag
    if [[ ! ${redis_desktop_manager_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${redis_desktop_manager_flag}" == 'y' -a -e "/snap/redis-desktop-manager/current/bin/desktop-launch" ] && { echo "${CWARNING}redis-desktop-manager already installed! ${CEND}"; unset redis_desktop_manager_flag; }
        break
    fi
done

# check navicat preminu
while :; do echo
    read -e -p "Do you want to install navicat_preminu? [y/n]: " navicat_preminu_flag
    if [[ ! ${navicat_preminu_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${navicat_preminu_flag}" == 'y' -a -e "/opt/navicat/navicat15-premium-cs.AppImage" ] && { echo "${CWARNING}navicat_preminu already installed! ${CEND}"; unset navicat_preminu_flag; }
        break
    fi
done

# install redis-desktop-manager
if [ "${redis_desktop_manager_flag}" == 'y' ]; then
    . include/redis_desktop_manager.sh
    Install_redis_desktop_manager 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install navicat_preminu
if [ "${navicat_preminu_flag}" == 'y' ]; then
    . include/navicat_preminu.sh
    Install_navicat_preminu 2>&1 | tee -a ${oneinstack_dir}/install.log
else
    read -e -p "Do you want to extend navicat_preminu trial time? [y/n]: " navicat_preminu_flag
    if [[ ! ${navicat_preminu_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    elif [ "${navicat_preminu_flag}" == 'y' ]; then
        rm -rfv /home/${run_user}/.config/dconf /home/${run_user}/.config/navicat;
    fi
    unset navicat_preminu_flag;
fi

# . include/filezilla.sh
# Install_FileZilla

. include/postman.sh
Install_Postman