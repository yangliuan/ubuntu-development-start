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
. ./include/get_char.sh
. ./include/devtools/service_desktop.sh

#publish service desktop
Service_Desktop 2>&1 | tee -a ${oneinstack_dir}/install.log

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
    read -e -p "Do you want to install navicat preminu? [y/n]: " navicat_preminu_flag
    if [[ ! ${navicat_preminu_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${navicat_preminu_flag}" == 'y' -a -e "/opt/navicat/navicat${navicat_ver}-premium-cs.AppImage" ] && { echo "${CWARNING}navicat preminu already installed! ${CEND}"; unset navicat_preminu_flag; }
        break
    fi
done

# check install remmina
while :; do echo
    read -e -p "Do you want to install remmina? [y/n]: " remmina_flag
    if [[ ! ${remmina_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${remmina_flag}" == 'y' -a -e "/usr/bin/remmina" ] && { echo "${CWARNING}remmina already installed! ${CEND}"; unset remmina_flag; }
        break
    fi
done

# check install postman
while :; do echo
    read -e -p "Do you want to install postman? [y/n]: " postman_flag
    if [[ ! ${postman_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${postman_flag}" == 'y' -a -e "/opt/postman/app/postman" ] && { echo "${CWARNING}postman already installed! ${CEND}"; unset postman_flag; }
        break
    fi
done

# check install runapi
while :; do echo
    read -e -p "Do you want to install runapi? [y/n]: " runapi_flag
    if [[ ! ${runapi_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${runapi_flag}" == 'y' -a -e "/opt/runapi/runapi.AppImage" ] && { echo "${CWARNING}runapi already installed! ${CEND}"; unset runapi_flag; }
        break
    fi
done

# check install oss-browser
while :; do echo
    read -e -p "Do you want to install oss-browser? [y/n]: " ossbrowser_flag
    if [[ ! ${ossbrowser_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${ossbrowser_flag}" == 'y' -a -e "/opt/oss-browser/oss-browser" ] && { echo "${CWARNING}oss-browser already installed! ${CEND}"; unset ossbrowser_flag; }
        break
    fi
done

# check install virtualbox
while :; do echo
    read -e -p "Do you want to install virtualbox? [y/n]: " virtualbox_flag
    if [[ ! ${virtualbox_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${virtualbox_flag}" == 'y' -a -e "/usr/bin/virtualbox" ] && { echo "${CWARNING}virtualbox already installed! ${CEND}"; unset virtualbox_flag; }
        break
    fi
done

# check install filezilla
while :; do echo
    read -e -p "Do you want to install filezilla? [y/n]: " filezilla_flag
    if [[ ! ${filezilla_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${filezilla_flag}" == 'y' -a -e "/opt/filezilla3/bin/filezilla" ] && { echo "${CWARNING}filezilla already installed! ${CEND}"; unset filezilla_flag; }
        break
    fi
done

# check install jmeter
while :; do echo
    read -e -p "Do you want to install jmeter? [y/n]: " jmeter_flag
    if [[ ! ${jmeter_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${jmeter_flag}" == 'y' -a -e "/opt/jmeter/bin/ApacheJMeter.jar" ] && { echo "${CWARNING}jmeter already installed! ${CEND}"; unset jmeter_flag; }
        break
    fi
done

# install redis-desktop-manager
if [ "${redis_desktop_manager_flag}" == 'y' ]; then
    . include/devtools/redis_desktop_manager.sh
    Install_redis_desktop_manager 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install navicat preminu
if [ "${navicat_preminu_flag}" == 'y' ]; then
    . include/devtools/navicat_preminu.sh
    Install_navicat_preminu 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install remmina
if [ "${remmina_flag}" == 'y' ]; then
    . include/devtools/remmina.sh
    Install_Remmina 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install postman
if [ "${postman_flag}" == 'y' ]; then
    . include/devtools/postman.sh
    Install_Postman 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install runapi
if [ "${runapi_flag}" == 'y' ]; then
    . include/devtools/runapi.sh
    Install_Runapi 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install oss-browser
if [ "${ossbrowser_flag}" == 'y' ]; then
    . include/devtools/ossbrowser.sh
    Install_Ossbrowser 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install vitualbox
if [ "${virtualbox_flag}" == 'y' ]; then
    . include/devtools/virtualbox.sh
    Install_Vbox 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install filezilla
if [ "${filezilla_flag}" == 'y' ]; then
    . include/devtools/filezilla.sh
    Install_FileZilla 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install jmeter
if [ "${jmeter_flag}" == 'y' ]; then
    jdk_option=1
    . include/check_download.sh
    checkDownload 2>&1 | tee -a ${oneinstack_dir}/install.log

    . include/jdk-11.0.sh
    Install_JDK110 2>&1 | tee -a ${oneinstack_dir}/install.log
    
    #. include/devtools/jmeter.sh
    # Install_Jmeter 2>&1 | tee -a ${oneinstack_dir}/install.log
fi