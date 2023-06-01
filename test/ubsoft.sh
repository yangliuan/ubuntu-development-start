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
log_dir="${ubdevenv_dir}/log/test_ubsoft.log"

pushd ${ubdevenv_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/check_os.sh
. ./include/memory.sh
. ./include/check_dir.sh
. ./include/download.sh
. ./include/get_char.sh
. ./include/base_desktop.sh
. ./include/develop_config.sh
. ./include/loadshell.sh
###################################################################

shell_dir=${ubdevenv_dir}/ubsoft && Source_Shells

echo > $log_dir

# Remove_Unneed  2>&1 | tee -a $log_dir
# Install_custom_SnapApp  2>&1 | tee -a $log_dir
# Uninstall_custom_SnapApp  2>&1 | tee -a $log_dir

# Install_custom_AptApp  2>&1 | tee -a $log_dir
# Uninstall_custom_AptApp  2>&1 | tee -a $log_dir

# Install_PatchSuport  2>&1 | tee -a $log_dir
# Install_NvidiaDriver  2>&1 | tee -a $log_dir
# Patch_NeteasyCloudMusicFor2204  2>&1 2>&1 | tee -a $log_dir
# Patch_QQmusicFor2204 2>&1 | tee -a $log_dir

# Install_BilbiliDownloader  2>&1 | tee -a $log_dir 
# Uninstall_BilbiliDownloader  2>&1 | tee -a $log_dir

# Install_Cuda 2>&1| tee -a $log_dir
# Uninstall_Cuda 2>&1| tee -a $log_dir

# Install_IndicatorStickynotes 2>&1 | tee -a $log_dir
# Uninstall_IndicatorSysmonitor 2>&1 | tee -a $log_dir
Install_Fceux 2>&1 | tee -a $log_dir