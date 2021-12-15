#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear

printf "
#######################################################################
# install Elasticsearch for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+ #
#                                                                     #
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
. ./include/elasticsearch.sh

if [ -e "/usr/share/elasticsearch/bin/elasticsearch" ]; then
    echo "${CWARNING}elasticsearch already installed! ${CEND}"
else
    Install_Elasticsearch 2>&1 | tee -a ${oneinstack_dir}/install.log
fi