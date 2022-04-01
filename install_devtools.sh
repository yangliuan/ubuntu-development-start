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

# check openssh-server
while :; do echo
    read -e -p "Do you want to install openssh-server? [y/n](n): " openssh_server_flag
    openssh_server_flag=${openssh_server_flag:-n}
    if [[ ! ${openssh_server_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${openssh_server_flag}" == 'y' -a -e "/usr/sbin/sshd" ] && { echo "${CWARNING}openssh-server already installed! ${CEND}"; unset openssh_server_flag; }
        break;
    fi
done

# check switchhost
while :; do echo
    read -e -p "Do you want to install switchhost? [y/n](y): " switchhost_flag
    switchhost_flag=${switchhost_flag:-y}
    if [[ ! ${switchhost_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${switchhost_flag}" == 'y' -a -e "/opt/switchhost/SwitchHosts_linux_x86_64.AppImage" ] && { echo "${CWARNING}switchhost already installed! ${CEND}"; unset switchhost_flag; }
        break;
    fi
done

# check redis-desktop-manager
while :; do echo
    read -e -p "Do you want to install redis-desktop-manager? [y/n](y): " redis_desktop_manager_flag
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
    if [ -e "/opt/navicat/navicat-premium-cs.AppImage" ];then 
        read -e -p "Do you want to upgrade or extend use navicat_preminu? [y/n](n): " navicat_preminu_flag
        navicat_preminu_flag=${navicat_preminu_flag:-n}
    else
        read -e -p "Do you want to install navicat_preminu? [y/n](y): " navicat_preminu_flag
        navicat_preminu_flag=${navicat_preminu_flag:-y}

        if [ "${navicat_preminu_flag}" == 'y' ]; then
            rm -rfv /opt/navicat
        fi
    fi
    if [[ ! ${navicat_preminu_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break
    fi
done

# check mysql workbench
while :; do echo
    read -e -p "Do you want to install mysql workbench? [y/n](y): " mysql_workbench_flag
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
    read -e -p "Do you want to install remmina? [y/n](y): " remmina_flag
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
    read -e -p "Do you want to install wireshark? [y/n](y): " wireshark_flag
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
    read -e -p "Do you want to install postman? [y/n](y): " postman_flag
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
    read -e -p "Do you want to install runapi? [y/n](y): " runapi_flag
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
    read -e -p "Do you want to install oss-browser? [y/n](y): " ossbrowser_flag
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
    read -e -p "Do you want to install virtualbox? [y/n](n): " virtualbox_flag
    virtualbox_flag=${virtualbox_flag:-n}
    if [[ ! ${virtualbox_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${virtualbox_flag}" == 'y' -a -e "/usr/bin/virtualbox" ] && { echo "${CWARNING}virtualbox already installed! ${CEND}"; unset virtualbox_flag; }
        break
    fi
done

# check install filezilla
while :; do echo
    read -e -p "Do you want to install filezilla? [y/n](y): " filezilla_flag
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
    read -e -p "Do you want to install jmeter? [y/n](y): " jmeter_flag
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

# check install or upgrade vscode
while :; do echo
    if [ -e "/usr/bin/code" ];then 
        read -e -p "Do you want to upgrade vscode? [y/n](n): " vscode_flag
        vscode_flag=${vscode_flag:-n}
    else
        read -e -p "Do you want to install vscode? [y/n](y): " vscode_flag
        vscode_flag=${vscode_flag:-y}
    fi
    if [[ ! ${vscode_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break
    fi
done

# check install obs studio
while :; do echo
    read -e -p "Do you want to install or obs studio ? [y/n](y): " obs_studio_flag
    obs_studio_flag=${obs_studio_flag:-y}
    if [[ ! ${obs_studio_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${obs_studio_flag}" == 'y' -a -e "/usr/bin/obs" ] && { echo "${CWARNING}obs studio already installed! ${CEND}"; unset obs_studio_flag; }
        break
    fi
done

# Check download source packages
if [ "${jmeter_flag}" == 'y' ]; then
    . ./include/check_download.sh
    [ "${armplatform}" == "y" ] && dbinstallmethod=2
    checkDownload 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

#install openssh-server
if [ "${openssh_server_flag}" == 'y' ]; then
    . include/develop-tools/openssh-server.sh
    Install_OpensshServer 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

#set develop config
if [ "${develop_config_flag}" == 'y' ]; then
    . include/develop-tools/develop_config.sh
    Set_Develop_Config 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

#publish service desktop
if [ "${service_desktop_flag}" == 'y' ]; then
    . include/develop-tools/service_desktop.sh
    Service_Desktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

#install switchhost
if [ "${switchhost_flag}" == 'y' ]; then
    . include/develop-tools/switchhost.sh
    Install_SwitchHost 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install redis-desktop-manager
if [ "${redis_desktop_manager_flag}" == 'y' ]; then
    . include/develop-tools/redis_desktop_manager.sh
    Install_redis_desktop_manager 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install navicat preminu
if [ "${navicat_preminu_flag}" == 'y' ]; then
    . include/develop-tools/navicat_preminu.sh
    Install_navicat_preminu 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install mysql workbench
if [ "${mysql_workbench_flag}" == 'y' ]; then
    . include/develop-tools/mysql_workbench.sh
    Mysql_Workbench 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install remmina
if [ "${remmina_flag}" == 'y' ]; then
    . include/develop-tools/remmina.sh
    Install_Remmina 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install wireshark
if [ "${wireshark_flag}" == 'y' ]; then
    . include/develop-tools/wireshark.sh
    Install_Wireshark 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install postman
if [ "${postman_flag}" == 'y' ]; then
    . include/develop-tools/postman.sh
    Install_Postman 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install runapi
if [ "${runapi_flag}" == 'y' ]; then
    . include/develop-tools/runapi.sh
    Install_Runapi 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install oss-browser
if [ "${ossbrowser_flag}" == 'y' ]; then
    . include/develop-tools/ossbrowser.sh
    Install_Ossbrowser 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install vitualbox
if [ "${virtualbox_flag}" == 'y' ]; then
    . include/develop-tools/virtualbox.sh
    Install_Vbox 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install filezilla
if [ "${filezilla_flag}" == 'y' ]; then
    . include/develop-tools/filezilla.sh
    Install_FileZilla 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# JDK
case "${jdk_option}" in
  1)
    . include/java/jdk/jdk-11.0.sh
    Install_JDK110 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/java/jdk/jdk-1.8.sh
    Install_JDK18 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/java/jdk/jdk-1.7.sh
    Install_JDK17 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/java/jdk/jdk-1.6.sh
    Install_JDK16 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# install jmeter
if [ "${jmeter_flag}" == 'y' ]; then
    . include/develop-tools/jmeter.sh
    Install_Jmeter 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install vscode
if [ "${vscode_flag}" == 'y' ]; then
    . include/develop-tools/vscode.sh
    Install_Vscode 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# install obs studio
if [ "${obs_studio_flag}" == 'y' ]; then
    . include/develop-tools/obs_studio.sh
    Install_ObsStudio 2>&1 | tee -a ${oneinstack_dir}/install.log
fi