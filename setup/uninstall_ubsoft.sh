#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                              Uninstall Software                              #
################################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")

pushd ${ubdevenv_dir} > /dev/null
. ./include/color.sh
. ./versions.txt
. ./options.conf
. ./include/check_os.sh
. ./include/get_char.sh
. ./include/command_parameters.sh
. ./ubsoft/input-method/fcitx.sh
. ./include/loadshell.sh
shell_dir=${ubdevenv_dir}/ubsoft && Source_Shells

ARG_NUM=$#
TEMP=`getopt -o hvV --long help,version,all,input_method_option:,baidunetdisk,chrome,deepinwine,dingtalk,linuxqq,feishu,flameshot,indicator_sysmonitor,lantern,neteasy_cloudmusic,qqmusic,peek,qv2ray,clash,sougoupinyin,sunlogin,theme_tools,bilibili_video_downloader,wps,xDroid,conky,my_weather_indicator,custom,fceux,driver,reboot -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Ubsoft_Help && exit 1
eval set -- "${TEMP}"
while :; do
  [ -z "$1" ] && break;
  case "$1" in
    -h|--help)
      Show_Ubsoft_Help; exit 0
      ;;
    -v|-V|--version)
      version; exit 0
      ;;
    --all)
      baidunetdisk_flag=y
      chrome_flag=y
      deepinwine_flag=y
      dingtalk_flag=y
      linuxqq_flag=y
      feishu_flag=y
      flameshot_flag=y
      indicator_sysmonitor_flag=y
      lantern_flag=y
      neteasy_cloudmusic_flag=y
      qqmusic_flag=y
      peek_flag=y
      qv2ray_flag=y
      clash_flag=y
      sunlogin_flag=y
      bilibili_video_downloader_flag=y
      xDroid_flag=y
      conky_flag=y
      my_weather_indicator_flag=y
      custom_flag=y
      shift 1
      ;;
    --input_method_option)
      input_method_option=$2; shift 2
      ;;
    --baidunetdisk)
      baidunetdisk_flag=y; shift 1
      ;;
    --chrome)
      chrome_flag=y; shift 1
      ;;
    --deepinwine)
      deepinwine_flag=y; shift 1
      ;;
    --dingtalk)
      dingtalk_flag=y; shift 1
      ;;
    --linuxqq)
      linuxqq_flag=y; shift 1
      ;;
    --feishu)
      feishu_flag=y; shift 1
      ;;
    --flameshot)
      flameshot_flag=y; shift 1
      ;;
    --indicator_sysmonitor)
      indicator_sysmonitor_flag=y; shift 1
      ;;
    --lantern)
      lantern_flag=y; shift 1
      ;;
    --neteasy_cloudmusic)
      neteasy_cloudmusic_flag=y; shift 1
      ;;
    --qqmusic)
      qqmusic_flag=y; shift 1
      ;;
    --peek)
      peek_flag=y; shift 1
      ;;
    --qv2ray)
      qv2ray_flag=y; shift 1
      ;;
    --clash)
      clash_flag=y; shift 1
      ;;
    --sunlogin)
      sunlogin_flag=y; shift 1
      ;;
    --theme_tools)
      theme_tools_flag=y; shift 1
      ;;
    --bilibili_video_downloader)
      bilibili_video_downloader_flag=y; shift 1
      ;;
    --wps)
      wps_flag=y; shift 1
      ;;
    --xDroid)
      xDroid_flag=y; shift 1
      ;;
    --conky)
      conky_flag=y; shift 1
      ;;
    --my_weather_indicator)
      my_weather_indicator_flag=y; shift 1
      ;;
    --custom)
      custom_flag=y; shift 1
      ;;
    --fceux)
      fceux_flag=y; shift 1
      ;;
    --driver)
      driver_flag=y; shift 1
      ;;
    --reboot)
      reboot_flag=y; shift 1
      ;;
    --)
      shift
      ;;
    *)
      echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Ubsoft_Help && exit 1
      ;;
  esac
done

case "${input_method_option}" in
  1)
    . ./ubsoft/input-method/fcitx_googlepinyin.sh
    Uninstall_GooglePinyin
    ;;
  2)
    . ./ubsoft/input-method/fcitx_sougoupinyin.sh
    Uninstall_Sougoupinyin
    ;;
  3)
    . ./ubsoft/input-method/fcitx_baidupinyin.sh
    Uninstall_Baidupinyin
    ;;
esac

if [ "${baidunetdisk_flag}" == 'y' ]; then
    Uninstall_Baidunetdisk
fi

if [ "${chrome_flag}" == 'y' ]; then
    Uninstall_Chrome
fi

if [ "${deepinwine_flag}" == 'y' ]; then
    Uninstall_Deepin_Wechat
    Uninstall_DeepinWine
fi

if [ "${dingtalk_flag}" == 'y' ]; then
    Uninstall_Dingtalk
fi

if [ "${linuxqq_flag}" == 'y' ]; then
    Uninstall_LinuxQQ
fi

if [ "${feishu_flag}" == 'y' ]; then
    Uninstall_Feishu
fi

if [ "${flameshot_flag}" == 'y' ]; then
    Uninstall_Flameshot
fi

if [ "${indicator_sysmonitor_flag}" == 'y' ]; then
    Uninstall_IndicatorSysmonitor
fi

if [ "${lantern_flag}" == 'y' ]; then
    Uninstall_Lantern
fi

if [ "${neteasy_cloudmusic_flag}" == 'y' ]; then
    Uninstall_NeteasyCloudMusicElectron
fi

if [ "${qqmusic_flag}" == 'y' ]; then
    Uninstall_QQmusic
fi

if [ "${peek_flag}" == 'y' ]; then
    Uninstall_Peek
fi

if [ "${qv2ray_flag}" == 'y' ]; then
    Uninstall_Qv2ray
fi

if [ "${clash_flag}" == 'y' ]; then
    Uninstall_ClashForWindow
fi

if [ "${sunlogin_flag}" == 'y' ]; then
    Uninstall_Sunlogin
fi

if [ "${theme_tools_flag}" == 'y' ]; then
    Uninstall_ThemeTools
fi

if [ "${bilibili_video_downloader_flag}" == 'y' ]; then
    Uninstall_BilbiliDownloader
fi

if [ "${wps_flag}" == 'y' ]; then
    Uninstall_Wps
fi

if [ "${xDroid_flag}" == 'y' ]; then
    Uninstall_xDroid
fi

if [ "${conky_flag}" == 'y' ]; then
    Uninstall_Conky
fi

if [ "${my_weather_indicator_flag}" == 'y' ]; then
    Uninstall_MyWeatherIndicator
fi

if [ "${custom_flag}" == 'y' ]; then
    Uninstall_custom_SnapApp 2>&1 | tee -a $log_dir
    Uninstall_custom_AptApp 2>&1 | tee -a $log_dir
fi

if [ "${fceux_flag}" == 'y' ]; then
    Uninstall_Fceux 2>&1 | tee -a $log_dir
fi

if [ "${driver_flag}" == 'y' ]; then
    Uninstall_Driver 2>&1 | tee -a $log_dir
fi

apt-get autoremove -y
