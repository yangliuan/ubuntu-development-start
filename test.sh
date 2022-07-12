#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                            develop test      
####################################################################
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
. ./include/base_desktop.sh

# . include/language/php/extension/yasd_debug.sh
# Install_Yasd 2>&1 | tee -a ${oneinstack_dir}/install.log

# . include/system-lib/libevent.sh
# Install_Libevent 2>&1 | tee -a ${oneinstack_dir}/install.log

. include/language/php/switch_extension.sh
Switch_Extension