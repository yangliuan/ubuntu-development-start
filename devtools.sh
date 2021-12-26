#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear

printf "
#######################################################################
#                 install Devtools for Ubuntu 20.04+                     #
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

ARG_NUM=$#
Ubuntu_Ver=$(lsb_release -r --short)
echo "Ubuntu Version ${Ubuntu_Ver}"

# check service desktop
while :; do echo
    read -e -p "Do you want to install service desktop? [y/n]: " service_desktop_flag
    service_desktop_flag=${service_desktop_flag:-n}
    if [[ ! ${service_desktop_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break;
    fi
done

# check redis-desktop-manager
while :; do echo
    read -e -p "Do you want to install redis-desktop-manager? [y/n]: " redis_desktop_manager_flag
    redis_desktop_manager_flag=${redis_desktop_manager_flag:-y}
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
    navicat_preminu_flag=${navicat_preminu_flag:-y}
    if [[ ! ${navicat_preminu_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${navicat_preminu_flag}" == 'y' -a -e "/opt/navicat/navicat-premium-cs.AppImage" ] && { echo "${CWARNING}navicat preminu already installed! ${CEND}"; unset navicat_preminu_flag; }
        break
    fi
done

# check mysql workbench
while :; do echo
    read -e -p "Do you want to install mysql workbench? [y/n]: " mysql_workbench_flag
    mysql_workbench_flag=${mysql_workbench_flag:-y}
    if [[ ! ${mysql_workbench_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${mysql_workbench_flag}" == 'y' -a -e "/usr/bin/mysql-workbench" ] && { echo "${CWARNING}navicat preminu already installed! ${CEND}"; unset mysql_workbench_flag; }
        break
    fi
done

# check install remmina
while :; do echo
    read -e -p "Do you want to install remmina? [y/n]: " remmina_flag
    remmina_flag=${remmina_flag:-y}
    if [[ ! ${remmina_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${remmina_flag}" == 'y' -a -e "/usr/bin/remmina" ] && { echo "${CWARNING}remmina already installed! ${CEND}"; unset remmina_flag; }
        break
    fi
done

# check install wireshark
while :; do echo
    read -e -p "Do you want to install wireshark? [y/n]: " wireshark_flag
    wireshark_flag=${wireshark_flag:-y}
    if [[ ! ${wireshark_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${wireshark_flag}" == 'y' -a -e "/usr/bin/wireshark" ] && { echo "${CWARNING}wireshark already installed! ${CEND}"; unset wireshark_flag; }
        break
    fi
done

# check install postman
while :; do echo
    read -e -p "Do you want to install postman? [y/n]: " postman_flag
    postman_flag=${postman_flag:-y}
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
    runapi_flag=${runapi_flag:-y}
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
    ossbrowser_flag=${ossbrowser_flag:-y}
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
    virtualbox_flag=${virtualbox_flag:-y}
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
    filezilla_flag=${filezilla_flag:-y}
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
    jmeter_flag=${jmeter_flag:-y}
    if [[ ! ${jmeter_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${jmeter_flag}" == 'y' -a -e "/opt/jmeter/bin/ApacheJMeter.jar" ] && { echo "${CWARNING}jmeter already installed! ${CEND}"; unset jmeter_flag; }
        #install jdk 
        if [ "${jmeter_flag}" == 'y' ]; then
            while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}1${CEND}. Install JDK-11.0"
                echo -e "\t${CMSG}2${CEND}. Install JDK-1.8"
                read -e -p "Please input a number:(Default 1 press Enter) " jdk_option
                jdk_option=${jdk_option:-1}
                if [[ ! ${jdk_option} =~ ^[1-2]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                else
                  break
                fi
            done
        fi
        break
    fi
done

# check install vscode
while :; do echo
    read -e -p "Do you want to install or upgrade vscode? [y/n]: " vscode_flag
    vscode_flag=${vscode_flag:-n}
    if [[ ! ${vscode_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break
    fi
done

# Check download source packages
. ./include/check_download.sh
[ "${armplatform}" == "y" ] && dbinstallmethod=2
checkDownload 2>&1 | tee -a ${oneinstack_dir}/install.log

#publish service desktop
if [ "${service_desktop_flag}" == 'y' ]; then
    . include/devtools/service_desktop.sh
    Service_Desktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

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

# install mysql workbench
if [ "${mysql_workbench_flag}" == 'y' ]; then
    . include/devtools/mysql-workbench.sh
    Mysql_Workbench 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install remmina
if [ "${remmina_flag}" == 'y' ]; then
    . include/devtools/remmina.sh
    Install_Remmina 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install wireshark
if [ "${wireshark_flag}" == 'y' ]; then
    . include/devtools/wireshark.sh
    Install_Wireshark 2>&1 | tee -a ${oneinstack_dir}/install.log
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

# JDK
case "${jdk_option}" in
  1)
    . include/jdk-11.0.sh
    Install_JDK110 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/jdk-1.8.sh
    Install_JDK18 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/jdk-1.7.sh
    Install_JDK17 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/jdk-1.6.sh
    Install_JDK16 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# install jmeter
if [ "${jmeter_flag}" == 'y' ]; then  
    . include/devtools/jmeter.sh
    Install_Jmeter 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install vscode
if [ "${vscode_flag}" == 'y' ]; then  
    . include/devtools/vscode.sh
    Install_Vscode 2>&1 | tee -a ${oneinstack_dir}/install.log
fi


#reboot system
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