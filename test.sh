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
. ./include/system-lib/openssl.sh
. ./include/system-lib/libevent.sh
. ./include/base_desktop.sh
. ./include/develop-tools/develop_config.sh
. ./include/language/php/switch_extension.sh
. ./include/develop-tools/rabbitvcs.sh
. ./include/develop-tools/gitlab.sh
. ./include/develop-tools/cursor.sh
. ./include/language/java/jdk/openjdk-8.sh
. ./include/language/java/jdk/openjdk-11.sh
. ./include/language/erlang/erlang.sh
. ./include/language/php/php-8.2.sh
. ./include/language/php/config_env.sh
. ./include/memory.sh

echo > ${oneinstack_dir}/test.log

##################################### test desktop
# Install_ElasticsearchDesktop
# Install_MysqlDesktop
# Install_PostgresqlDesktop
# Install_MongoDBDesktop
# Install_MemcachedDesktop
# Install_RedisDesktop
# Install_ApacheHttpdDesktop
# Install_NginxDesktop
# Install_TomcatDesktop
# Install_PureFtpDesktop
# Install_PHPFPMDesktop
# Install_LAMPDesktop
# Install_SupervisorDesktop
# Install_ZookeeperDesktop
# Install_KafkaDesktop
# Install_RabbitmqDesktop
# Install_StopAllDesktop


# NginxDevConfig
# TengineDevConfig
# OpenRestyDevConfig
# WwwlogsDevConfig
# PhpDevConfig
# Install_Gitlab
# Uninstall_Gitlab
# Uninstall_Cursor
# Uninstall_OpenJDK11


####################################### test language
# Install_OpenJDK8 | tee -a ${oneinstack_dir}/test.log
# Uninstall_OpenJDK8
# Install_OpenJDK11 | tee -a ${oneinstack_dir}/test.log
# Uninstall_OpenJDK11

#Install_Erlang 2>&1 | tee -a ${oneinstack_dir}/test.log
#Uninstall_Erlang


#php_install_dir="${php_install_dir}82"
#Install_PHP82 2>&1 | tee -a ${oneinstack_dir}/test.log
#Set_EnvPath