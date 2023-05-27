#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                   Test Scirpt                                #
################################################################################
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
. ./include/memory.sh
. ./include/base_desktop.sh
. ./include/system-lib/openssl.sh
. ./include/system-lib/libevent.sh
. ./include/system-lib/librdkafka.sh
. ./include/develop_config.sh
. ./develop-tools/files/rabbitvcs.sh
. ./develop-tools/ide-editer/cursor.sh
. ./develop-tools/ide-editer/vscode.sh
. ./include/language/php/switch_extension.sh
. ./include/language/java/jdk/openjdk-8.sh
. ./include/language/java/jdk/openjdk-11.sh
. ./include/language/erlang/erlang.sh
. ./include/language/php/php-8.2.sh
. ./include/language/php/config_env.sh
. ./include/language/nodejs/nvm.sh
. ./include/language/python/conda.sh
. ./include/message-queue/rabbitmq.sh
. ./include/database/sqlite3.sh
. ./include/multimedia/ffmpeg.sh
. ./include/multimedia/libvmaf.sh
. ./include/container-platform/docker.sh
. ./develop-tools/multimedia/cuda.sh

echo > ${oneinstack_dir}/test.log

####################################################system lib
#Install_Librdkafka | tee -a ${oneinstack_dir}/test.log
#Uninstall_Librdkafka | tee -a ${oneinstack_dir}/test.log


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
# Install_SqliteDesktop
# Install_FFmpegDesktop
# Install_SwithDevEnvDesktop


# Uninstall_FFmpegDesktop

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

#Uninstall_Nvm
#Install_Nvm | tee -a ${oneinstack_dir}/test.log

#Uninstall_Conda
#Install_Conda | tee -a ${oneinstack_dir}/test.log

#######################################test database
#Install_Sqlite3 | tee -a ${oneinstack_dir}/test.log
# Uninstall_Sqlite3 | tee -a ${oneinstack_dir}/test.log


#########################################test message queue
#Uninstall_RabbitMQ | tee -a ${oneinstack_dir}/test.log
#Install_RabbitMQ | tee -a ${oneinstack_dir}/test.log





##########################################test devtool
#Install_Vscode | tee -a ${oneinstack_dir}/test.log



########################################multi-media
#Uninstall_Libvmaf | tee -a ${oneinstack_dir}/test.log
#Install_Libvmaf | tee -a ${oneinstack_dir}/test.log

#Uninstall_FFmpeg | tee -a ${oneinstack_dir}/test.log
#Install_FFmpeg | tee -a ${oneinstack_dir}/test.log
#Install_Cuda | tee -a ${oneinstack_dir}/test.log
#Uninstall_Cuda | tee -a ${oneinstack_dir}/test.log

#############################################container-platform
# Install_Docker_Repository | tee -a ${oneinstack_dir}/test.log
# Install_Docker_Engine | tee -a ${oneinstack_dir}/test.log
# Install_Docker_Desktop | tee -a ${oneinstack_dir}/test.log

# Uninstall_Docker_Desktop | tee -a ${oneinstack_dir}/test.log
# Uninstall_Docker_Engine | tee -a ${oneinstack_dir}/test.log
# Uninstall_Docker_Repository | tee -a ${oneinstack_dir}/test.log


######################################################