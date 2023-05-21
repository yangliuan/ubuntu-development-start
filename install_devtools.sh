#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
#######################################################################
                      install Devtools for Ubuntu                    
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

Ubuntu_Ver=$(lsb_release -r --short)
echo "Ubuntu Version ${Ubuntu_Ver}"

version() {
  echo "version: 1.0"
  echo "updated date: 2022-07-11"
}

Show_Help() {
  version
  echo "Usage: $0  command ...[parameters]....
  --help, -h
  --version, -v 
  --all
  --openssh_server
  --switchhost
  --rdm
  --navicat_premium
  --mysql_workbench
  --remmina
  --wireshark
  --terminal_net_tools
  --postman
  --runapi
  --apifox
  --oss_browser
  --virtualbox
  --filezilla
  --jmeter
  --vscode
  --cursor
  --obs_studio
  --rabbitvcs_nautilus
  "
}

ARG_NUM=$#
TEMP=`getopt -o hvV --long help,version,openssh_server,switchhost,rdm,navicat_premium,mysql_workbench,remmina,wireshark,terminal_net_tools,postman,runapi,apifox,oss_browser,virtualbox,filezilla,jmeter,vscode,cursor,obs_studio,rabbitvcs_nautilus -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
eval set -- "${TEMP}"

while :; do
  [ -z "$1" ] && break;
  case "$1" in
    -h|--help)
      Show_Help; exit 0
      ;;
    -v|-V|--version)
      version; exit 0
      ;;
    --openssh-server)
      openssh_server_flag=y; shift 1
      ;;
    --switchhost)
      switchhost_flag=y; shift 1
      ;;
    --rdm)
      redis_desktop_manager_flag=y; shift 1
      ;;
    --navicat_premium)
      navicat_premium_flag=y; shift 1
      ;;
    --mysql_workbench)
      mysql_workbench_flag=y; shift 1
      ;;
    --remmina)
      remmina_flag=y; shift 1
      ;;
    --wireshark)
      wireshark_flag=y; shift 1
      ;;
    --terminal_net_tools)
      terminal_net_tools_flag=y; shift 1
      ;;
    --postman)
      postman_flag=y; shift 1
      ;;
    --runapi)
      runapi_flag=y; shift 1
      ;;
    --apifox)
      apifox_flag=y; shift 1
      ;;
    --oss_browser)
      oss_browser_flag=y; shift 1
      ;;
    --virtualbox)
      virtualbox_flag=y; shift 1
      ;;
    --filezilla)
      filezilla_flag=y; shift 1
      ;;
    --jmeter)
      jmeter_flag=y; shift 1
      ;;
    --vscode)
      vscode_flag=y; shift 1
      ;;
    --cursor)
      cursor_flag=y; shift 1
      ;;
    --obs_studio)
      obs_studio_flag=y; shift 1
      ;;
    --rabbitvcs_nautilus)
      rabbitvcs_nautilus_flag=y; shift 1
      ;;
    --reboot)
      reboot_flag=y; shift 1
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

    # check install terminal net tools
    while :; do echo
        read -e -p "Do you want to install terminal net tools? [y/n](y): " terminal_net_tools_flag
        terminal_net_tools_flag=${terminal_net_tools_flag:-y}
        if [[ ! ${terminal_net_tools_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
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

    # check install apifox
    while :; do echo
        read -e -p "Do you want to install apifox? [y/n](y): " apifox_flag
        apifox_flag=${apifox_flag:-y}
        if [[ ! ${apifox_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            [ "${apifox_flag}" == 'y' -a -e "/opt/apifox/apifox" ] && { echo "${CWARNING}apifox already installed! ${CEND}"; unset apifox_flag; }
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
                    echo -e "\t${CMSG}1${CEND}. Install openjdk-8-jdk"
                    echo -e "\t${CMSG}2${CEND}. Install openjdk-11-jdk"
                    read -e -p "Please input a number:(Default 1 press Enter) " jdk_option
                    jdk_option=${jdk_option:-1}
                    if [[ ! ${jdk_option} =~ ^[1-2]$ ]]; then
                        echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                    else
                        [ -e "/etc/profile.d/openjdk.sh" ] && { echo "${CWARNING}openjdk already installed! ${CEND}"; unset jdk_option; }
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

    # check install rabbitvcs-nautilus
    while :; do echo
        read -e -p "Do you want to install rabbitvcs nautilus ? [y/n](y): " rabbitvcs_nautilus_flag
        rabbitvcs_nautilus_flag=${rabbitvcs_nautilus_flag:-y}
        if [[ ! ${rabbitvcs_nautilus_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            [ "${rabbitvcs_nautilus_flag}" == 'y' -a -e "/usr/share/nautilus-python/extensions" ] && { echo "${CWARNING}rabbitvcs nautilus already installed! ${CEND}"; unset rabbitvcs_nautilus_flag; }
            break
        fi
    done
fi

#clear latest install_devtools.log
echo > ${oneinstack_dir}/install_devtools.log

# Check download source packages
if [ "${jmeter_flag}" == 'y' ]; then
    . ./include/check_download.sh
    [ "${armplatform}" == "y" ] && dbinstallmethod=2
    checkDownload 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

#install openssh-server
if [ "${openssh_server_flag}" == 'y' ]; then
    . develop-tools/network/openssh-server.sh
    Install_OpensshServer 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

#set develop config
if [ "${develop_config_flag}" == 'y' ]; then
    . include/develop_config.sh
    Set_Develop_Config 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

#install switchhost
if [ "${switchhost_flag}" == 'y' ]; then
    . develop-tools/network/switchhost.sh
    Install_SwitchHost 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install redis-desktop-manager
if [ "${redis_desktop_manager_flag}" == 'y' ]; then
    . develop-tools/data-manager/redis_desktop_manager.sh
    Install_redis_desktop_manager 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install navicat preminu
if [ "${navicat_premium_flag}" == 'y' ]; then
    . develop-tools/data-manager/navicat_premium.sh
    Install_navicat_premium 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install mysql workbench
if [ "${mysql_workbench_flag}" == 'y' ]; then
    . develop-tools/data-manager/mysql_workbench.sh
    Install_MysqlWorkbench 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install remmina
if [ "${remmina_flag}" == 'y' ]; then
    . develop-tools/network/remmina.sh
    Install_Remmina 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install wireshark
if [ "${wireshark_flag}" == 'y' ]; then
    . develop-tools/network/wireshark.sh
    Install_Wireshark 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install terminal net tools
if [ "${terminal_net_tools_flag}" == 'y' ]; then
    . develop-tools/network/net_tools.sh
    . develop-tools/network/nethogs.sh
    . develop-tools/network/wireshark.sh
    Install_Net_Tools 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
    Install_Nethogs 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
    Install_Traceroute 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install postman
if [ "${postman_flag}" == 'y' ]; then
    . develop-tools/api-test/postman.sh
    Install_Postman 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install runapi
if [ "${runapi_flag}" == 'y' ]; then
    . develop-tools/api-test/runapi.sh
    Install_Runapi 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install apifox
if [ "${apifox_flag}" == 'y' ]; then
    . develop-tools/api-test/apifox.sh
    Install_Apifox 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install oss-browser
if [ "${ossbrowser_flag}" == 'y' ]; then
    . develop-tools/files/ossbrowser.sh
    Install_Ossbrowser 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install vitualbox
if [ "${virtualbox_flag}" == 'y' ]; then
    . develop-tools/virtual-machine/virtualbox.sh
    Install_Vbox 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install filezilla
if [ "${filezilla_flag}" == 'y' ]; then
    . develop-tools/files/filezilla.sh
    Install_FileZilla 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# JDK
case "${jdk_option}" in
  1)
    . include/language/java/jdk/openjdk-8.sh
    Install_OpenJDK8 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/language/java/jdk/openjdk-11.sh
    Install_OpenJDK11 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# install jmeter
if [ "${jmeter_flag}" == 'y' ]; then
    . develop-tools/api-test/jmeter.sh
    Install_Jmeter 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install vscode
if [ "${vscode_flag}" == 'y' ]; then
    . develop-tools/ide-editer/vscode.sh
    Install_Vscode 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install cursor
if [ "${cursor_flag}" == 'y' ]; then
    . develop-tools/ide-editer/cursor.sh
    Install_Cursor 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install obs studio
if [ "${obs_studio_flag}" == 'y' ]; then
    . develop-tools/multimedia/obs_studio.sh
    if ! which ffmpeg > /dev/null; then
        . include/multimedia/ffmpeg.sh
    fi
    Install_ObsStudio 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi

# install rabbitvcs nautilus
if [ "${rabbitvcs_nautilus_flag}" == 'y' ]; then
    . develop-tools/files/rabbitvcs.sh
    Install_Rabbitvcs 2>&1 | tee -a ${oneinstack_dir}/install_devtools.log
fi