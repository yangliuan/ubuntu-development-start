#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                Install Software                              #
################################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")
log_dir="${ubdevenv_dir}/log/install_ubsoft.log"

pushd ${ubdevenv_dir} > /dev/null
. ./include/color.sh
. ./versions.txt
. ./options.conf
. ./include/download.sh
. ./include/check_os.sh
. ./include/get_char.sh
. ./include/command_parameters.sh
. ./ubsoft/patch_suport.sh
. ./ubsoft/input-method/fcitx.sh

ARG_NUM=$#
TEMP=`getopt -o hvV --long help,version,input_method_option:,baidunetdisk,chrome,deepinwine,dingtalk,linuxqq,feishu,flameshot,indicator_sysmonitor,lantern,neteasy_cloudmusic,qqmusic,peek,qv2ray,sunlogin,theme_tools,bilibili_video_downloader,wps,xDroid,conky,my_weather_indicator,custom,reboot -- "$@" 2>/dev/null`
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
    --input_method_option)
      input_method_option=$2; shift 2
      [[ ! ${input_method_option} =~ ^[1-3]$ ]] && { echo "${CWARNING}input_method_option input error! Please only input number 1~3${CEND}"; exit 1; }
      [ "${input_method_option}" = '1' -a -e "/usr/lib/x86_64-linux-gnu/fcitx/fcitx-googlepinyin.so" ] && { echo "${CWARNING}googlepinyin already installed! ${CEND}"; unset input_method_option; }
      [ "${input_method_option}" = '2' -a -e "/opt/sogoupinyin" ] && { echo "${CWARNING}sougoupinyin already installed! ${CEND}"; unset input_method_option; }
      [ "${input_method_option}" = '3' -a -e "/opt/baidupinyin" ] && { echo "${CWARNING}baidupinyin already installed! ${CEND}"; unset input_method_option; }
      ;;
    --baidunetdisk)
      baidunetdisk_flag=y; shift 1
      [ "${baidunetdisk_flag}" == 'y' -a -e "/opt/baidunetdisk/baidunetdisk" ] && { echo "${CWARNING}baidunetdisk already installed! ${CEND}"; unset baidunetdisk_flag; }
      ;;
    --chrome)
      chrome_flag=y; shift 1
      [ "${chrome_flag}" == 'y' -a -e "/opt/google/chrome/chrome" ] && { echo "${CWARNING}chrome already installed! ${CEND}"; unset chrome_flag; }
      ;;
    --deepinwine)
      deepinwine_flag=y; shift 1
      [ "${deepinwine_flag}" == 'y' -a -e "/etc/apt/sources.list.d/deepin-wine.i-m.dev.list" ] && { echo "${CWARNING}deepinwine_flag already installed! ${CEND}"; unset deepinwine_flag; }
      ;;
    --dingtalk)
      dingtalk_flag=y; shift 1
       [ "${dingtalk_flag}" == 'y' -a -e "/opt/apps/com.alibabainc.dingtalk/files/Elevator.sh" ] && { echo "${CWARNING}dingtalk already installed! ${CEND}"; unset dingtalk_flag; }
      ;;
    --linuxqq)
      linuxqq_flag=y; shift 1
      [ "${linuxqq_flag}" == 'y' -a -e "/usr/local/bin/qq" ] && { echo "${CWARNING}linuxqq already installed! ${CEND}"; unset linuxqq_flag; }
      ;;
    --feishu)
      feishu_flag=y; shift 1
      [ "${feishu_flag}" == 'y' -a -e "/opt/bytedance/feishu/feishu" ] && { echo "${CWARNING}feishu already installed! ${CEND}"; unset feishu_flag; }
      ;;
    --flameshot)
      flameshot_flag=y; shift 1
       [ "${flameshot_flag}" == 'y' -a -e "/usr/bin/flameshot" ] && { echo "${CWARNING}flameshot already installed! ${CEND}"; unset flameshot_flag; }
      ;;
    --indicator_sysmonitor)
      indicator_sysmonitor_flag=y; shift 1
      [ "${indicator_sysmonitor_flag}" == 'y' -a -e "/usr/bin/indicator-sysmonitor" ] && { echo "${CWARNING}indicator sysmonitor already installed! ${CEND}"; unset indicator_sysmonitor_flag; }
      ;;
    --indicator_stickynotes)
      indicator_stickynotes_flag=y; shift 1
      [ "${indicator_stickynotes_flag}" == 'y' -a -e "/usr/bin/indicator-stickynotes" ] && { echo "${CWARNING}indicator stickynotes already installed! ${CEND}"; unset indicator_stickynotes_flag; }
      ;;
    --lantern)
      lantern_flag=y; shift 1
      [ "${lantern_flag}" == 'y' -a -e "/usr/bin/lantern" ] && { echo "${CWARNING}lantern already installed! ${CEND}"; unset lantern_flag; }
      ;;
    --neteasy_cloudmusic)
      neteasy_cloudmusic_flag=y; shift 1
      [ "${neteasy_cloudmusic_flag}" == 'y' -a -e "/opt/netease/netease-cloud-music/netease-cloud-music" ] && { echo "${CWARNING}neteasy cloudmusic already installed! ${CEND}"; unset neteasy_cloudmusic_flag; }
      ;;
    --qqmusic)
      qqmusic_flag=y; shift 1
       [ "${qqmusic_flag}" == 'y' -a -e "/usr/bin/qqmusic" ] && { echo "${CWARNING}qqmusic already installed! ${CEND}"; unset qqmusic_flag; }
      ;;
    --peek)
      peek_flag=y; shift 1
       [ "${peek_flag}" == 'y' -a -e "/usr/bin/peek" ] && { echo "${CWARNING}peek already installed! ${CEND}"; unset peek_flag; }
      ;;
    --qv2ray)
      qv2ray_flag=y; shift 1
       [ "${qv2ray_flag}" == 'y' -a -e "/opt/qv2ray/Qv2ray-v2.7.0-linux-x64.AppImage" ] && { echo "${CWARNING}qv2ray already installed! ${CEND}"; unset qv2ray_flag; }
      ;;
    --sunlogin)
      sunlogin_flag=y; shift 1
      [ "${sunlogin_flag}" == 'y' -a -e "/usr/local/sunlogin" ] && { echo "${CWARNING}sunlogin already installed! ${CEND}"; unset sunlogin_flag; }
      ;;
    --theme_tools)
      theme_tools_flag=y; shift 1
      [ "${theme_tools_flag}" == 'y' -a -e "/usr/bin/gnome-tweaks" ] && { echo "${CWARNING}theme tools already installed! ${CEND}"; unset theme_tools_flag; }
      ;;
    --bilibili_video_downloader)
      bilibili_video_downloader_flag=y; shift 1
      [ "${bilibili_video_downloader_flag}" == 'y' -a -e "/opt/bilibilivideo-downloader/bvdownloader.AppImage" ] && { echo "${CWARNING}bilibili video downloader tools already installed! ${CEND}"; unset theme_tools_flag; }
      ;;
    --wps)
      wps_flag=y; shift 1
      [ "${wps_flag}" == 'y' -a -e "/usr/bin/wps" ] && { echo "${CWARNING}wps already installed! ${CEND}"; unset wps_flag; }
      ;;
    --xDroid)
      xDroid_flag=y; shift 1
      [ "${xDroid_flag}" == 'y' -a -e "/opt/xdroid/bin" ] && { echo "${CWARNING}xDroid already installed! ${CEND}"; unset xDroid_flag; }
      ;;
    --conky)
      conky_flag=y; shift 1
       [ "${conky_flag}" == 'y' -a -e "/usr/bin/conky" ] && { echo "${CWARNING}conky_flag already installed! ${CEND}"; unset conky_flag; }
      ;;
    --my_weather_indicator)
      my_weather_indicator_flag=y; shift 1
      [ "${my_weather_indicator_flag}" == 'y' -a -e "/opt/extras.ubuntu.com/my-weather-indicator/bin/my-weather-indicator" ] && { echo "${CWARNING}my_weather_indicator_flag already installed! ${CEND}"; unset my_weather_indicator_flag; }
      ;;
    --custom)
      custom_flag=y; shift 1
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

