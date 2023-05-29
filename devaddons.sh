#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                  Addons                                      #
################################################################################
"
# Check if user is root
# shellcheck disable=SC2046
[ $(id -u) != '0' ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

oneinstack_dir=$(dirname "`readlink -f $0`")
# shellcheck disable=SC2164
pushd ${oneinstack_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/check_os.sh
. ./include/download.sh
. ./include/get_char.sh
. include/base_desktop.sh
. include/firewall/fail2ban.sh
. include/webserver/ngx_lua_waf.sh
. include/language/php/composer.sh
. include/language/python/supervisor.sh
. include/language/php/phpmyadmin.sh


# shellcheck disable=SC2154
Show_Help() {
  echo
  echo "Usage: $0  command ...
  --help, -h                  Show this help message
  --install, -i               Install
  --uninstall, -u             Uninstall
  --composer                  Composer
  --fail2ban                  Fail2ban
  --ngx_lua_waf               Ngx_lua_waf
  --supervisord               Supervisord
  --phpmyadmin                PhpMyAdmin
  "
}

ARG_NUM=$#
TEMP=`getopt -o hiu --long help,install,uninstall,composer,fail2ban,ngx_lua_waf,supervisord,phpmyadmin-- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
eval set -- "${TEMP}"
while :; do
  [ -z "$1" ] && break;
  case "$1" in
    -h|--help)
      Show_Help; exit 0
      ;;
    -i|--install)
      install_flag=y; shift 1
      ;;
    -u|--uninstall)
      uninstall_flag=y; shift 1
      ;;
    --composer)
      composer_flag=y; shift 1
      ;;
    --fail2ban)
      fail2ban_flag=y; shift 1
      ;;
    --ngx_lua_waf)
      ngx_lua_waf_flag=y; shift 1
      ;;
    --supervisord)
      supervisord_flag=y; shift 1
      ;;
    --phpmyadmin)
      phpmyadmin_flag=y; shift 1
      ;;
    --)
      shift
      ;;
    *)
      echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
      ;;
  esac
done

ACTION_FUN() {
  while :; do
    echo
    echo "Please select an action:"
    echo -e "\t${CMSG}1${CEND}. install"
    echo -e "\t${CMSG}2${CEND}. uninstall"
    read -e -p "Please input a number:(Default 1 press Enter) " ACTION
    ACTION=${ACTION:-1}
    if [[ ! "${ACTION}" =~ ^[1,2]$ ]]; then
      echo "${CWARNING}input error! Please only input number 1~2${CEND}"
    else
      [ "${ACTION}" == '1' ] && install_flag=y
      [ "${ACTION}" == '2' ] && uninstall_flag=y
      break
    fi
  done
}

Menu() {
  while :;do
    printf "
What Are You Doing?
\t${CMSG}1${CEND}. Install/Uninstall PHP Composer
\t${CMSG}2${CEND}. Install/Uninstall Fail2ban
\t${CMSG}3${CEND}. Install/Uninstall Ngx_lua_waf
\t${CMSG}4${CEND}. Install/Uninstall Supervisord
\t${CMSG}5${CEND}. Install/Uninstall PhpMyAdmin
\t${CMSG}q${CEND}. Exit
"
    read -e -p "Please input the correct option: " Number
    if [[ ! "${Number}" =~ ^[1-5,q]$ ]]; then
      echo "${CFAILURE}input error! Please only input 1~5 and q${CEND}"
    else
      case "${Number}" in
        1)
          ACTION_FUN
          if [ "${install_flag}" = 'y' ]; then
            Install_composer
          elif [ "${uninstall_flag}" = 'y' ]; then
            Uninstall_composer
          fi
          ;;
        2)
          ACTION_FUN
          if [ "${install_flag}" = 'y' ]; then
            Install_Python
            Install_fail2ban
          elif [ "${uninstall_flag}" = 'y' ]; then
            Uninstall_fail2ban
          fi
          ;;
        3)
          ACTION_FUN
          if [ "${install_flag}" = 'y' ]; then
            # shellcheck disable=SC2154
            [ -e "${nginx_install_dir}/sbin/nginx" ] && Nginx_lua_waf
            # shellcheck disable=SC2154
            [ -e "${tengine_install_dir}/sbin/nginx" ] && Tengine_lua_waf
            enable_lua_waf
          elif [ "${uninstall_flag}" = 'y' ]; then
            disable_lua_waf
          fi
          ;;
        4)
          ACTION_FUN
          if [ "${install_flag}" = 'y' ]; then
            Install_Supervisor
            Install_SupervisorDesktop
          elif [ "${uninstall_flag}" = 'y' ]; then
            Uninstall_Supervisor
            Uninstall_SupervisorDesktop
          fi
          ;;
        5)
          ACTION_FUN
          if [ "${install_flag}" = 'y' ]; then
            Install_phpMyAdmin
          elif [ "${uninstall_flag}" = 'y' ]; then
            Uninstall_phpMyAdmin
          fi
          ;;
        q)
          exit
          ;;
      esac
    fi
  done
}

if [ ${ARG_NUM} == 0 ]; then
  Menu
else
  if [ "${composer_flag}" == 'y' ]; then
    if [ "${install_flag}" = 'y' ]; then
      Install_composer
    elif [ "${uninstall_flag}" = 'y' ]; then
      Uninstall_composer
    fi
  fi

  if [ "${fail2ban_flag}" == 'y' ]; then
    if [ "${install_flag}" = 'y' ]; then
      Install_fail2ban
    elif [ "${uninstall_flag}" = 'y' ]; then
      Uninstall_fail2ban
    fi
  fi

  if [ "${ngx_lua_waf_flag}" == 'y' ]; then
    if [ "${install_flag}" = 'y' ]; then
      [ -e "${nginx_install_dir}/sbin/nginx" ] && Nginx_lua_waf
      [ -e "${tengine_install_dir}/sbin/nginx" ] && Tengine_lua_waf
      enable_lua_waf
    elif [ "${uninstall_flag}" = 'y' ]; then
      disable_lua_waf
    fi
  fi

  # supervisord
  if [ "${supervisord_flag}" == 'y' ]; then
    if [ "${install_flag}" = 'y' ]; then
      Install_Supervisor
      Install_SupervisorDesktop
    elif [ "${uninstall_flag}" = 'y' ]; then
      Uninstall_Supervisor
      Uninstall_SupervisorDesktop
    fi
  fi

  # phpmyadmin
  if [ "${phpmyadmin_flag}" == 'y' ]; then
    if [ "${install_flag}" = 'y' ]; then
      Install_phpMyAdmin
    elif [ "${uninstall_flag}" = 'y' ]; then
      Uninstall_phpMyAdmin
    fi
  fi
fi
