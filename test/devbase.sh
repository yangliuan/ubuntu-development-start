#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                              Base Test Scirpt                                #
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
. ./include/system-lib/openssl.sh
. ./include/system-lib/libevent.sh
. ./include/system-lib/librdkafka.sh
. ./include/develop_config.sh
. ./include/language/php/switch_extension.sh
. ./include/language/java/jdk/openjdk-8.sh
. ./include/language/java/jdk/openjdk-11.sh
. ./include/language/erlang/erlang.sh
. ./include/language/php/php-8.2.sh
. ./include/language/php/config_env.sh
. ./include/language/nodejs/nvm.sh
. ./include/language/python/conda.sh
. ./include/message-queue/rabbitmq.sh
. ./include/devbase/database/sqlite3.sh
. ./include/multimedia/ffmpeg.sh
. ./include/multimedia/libvmaf.sh
. ./include/devbase/container-platform/docker.sh

echo > $log_dir

####################################################system lib
Install_Librdkafka 2>&1| tee -a $log_dir
Uninstall_Librdkafka 2>&1| tee -a $log_dir


##################################### test desktop
Install_ElasticsearchDesktop
Install_MysqlDesktop
Install_PostgresqlDesktop
Install_MongoDBDesktop
Install_MemcachedDesktop
Install_RedisDesktop
Install_ApacheHttpdDesktop
Install_NginxDesktop
Install_TomcatDesktop
Install_PureFtpDesktop
Install_PHPFPMDesktop
Install_LAMPDesktop
Install_SupervisorDesktop
Install_ZookeeperDesktop
Install_KafkaDesktop
Install_RabbitmqDesktop
Install_StopAllDesktop
Install_SqliteDesktop
Install_FFmpegDesktop
Install_SwithDevEnvDesktop

Uninstall_FFmpegDesktop

NginxDevConfig
TengineDevConfig
OpenRestyDevConfig
WwwlogsDevConfig
PhpDevConfig



####################################### test language
Install_OpenJDK8 2>&1| tee -a $log_dir
Uninstall_OpenJDK8 2>&1| tee -a $log_dir
Install_OpenJDK11 2>&1| tee -a $log_dir
Uninstall_OpenJDK11 2>&1| tee -a $log_dir

Install_Erlang  2>&1| tee -a $log_dir
Uninstall_Erlang 2>&1| tee -a $log_dir


php_install_dir="${php_install_dir}82"
Install_PHP82  2>&1| tee -a $log_dir
Set_EnvPath

Uninstall_Nvm
Install_Nvm 2>&1| tee -a $log_dir

Uninstall_Conda
Install_Conda 2>&1| tee -a $log_dir

#######################################test devbase/database
Install_Sqlite3 2>&1| tee -a $log_dir
Uninstall_Sqlite3 2>&1| tee -a $log_dir


#########################################test message queue
Uninstall_RabbitMQ 2>&1| tee -a $log_dir
Install_RabbitMQ 2>&1| tee -a $log_dir


##########################################test devtool
Install_Vscode 2>&1| tee -a $log_dir



########################################multi-media
Uninstall_Libvmaf 2>&1| tee -a $log_dir
Install_Libvmaf 2>&1| tee -a $log_dir

Uninstall_FFmpeg 2>&1| tee -a $log_dir
Install_FFmpeg 2>&1| tee -a $log_dir

#############################################devbase/container-platform
Install_Docker_Repository 2>&1| tee -a $log_dir
Install_Docker_Engine 2>&1| tee -a $log_dir
Install_Docker_Desktop 2>&1| tee -a $log_dir

Uninstall_Docker_Desktop 2>&1| tee -a $log_dir
Uninstall_Docker_Engine 2>&1| tee -a $log_dir
Uninstall_Docker_Repository 2>&1| tee -a $log_dir


######################################################