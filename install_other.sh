#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear

printf "
#######################################################################
#   install service  for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+    #
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
# check elasticsearch
while :; do echo
    read -e -p "Do you want to install elasticsearch? [y/n]: " elasticsearch_flag
    elasticsearch_flag=${elasticsearch_flag:-y}
    if [[ ! ${elasticsearch_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${elasticsearch_flag}" == 'y' -a -e "/usr/share/elasticsearch/bin/elasticsearch" ] && { echo "${CWARNING}elasticsearch already installed! ${CEND}"; unset elasticsearch_flag; }
        break
    fi
done

# check ffmpeg
while :; do echo
    read -e -p "Do you want to install ffmpeg? [y/n]: " ffmpeg_flag
    ffmpeg_flag=${ffmpeg_flag:-y}
    if [[ ! ${ffmpeg_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${ffmpeg_flag}" == 'y' -a -e "/usr/bin/ffmpeg" ] && { echo "${CWARNING}ffmpeg already installed! ${CEND}"; unset ffmpeg_flag; }
        break
    fi
done

# check nvm
while :; do echo
    read -e -p "Do you want to install nvm? [y/n]: " nvm_flag
    nvm_flag=${nvm_flag:-y}
    if [[ ! ${nvm_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${nvm_flag}" == 'y' -a -e "/home/${run_user}/.nvm" ] && { echo "${CWARNING}nvm already installed! ${CEND}"; unset nvm_flag; }
        break
    fi
done

if [ "${elasticsearch_flag}" == 'y' ]; then  
    . include/elasticsearch.sh
    Install_Elasticsearch 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

if [ "${ffmpeg_flag}" == 'y' ]; then  
    . include/ffmpeg.sh
    Install_FFmpeg 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

if [ "${nvm_flag}" == 'y' ]; then  
    . include/nvm.sh  
    Install_Nvm 2>&1 | tee -a ${oneinstack_dir}/install.log
fi


    
if [ ${ARG_NUM} == 0 ]; then
  while :; do echo
    echo "${CMSG}Please restart the server and see if the services start up fine.${CEND}"
    read -e -p "Do you want to restart OS ? [y/n]: " reboot_flag
    reboot_flag=${reboot_flag:-n}
    if [[ ! "${reboot_flag}" =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      break
    fi
  done
fi

if [ "${reboot_flag}" == 'y' ];then
    reboot
else
    exit
fi