if [ ${ARG_NUM} == 0 ]; then
# check default installed
while :; do echo
    read -e -p "Do you want to remove default installed software? [y/n](n): " remove_flag
    remove_flag=${remove_flag:-n}
    if [[ ! ${remove_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break;
    fi
done

# check nvidia driver
if lspci | grep -i NVIDIA > /dev/null; then
    while :; do echo
        read -e -p "Do you want to installed nvdia driver? [y/n](n): " nvdia_flag
        nvdia_flag=${nvdia_flag:-y}
        if [[ ! ${nvdia_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            [ -e "/usr/bin/nvidia-settings" ] && { echo "${CWARNING}Nvdia driver already installed! ${CEND}"; unset nvdia_flag; }
            break;
        fi
    done

    while :; do echo
        read -e -p "Do you want to installed cuda? [y/n](n): " cuda_flag
        cuda_flag=${cuda_flag:-y}
        if [[ ! ${cuda_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            [ -d "/opt/nvidia" ] && { echo "${CWARNING}Nvdia cuda already installed! ${CEND}"; unset cuda_flag; }
            break;
        fi
    done
fi

#check amd driver
if lspci -nn | grep VGA | grep AMD > /dev/null; then
    while :; do echo
        read -e -p "Do you want to installed amd gpu driver? [y/n](n): " amd_flag
        amd_flag=${amd_flag:-y}
        if [[ ! ${amd_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
        else
            [ -e "" ] && { echo "${CWARNING}AMD driver already installed! ${CEND}"; unset amd_flag; }
            break;
        fi
    done
fi

# check input method
while :; do echo
    read -e -p "Do you want to install input method? [y/n](y): " input_method_flag
    input_method_flag=${input_method_flag:-y}
    if [[ ! ${input_method_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        if [ "${input_method_flag}" == 'y' ]; then
            while :; do echo
                echo 'Please select input method:'
                echo -e "\t${CMSG}1${CEND}. Install googlepinyin"
                echo -e "\t${CMSG}2${CEND}. Install sougoupinyin"
                echo -e "\t${CMSG}3${CEND}. Install baidupinyin"
                read -e -p "Please input a number:(Default 1 press Enter) " input_method_option
                input_method_option=${input_method_option:-1}
                if [[ ! ${input_method_option} =~ ^[1-3]$ ]]; then
                    echo "${CWARNING}input error! Please only input number 1~4${CEND}"
                else
                    [ "${input_method_option}" = '1' -a -e "/usr/lib/x86_64-linux-gnu/fcitx/fcitx-googlepinyin.so" ] && { echo "${CWARNING}googlepinyin already installed! ${CEND}"; unset input_method_option; }
                    [ "${input_method_option}" = '2' -a -e "/opt/sogoupinyin" ] && { echo "${CWARNING}sougoupinyin already installed! ${CEND}"; unset input_method_option; }
                    [ "${input_method_option}" = '3' -a -e "/opt/baidupinyin" ] && { echo "${CWARNING}baidupinyin already installed! ${CEND}"; unset input_method_option; }
                    break
                fi
            done
        fi
        break;
    fi
done

# check Baidunetdisk 
while :; do echo
    read -e -p "Do you want to install baidunetdisk? [y/n](y): " baidunetdisk_flag
    baidunetdisk_flag=${baidunetdisk_flag:-y}
    if [[ ! ${baidunetdisk_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${baidunetdisk_flag}" == 'y' -a -e "/opt/baidunetdisk/baidunetdisk" ] && { echo "${CWARNING}baidunetdisk already installed! ${CEND}"; unset baidunetdisk_flag; }
        break;
    fi
done

# check chrome 
while :; do echo
    read -e -p "Do you want to install chrome? [y/n](y): " chrome_flag
    chrome_flag=${chrome_flag:-y}
    if [[ ! ${chrome_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${chrome_flag}" == 'y' -a -e "/opt/google/chrome/chrome" ] && { echo "${CWARNING}chrome already installed! ${CEND}"; unset chrome_flag; }
        break;
    fi
done

# check deepinwine 
while :; do echo
    read -e -p "Do you want to install deepinwine? [y/n](y): " deepinwine_flag
    deepinwine_flag=${deepinwine_flag:-y}
    if [[ ! ${deepinwine_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${deepinwine_flag}" == 'y' -a -e "/etc/apt/sources.list.d/deepin-wine.i-m.dev.list" ] && { echo "${CWARNING}deepinwine_flag already installed! ${CEND}"; unset deepinwine_flag; }
        break;
    fi
done

# check dingtalk
while :; do echo
    read -e -p "Do you want to install dingtalk? [y/n](y): " dingtalk_flag
    dingtalk_flag=${dingtalk_flag:-y}
    if [[ ! ${dingtalk_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${dingtalk_flag}" == 'y' -a -e "/opt/apps/com.alibabainc.dingtalk/files/Elevator.sh" ] && { echo "${CWARNING}dingtalk already installed! ${CEND}"; unset dingtalk_flag; }
        break;
    fi
done

# check linuxqq
while :; do echo
    read -e -p "Do you want to install linuxqq? [y/n](y): " linuxqq_flag
    linuxqq_flag=${linuxqq_flag:-y}
    if [[ ! ${linuxqq_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${linuxqq_flag}" == 'y' -a -e "/usr/local/bin/qq" ] && { echo "${CWARNING}linuxqq already installed! ${CEND}"; unset linuxqq_flag; }
        break;
    fi
done

# check feishu
while :; do echo
    read -e -p "Do you want to install feishu? [y/n](y): " feishu_flag
    feishu_flag=${feishu_flag:-y}
    if [[ ! ${feishu_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${feishu_flag}" == 'y' -a -e "/opt/bytedance/feishu/feishu" ] && { echo "${CWARNING}feishu already installed! ${CEND}"; unset feishu_flag; }
        break;
    fi
done

# check flameshot
while :; do echo
    read -e -p "Do you want to install flameshot? [y/n](y): " flameshot_flag
    flameshot_flag=${flameshot_flag:-y}
    if [[ ! ${flameshot_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${flameshot_flag}" == 'y' -a -e "/usr/bin/flameshot" ] && { echo "${CWARNING}flameshot already installed! ${CEND}"; unset flameshot_flag; }
        break;
    fi
done

# check indicator sysmonitor
while :; do echo
    read -e -p "Do you want to install indicator sysmonitor? [y/n](y): " indicator_sysmonitor_flag
    indicator_sysmonitor_flag=${indicator_sysmonitor_flag:-y}
    if [[ ! ${indicator_sysmonitor_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${indicator_sysmonitor_flag}" == 'y' -a -e "/usr/bin/indicator-sysmonitor" ] && { echo "${CWARNING}indicator sysmonitor already installed! ${CEND}"; unset indicator_sysmonitor_flag; }
        break;
    fi
done

# check indicator stickynotes
while :; do echo
    read -e -p "Do you want to install indicator stickynotes? [y/n](y): " indicator_stickynotes_flag
    indicator_stickynotes_flag=${indicator_stickynotes_flag:-y}
    if [[ ! ${indicator_stickynotes_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${indicator_stickynotes_flag}" == 'y' -a -e "/usr/bin/indicator-stickynotes" ] && { echo "${CWARNING}indicator stickynotes already installed! ${CEND}"; unset indicator_stickynotes_flag; }
        break;
    fi
done

# check lantern
while :; do echo
    read -e -p "Do you want to install lantern? [y/n](y): " lantern_flag
    lantern_flag=${lantern_flag:-y}
    if [[ ! ${lantern_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${lantern_flag}" == 'y' -a -e "/usr/bin/lantern" ] && { echo "${CWARNING}lantern already installed! ${CEND}"; unset lantern_flag; }
        break;
    fi
done

# check neteasy cloudmusic
while :; do echo
    read -e -p "Do you want to install neteasy cloudmusic? [y/n](y): " neteasy_cloudmusic_flag
    neteasy_cloudmusic_flag=${neteasy_cloudmusic_flag:-y}
    if [[ ! ${neteasy_cloudmusic_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${neteasy_cloudmusic_flag}" == 'y' -a -e "/opt/netease/netease-cloud-music/netease-cloud-music" ] && { echo "${CWARNING}neteasy cloudmusic already installed! ${CEND}"; unset neteasy_cloudmusic_flag; }
        break;
    fi
done

# check qqmusic
while :; do echo
    read -e -p "Do you want to install qqmusic? [y/n](y): " qqmusic_flag
    qqmusic_flag=${qqmusic_flag:-y}
    if [[ ! ${qqmusic_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${qqmusic_flag}" == 'y' -a -e "/usr/bin/qqmusic" ] && { echo "${CWARNING}qqmusic already installed! ${CEND}"; unset qqmusic_flag; }
        break;
    fi
done

# check peek
while :; do echo
    read -e -p "Do you want to install peek? [y/n](y): " peek_flag
    peek_flag=${peek_flag:-y}
    if [[ ! ${peek_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${peek_flag}" == 'y' -a -e "/usr/bin/peek" ] && { echo "${CWARNING}peek already installed! ${CEND}"; unset peek_flag; }
        break;
    fi
done

# check qv2ray
while :; do echo
    read -e -p "Do you want to install qv2ray? [y/n](y): " qv2ray_flag
    qv2ray_flag=${qv2ray_flag:-y}
    if [[ ! ${qv2ray_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${qv2ray_flag}" == 'y' -a -e "/opt/qv2ray/Qv2ray-v2.7.0-linux-x64.AppImage" ] && { echo "${CWARNING}qv2ray already installed! ${CEND}"; unset qv2ray_flag; }
        break;
    fi
done

# check sunlogin
while :; do echo
    read -e -p "Do you want to install sunlogin? [y/n](y): " sunlogin_flag
    sunlogin_flag=${sunlogin_flag:-y}
    if [[ ! ${sunlogin_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${sunlogin_flag}" == 'y' -a -e "/usr/local/sunlogin" ] && { echo "${CWARNING}sunlogin already installed! ${CEND}"; unset sunlogin_flag; }
        break;
    fi
done

# check theme tools
while :; do echo
    read -e -p "Do you want to install theme tools? [y/n](y): " theme_tools_flag
    theme_tools_flag=${theme_tools_flag:-y}
    if [[ ! ${theme_tools_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${theme_tools_flag}" == 'y' -a -e "/usr/bin/gnome-tweaks" ] && { echo "${CWARNING}theme tools already installed! ${CEND}"; unset theme_tools_flag; }
        break;
    fi
done

# check bilibili video downloader
while :; do echo
    read -e -p "Do you want to install bilibili video downloader? [y/n](y): " bilibili_video_downloader_flag
    bilibili_video_downloader_flag=${bilibili_video_downloader_flag:-y}
    if [[ ! ${bilibili_video_downloader_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${bilibili_video_downloader_flag}" == 'y' -a -e "/opt/bilibilivideo-downloader/bvdownloader.AppImage" ] && { echo "${CWARNING}bilibili video downloader tools already installed! ${CEND}"; unset theme_tools_flag; }
        break;
    fi
done

# check wps
while :; do echo
    read -e -p "Do you want to install wps? [y/n](y): " wps_flag
    wps_flag=${wps_flag:-y}
    if [[ ! ${wps_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${wps_flag}" == 'y' -a -e "/usr/bin/wps" ] && { echo "${CWARNING}wps already installed! ${CEND}"; unset wps_flag; }
        break;
    fi
done

# check xDroid
while :; do echo
    read -e -p "Do you want to install xDroid? [y/n](y): " xDroid_flag
    xDroid_flag=${xDroid_flag:-y}
    if [[ ! ${xDroid_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${xDroid_flag}" == 'y' -a -e "/opt/xdroid/bin" ] && { echo "${CWARNING}xDroid already installed! ${CEND}"; unset xDroid_flag; }
        break;
    fi
done

# check conky
while :; do echo
    read -e -p "Do you want to install conky? [y/n](y): " conky_flag
    conky_flag=${conky_flag:-y}
    if [[ ! ${conky_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${conky_flag}" == 'y' -a -e "/usr/bin/conky" ] && { echo "${CWARNING}conky_flag already installed! ${CEND}"; unset conky_flag; }
        break;
    fi
done

# check my weather indicator
while :; do echo
    read -e -p "Do you want to install my weather indicator? [y/n](y): " my_weather_indicator_flag
    my_weather_indicator_flag=${my_weather_indicator_flag:-y}
    if [[ ! ${my_weather_indicator_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
         [ "${my_weather_indicator_flag}" == 'y' -a -e "/opt/extras.ubuntu.com/my-weather-indicator/bin/my-weather-indicator" ] && { echo "${CWARNING}my_weather_indicator_flag already installed! ${CEND}"; unset my_weather_indicator_flag; }
        break;
    fi
done

# check custom software
while :; do echo
    read -e -p "Do you want to install custom software? [y/n](y): " custom_flag
    custom_flag=${custom_flag:-y}
    if [[ ! ${custom_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        break;
    fi
done

fi


echo > $log_dir
echo "${CMSG}Ubuntu version ${Ubuntu_ver} ${CEND}"

#set aliyun mirror
. include/source_list.sh;Set_Aliyun_Sourcelist

apt-get install -y curl wget git gcc make

if [ "${remove_flag}" == 'y' ]; then
    . ubsoft/liboffice.sh
    . ubsoft/remove_unwanted.sh
    Remove_Unwanted 2>&1 | tee -a $log_dir
    Uninstall_Libreoffice 2>&1 | tee -a $log_dir
fi

if [ "${nvdia_flag}" == 'y' ]; then
    . ubsoft/nvidia.sh
    Install_NvidiaDriver 2>&1 | tee -a $log_dir
fi

if [ "${cuda_flag}" == 'y' ]; then
     . ubsoft/nvidia.sh
    Install_Cuda 2>&1 | tee -a $log_dir
fi

if [ "${amd_flag}" == 'y' ]; then
    . ubsoft/amd.sh
    Install_AMDDriver 2>&1 | tee -a $log_dir
fi

case "${input_method_option}" in
  1)
    . ubsoft/input-method/fcitx_googlepinyin.sh
    Install_GooglePinyin 2>&1 | tee -a $log_dir
    ;;
  2)
    . ubsoft/input-method/fcitx_sougoupinyin.sh
    Install_Sougoupinyin 2>&1 | tee -a $log_dir
    ;;
  3)
    . ubsoft/input-method/fcitx_baidupinyin.sh
    Install_Baidupinyin 2>&1 | tee -a $log_dir
    ;;
esac

if [ "${baidunetdisk_flag}" == 'y' ]; then
    . ubsoft/baidunetdisk.sh
    Install_Baidunetdisk 2>&1 | tee -a $log_dir
fi

if [ "${chrome_flag}" == 'y' ]; then
    . ubsoft/chrome.sh
    Install_Chrome 2>&1 | tee -a $log_dir
fi

if [ "${deepinwine_flag}" == 'y' ]; then
    . ubsoft/deepin_wine.sh
    Install_DeepinWine 2>&1 | tee -a $log_dir
    Install_Deepin_Wechat 2>&1 | tee -a $log_dir
fi

if [ "${dingtalk_flag}" == 'y' ]; then
    . ubsoft/dingtalk.sh
    Install_Dingtalk 2>&1 | tee -a $log_dir
fi

if [ "${linuxqq_flag}" == 'y' ]; then
    . ubsoft/linuxqq.sh
    Install_LinuxQQ 2>&1 | tee -a $log_dir
fi

if [ "${feishu_flag}" == 'y' ]; then
    . ubsoft/feishu.sh
    Install_Feishu 2>&1 | tee -a $log_dir
fi

if [ "${flameshot_flag}" == 'y' ]; then
    . ubsoft/flameshot.sh
    Install_Flameshot 2>&1 | tee -a $log_dir
fi

if [ "${indicator_sysmonitor_flag}" == 'y' ]; then
    . ubsoft/indicator_sysmonitor.sh
    Install_IndicatorSysmonitor 2>&1 | tee -a $log_dir
fi

if [ "${indicator_stickynotes_flag}" == 'y' ]; then
    . ubsoft/indicator_stickynotes.sh
    Install_IndicatorStickynotes 2>&1 | tee -a $log_dir
fi

if [ "${lantern_flag}" == 'y' ]; then
    . ubsoft/lantern.sh
    Install_Lantern 2>&1 | tee -a $log_dir
fi

if [ "${neteasy_cloudmusic_flag}" == 'y' ]; then
    . ubsoft/neteasy_cloud_music.sh
    Install_NeteasyCloudMusic 2>&1 | tee -a $log_dir
fi

if [ "${peek_flag}" == 'y' ]; then
    . ubsoft/peek.sh
    Install_Peek 2>&1 | tee -a $log_dir
fi

if [ "${qqmusic_flag}" == 'y' ]; then
    . ubsoft/qqmusic.sh
    Install_QQmusic 2>&1 | tee -a $log_dir
fi

if [ "${qv2ray_flag}" == 'y' ]; then
    . ubsoft/qv2ray.sh
    Install_Qv2ray 2>&1 | tee -a $log_dir
fi

if [ "${sunlogin_flag}" == 'y' ]; then
    . ubsoft/sunlogin.sh
    Install_Sunlogin 2>&1 | tee -a $log_dir
fi

if [ "${theme_tools_flag}" == 'y' ]; then
    . ubsoft/theme_tools.sh
    Install_ThemeTools 2>&1 | tee -a $log_dir
fi

if [ "${bilibili_video_downloader_flag}" == 'y' ]; then
    . ubsoft/video_download.sh
    Install_BilbiliDownloader 2>&1 | tee -a $log_dir
fi

if [ "${wps_flag}" == 'y' ]; then
    . ubsoft/wps.sh
    Install_Wps 2>&1 | tee -a $log_dir
fi

if [ "${xDroid_flag}" == 'y' ]; then
    . ubsoft/xDroid.sh
    Install_xDroid 2>&1 | tee -a $log_dir
fi

if [ "${conky_flag}" == 'y' ]; then
    . ubsoft/conky.sh
    Install_Conky 2>&1 | tee -a $log_dir
fi

if [ "${my_weather_indicator_flag}" == 'y' ]; then
    . ubsoft/my_weather_indicator.sh
    Install_MyWeatherIndicator 2>&1 | tee -a $log_dir
fi

if [ "${custom_flag}" == 'y' ]; then
    . ubsoft/common_ubsoft.sh
    Install_custom_SnapApp 2>&1 | tee -a $log_dir
    Install_custom_AptApp 2>&1 | tee -a $log_dir
fi

#install ubuntu 22.04 patch
if [ "${Ubuntu_ver}" == "22" ]; then
    Install_PatchSuport 2>&1 | tee -a $log_dir
fi

apt-get -y autoremove 
snap refresh
chown -R ${run_user}.root /opt

if [ ${ARG_NUM} == 0 ]; then
  while :; do echo
    echo "${CMSG}Please restart system to reload some software.${CEND}"
    read -e -p "Do you want to restart OS ? [y/n]: " reboot_flag
    if [[ ! "${reboot_flag}" =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      break
    fi
  done
fi
[ "${reboot_flag}" == 'y' ] && reboot