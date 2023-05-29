#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
#######################################################################
#                            Ubuntu start test                        #
#######################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }
start_dir=$(dirname "$(dirname "`readlink -f $0`")")
echo $start_dir
log_dir="${start_dir}/log/test_ubsoft.log"
pushd ${start_dir} > /dev/null
. ./include/color.sh
. ./versions.txt
. ./options.conf
. ubsoftware/liboffice.sh
. ubsoftware/common_ubsoft.sh
###################################################################

#Remove_Unneed | tee -a $log_dir
Uninstall_Custome_SnapApp | tee -a $log_dir
Install_Custome_SnapApp | tee -a $log_dir
Uninstall_Custome_AptApp | tee -a $log_dir
Install_Custome_AptApp | tee -a $log_dir

# Install_PatchSuport | tee -a $log_dir
# Install_NvidiaDriver | tee -a $log_dir
# Patch_NeteasyCloudMusicFor2204 2>&1 | tee -a $log_dir
# Patch_QQmusicFor2204 2>&1 | tee -a $log_dir
# Uninstall_BilbiliDownloader
# Install_BilbiliDownloader | tee -a $log_dir 