#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                            Ubsoft Test Scirpt                                #
################################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")
log_dir="${ubdevenv_dir}/log/test_devtools.log"

pushd ${ubdevenv_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/check_os.sh
. ./include/check_dir.sh
. ./include/download.sh
. ./include/get_char.sh
. ./include/loadshell.sh

echo > $log_dir
shell_dir="./devtools/data-manager" && Source_Shells


#Build_MysqlWorkBench 2>&1 | tee -a $log_dir
#Check_Devtools_src 2>&1 | tee -a $log_dir

shell_dir="./devtools/files" && Source_Shells
Install_Git 2>&1 | tee -a $log_dir
#Uninstall_Git  2>&1 | tee -a $log_dir