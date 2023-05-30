#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            Uninstall Development Tools                       #
################################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")

pushd ${ubdevenv_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/check_os.sh
. ./include/check_dir.sh
. ./include/download.sh
. ./include/get_char.sh
. ./include/command_parameters.sh

ARG_NUM=$#
TEMP=`getopt -o hvV --long help,version,all,openssh_server,switchhost,rdm,navicat_premium,mysql_workbench,remmina,wireshark,terminal_net_tools,postman,runapi,apifox,oss_browser,virtualbox,filezilla,jmeter,vscode,cursor,obs_studio,rabbitvcs_nautilus -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Devtools_Help && exit 1
eval set -- "${TEMP}"

while :; do
  [ -z "$1" ] && break;
  case "$1" in
    -h|--help)
      Show_Devtools_Help; exit 0
      ;;
    -v|-V|--version)
      version; exit 0
      ;;
    --all)
      switchhost_flag=y
      redis_desktop_manager_flag=y
      navicat_premium_flag=y
      mysql_workbench_flag=y
      remmina_flag=y
      wireshark_flag=y
      postman_flag=y
      runapi_flag=y
      apifox_flag=y
      oss_browser_flag=y
      virtualbox_flag=y
      filezilla_flag=y
      jmeter_flag=y
      vscode_flag=y
      cursor_flag=y
      obs_studio_flag=y
      rabbitvcs_nautilus_flag=y
      shift 1
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
    --terminal_net_tools)
      terminal_net_tools_flag=y; shift 1
      ;;
    --remmina)
      remmina_flag=y; shift 1
      ;;
    --wireshark)
      wireshark_flag=y; shift 1
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
    --cuda)
      cuda_flag=y; shift 1
      ;;
    --reboot)
      reboot_flag=y; shift 1
      ;;
    --)
      shift
      ;;
    *)
      echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Devtools_Help && exit 1
      ;;
  esac
done


# uninstall openssh-server
if [ "${openssh_server_flag}" == 'y' ]; then
    . develop-tools/network/openssh-server.sh
    Uninstall_OpensshServer
fi

# uninstall switchhost
if [ "${switchhost_flag}" == 'y' ]; then
    . develop-tools/network/switchhost.sh
    Uninstall_SwitchHost
fi

# uninstall redis-desktop-manager
if [ "${redis_desktop_manager_flag}" == 'y' ]; then
    . develop-tools/data-manager/redis_desktop_manager.sh
    Uninstall_redis_desktop_manager
fi

# uninstall navicat preminu
if [ "${navicat_premium_flag}" == 'y' ]; then
    . develop-tools/data-manager/navicat_premium.sh
    Uninstall_navicat_permium
fi

# uninstall mysql workbench
if [ "${mysql_workbench_flag}" == 'y' ]; then
    . develop-tools/data-manager/mysql_workbench.sh
    Uninstall_MysqlWorkbench
fi

# uninstall remmina
if [ "${remmina_flag}" == 'y' ]; then
    . develop-tools/network/remmina.sh
    Uninstall_Remmina
fi

# uninstall wireshark
if [ "${wireshark_flag}" == 'y' ]; then
    . develop-tools/network/wireshark.sh
    Uninstall_Wireshark
fi

# uninstall terminal net tools
if [ "${terminal_net_tools_flag}" == 'y' ]; then
    . develop-tools/network/net_tools.sh
    . develop-tools/network/nethogs.sh
    . develop-tools/network/wireshark.sh
    Uninstall_Net_Tools 2>&1 | tee -a ${ubdevenv_dir}/install_devtools.log
    Uninstall_Nethogs 2>&1 | tee -a ${ubdevenv_dir}/install_devtools.log
    Uninstall_Traceroute 2>&1 | tee -a ${ubdevenv_dir}/install_devtools.log
fi

# uninstall postman
if [ "${postman_flag}" == 'y' ]; then
    . develop-tools/api-test/postman.sh
    Uninstall_Postman
fi

# uninstall runapi
if [ "${runapi_flag}" == 'y' ]; then
    . develop-tools/api-test/runapi.sh
    Uninstall_Runapi
fi

# uninstall apifox
if [ "${apifox_flag}" == 'y' ]; then
    . develop-tools/api-test/apifox.sh
    Uninstall_Apifox
fi

# uninstall oss-browser
if [ "${oss_browser_flag}" == 'y' ]; then
    . develop-tools/files/ossbrowser.sh
    Uninstall_Ossbrowser
fi

# uninstall vitualbox
if [ "${virtualbox_flag}" == 'y' ]; then
    . develop-tools/virtual-machine/virtualbox.sh
    Uninstall_Vbox
fi

# uninstall filezilla
if [ "${filezilla_flag}" == 'y' ]; then
    . develop-tools/files/filezilla.sh
    Uninstall_FileZilla
fi

# uninstall jmeter
if [ "${jmeter_flag}" == 'y' ]; then
    . develop-tools/api-test/jmeter.sh
    Uninstall_Jmeter
fi

# uninstall vscode
if [ "${vscode_flag}" == 'y' ]; then
    . develop-tools/ide-editer/vscode.sh
    Uninstall_Vscode
fi

# uninstall cursor
if [ "${cursor_flag}" == 'y' ]; then
    . develop-tools/ide-editer/cursor.sh
    Uninstall_Cursor
fi

# uninstall obs studio
if [ "${obs_studio_flag}" == 'y' ]; then
    . develop-tools/multimedia/obs_studio.sh
    Unintall_ObsStudio
fi

# uninstall rabbitvcs nautilus
if [ "${rabbitvcs_nautilus_flag}" == 'y' ]; then
    . develop-tools/develop-tools/rabbitvcs.sh
    Uninstall_rabbitbvcs
fi
