#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                           Base Desktop Test Scirpt                           #
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
. ./include/check_dir.sh
. ./include/download.sh
. ./include/get_char.sh
. ./include/memory.sh
. ./include/base_desktop.sh


Uninstall_ElasticStackDesktop
Uninstall_MysqlDesktop
Uninstall_PostgresqlDesktop
Uninstall_MongoDBDesktop
Uninstall_MemcachedDesktop
Uninstall_RedisDesktop
Uninstall_ApacheHttpdDesktop
Uninstall_NginxDesktop
Uninstall_TengineDesktop
Uninstall_OpenrestyDesktop
Uninstall_TomcatDesktop
Uninstall_PureFtpDesktop
Uninstall_PHPFPMDesktop
Uninstall_LAMPDesktop
Uninstall_LNMPDesktop
Uninstall_SupervisorDesktop
Uninstall_ZookeeperDesktop
Uninstall_KafkaDesktop
Uninstall_RabbitmqDesktop
Uninstall_RocketmqDesktop
Uninstall_StopAllDesktop
Uninstall_SqliteDesktop
Uninstall_FFmpegDesktop
Uninstall_SwithDevEnvDesktop
Uninstall_SSHDesktop

Install_ElasticStackDesktop
Install_MysqlDesktop
Install_PostgresqlDesktop
Install_MongoDBDesktop
Install_MemcachedDesktop
Install_RedisDesktop
Install_ApacheHttpdDesktop
Install_NginxDesktop
Install_TengineDesktop
Install_OpenrestyDesktop
Install_TomcatDesktop
Install_PureFtpDesktop
Install_PHPFPMDesktop
Install_LAMPDesktop
Install_LNMPDesktop
Install_SupervisorDesktop
Install_ZookeeperDesktop
Install_KafkaDesktop
Install_RabbitmqDesktop
Install_RocketmqDesktop
Install_StopAllDesktop
Install_SqliteDesktop
Install_FFmpegDesktop
Install_SwithDevEnvDesktop
Install_SSHDesktop