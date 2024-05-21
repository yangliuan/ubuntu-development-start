#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                          Uninstall Base Softwore                             #
################################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

ubdevenv_dir=$(dirname "$(dirname "`readlink -f $0`")")

pushd ${ubdevenv_dir} > /dev/null
. ./versions.txt
. ./options.conf
. ./include/color.sh
. ./include/get_char.sh
. ./include/check_dir.sh
. ./include/base_desktop.sh
. ./devbase/multimedia/libwebp.sh
. ./devbase/fulltext-search/elastic_stack.sh
. ./devbase/multimedia/ffmpeg.sh
. ./devbase/language/nodejs/node.sh
. ./devbase/language/nodejs/nvm.sh
. ./devbase/language/go/go.sh
. ./devbase/language/go/gvm.sh
. ./devbase/language/java/jdk/openjdk-8.sh
. ./devbase/language/java/jdk/openjdk-11.sh
. ./devbase/language/erlang/erlang.sh
. ./devbase/language/python/supervisor.sh
. ./devbase/language/python/conda.sh
. ./devbase/message-queue/kafka.sh
. ./devbase/message-queue/rabbitmq.sh
. ./devbase/message-queue/rocketmq.sh
. ./devbase/database/sqlite3.sh
. ./devbase/container-platform/docker.sh
. ./devbase/system-lib/pcre.sh
. ./include/command_parameters.sh
. ./devbase/ftp/openssh-server.sh 

ARG_NUM=$#
TEMP=`getopt -o hvVq --long help,version,quiet,all,web,mysql,postgresql,mongodb,sqlite,redis,memcached,elastic_stack,allmq,allphp,mphp_ver:,phpcache,php_extensions:,pureftpd,supervisord,ffmpeg,nodejs_env,python_env,go_env,docker -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Devbase_Help && exit 1
eval set -- "${TEMP}"
while :; do
  [ -z "$1" ] && break;
  case "$1" in
    -h|--help)
      Show_Devbase_Help; exit 0
      ;;
    -q|--quiet)
      quiet_flag=y
      uninstall_flag=y
      shift 1
      ;;
    --all)
      all_flag=y
      web_flag=y
      mysql_flag=y
      postgresql_flag=y
      mongodb_flag=y
      sqlite_flag=y
      redis_flag=y
      memcached_flag=y
      elastic_stack_flag=y
      allmq_flag=y
      allphp_flag=y
      pureftpd_flag=y
      supervisord_flag=y
      ffmpeg_flag=y
      nodejs_env_flag=y
      python_env_flag=y
      go_env_flag=y
      docker_flag=y
      shift 1
      ;;
    --web)
      web_flag=y; shift 1
      ;;
    --mysql)
      mysql_flag=y; shift 1
      ;;
    --postgresql)
      postgresql_flag=y; shift 1
      ;;
    --mongodb)
      mongodb_flag=y; shift 1
      ;;
    --sqlite)
      sqlite_flag=y; shift 1
      ;;
    --redis)
      redis_flag=y; shift 1
      ;;
    --memcached)
      memcached_flag=y; shift 1
      ;;
    --elastic_stack)
      elastic_stack_flag=y; shift 1
      ;;
    --allmq)
      allmq_flag=y; shift 1
      ;;
    --allphp)
      allphp_flag=y; shift 1
      ;;
    --mphp_ver)
      mphp_ver=$2; mphp_flag=y; shift 2
      [[ ! "${mphp_ver}" =~ ^5[3-6]$|^7[0-4]$|^8[0-2]$ ]] && { echo "${CWARNING}mphp_ver input error! Please only input number 53~82${CEND}"; exit 1; }
      ;;
    --phpcache)
      phpcache_flag=y; shift 1
      ;;
    --php_extensions)
      php_extensions=$2; shift 2
      [ -n "`echo ${php_extensions} | grep -w zendguardloader`" ] && pecl_zendguardloader=1
      [ -n "`echo ${php_extensions} | grep -w ioncube`" ] && pecl_ioncube=1
      [ -n "`echo ${php_extensions} | grep -w sourceguardian`" ] && pecl_sourceguardian=1
      [ -n "`echo ${php_extensions} | grep -w imagick`" ] && pecl_imagick=1
      [ -n "`echo ${php_extensions} | grep -w gmagick`" ] && pecl_gmagick=1
      [ -n "`echo ${php_extensions} | grep -w fileinfo`" ] && pecl_fileinfo=1
      [ -n "`echo ${php_extensions} | grep -w imap`" ] && pecl_imap=1
      [ -n "`echo ${php_extensions} | grep -w ldap`" ] && pecl_ldap=1
      [ -n "`echo ${php_extensions} | grep -w calendar`" ] && pecl_calendar=1
      [ -n "`echo ${php_extensions} | grep -w phalcon`" ] && pecl_phalcon=1
      [ -n "`echo ${php_extensions} | grep -w yaf`" ] && pecl_yaf=1
      [ -n "`echo ${php_extensions} | grep -w yar`" ] && pecl_yar=1
      [ -n "`echo ${php_extensions} | grep -w redis`" ] && pecl_redis=1
      [ -n "`echo ${php_extensions} | grep -w memcached`" ] && pecl_memcached=1
      [ -n "`echo ${php_extensions} | grep -w memcache`" ] && pecl_memcache=1
      [ -n "`echo ${php_extensions} | grep -w mongodb`" ] && pecl_mongodb=1
      [ -n "`echo ${php_extensions} | grep -w swoole`" ] && pecl_swoole=1
      [ -n "`echo ${php_extensions} | grep -w xdebug`" ] && pecl_xdebug=1
      [ -n "`echo ${php_extensions} | grep -w yasd`" ] && pecl_yasd=1
      [ -n "`echo ${php_extensions} | grep -w event`" ] && pecl_event=1
      [ -n "`echo ${php_extensions} | grep -w parallel`" ] && pecl_parallel=1
      [ -n "`echo ${php_extensions} | grep -w ssh2`" ] && pecl_ssh2=1
      [ -n "`echo ${php_extensions} | grep -w grpc`" ] && pecl_grpc=1
      [ -n "`echo ${php_extensions} | grep -w protobuf`" ] && pecl_protobuf=1
      [ -n "`echo ${php_extensions} | grep -w rdkafka`" ] && pecl_rdkafka=1
      ;;
    --pureftpd)
      pureftpd_flag=y; shift 1
      ;;
    --supervisord)
      supervisord_flag=y; shift 1
      ;;
    --ffmpeg)
      ffmpeg_flag=y; shift 1
      ;;
    --nodejs_env)
      nodejs_env_flag=y; shift 1
      ;;
    --python_env)
      python_env_flag=y; shift 1
      ;;
    --go_env)
      go_env_flag=y; shift 1
      ;;
    --docker)
      docker_flag=y; shift 1
      ;;
    --)
      shift
      ;;
    *)
      echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Devbase_Help && exit 1
      ;;
  esac
done

Uninstall_status() {
  if [ "${quiet_flag}" != 'y' ]; then
    while :; do echo
      read -e -p "Do you want to uninstall? [y/n]: " uninstall_flag
      if [[ ! ${uninstall_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
        break
      fi
    done
  fi
}

Uninstall_alldesktop() {
    Uninstall_ElasticStackDesktop;Uninstall_MysqlDesktop;Uninstall_PostgresqlDesktop;Uninstall_MongoDBDesktop;Uninstall_SqliteDesktop;Uninstall_MemcachedDesktop;Uninstall_RedisDesktop;Uninstall_ApacheHttpdDesktop;Uninstall_NginxDesktop;Uninstall_OpenrestyDesktop;Uninstall_TengineDesktop;Uninstall_TomcatDesktop;Uninstall_PureFtpDesktop;Uninstall_PHPFPMDesktop;Uninstall_LNMPDesktop;Uninstall_LAMPDesktop;Uninstall_SupervisorDesktop;Uninstall_KafkaDesktop;Uninstall_RabbitmqDesktop;Uninstall_FFmpegDesktop;Uninstall_SwithDevEnvDesktop;Uninstall_SSHDesktop;Uninstall_StopAllDesktop
}

Print_Warn() {
  echo
  echo "${CWARNING}You will uninstall OneinStack, Please backup your configure files and DB data! ${CEND}"
}

Print_JDK() {
  [ -d "/usr/java" ] && echo /usr/java
  [ -h "/usr/bin/java" ] && echo /usr/bin/java
}

Uninstall_JDK() {
  [ -d "/usr/java" ] && { rm -rf /usr/java; sed -i '/export JAVA_HOME=/d' /etc/profile; sed -i '/export CLASSPATH=/d' /etc/profile; sed -i 's@\$JAVA_HOME/bin:@@' /etc/profile; }
  [ -h "/usr/bin/java" ] && rm -rf /usr/bin/java
  Uninstall_OpenJDK8;Uninstall_OpenJDK11
}

Print_web() {
  [ -d "${nginx_install_dir}" ] && echo ${nginx_install_dir}
  [ -d "${tengine_install_dir}" ] && echo ${tengine_install_dir}
  [ -d "${openresty_install_dir}" ] && echo ${openresty_install_dir}
  [ -e "/etc/init.d/nginx" ] && echo /etc/init.d/nginx
  [ -e "/lib/systemd/system/nginx.service" ] && echo /lib/systemd/system/nginx.service
  [ -e "/etc/logrotate.d/nginx" ] && echo /etc/logrotate.d/nginx

  [ -d "${apache_install_dir}" ] && echo ${apache_install_dir}
  [ -e "/lib/systemd/system/httpd.service" ] && echo /lib/systemd/system/httpd.service
  [ -e "/etc/init.d/httpd" ] && echo /etc/init.d/httpd
  [ -e "/etc/logrotate.d/apache" ] && echo /etc/logrotate.d/apache

  [ -d "${tomcat_install_dir}" ] && echo ${tomcat_install_dir}
  [ -e "/etc/init.d/tomcat" ] && echo /etc/init.d/tomcat
  [ -e "/etc/logrotate.d/tomcat" ] && echo /etc/logrotate.d/tomcat
  [ -d "${apr_install_dir}" ] && echo ${apr_install_dir}
}

Uninstall_Web() {
  [ -d "${nginx_install_dir}" ] && { killall nginx > /dev/null 2>&1; rm -rf ${nginx_install_dir} /etc/init.d/nginx /etc/logrotate.d/nginx /etc/profile.d/nginx.sh /etc/profile.d/nginx.disable; echo "${CMSG}Nginx uninstall completed! ${CEND}"; }
  [ -d "${tengine_install_dir}" ] && { killall nginx > /dev/null 2>&1; rm -rf ${tengine_install_dir} /etc/init.d/nginx /etc/logrotate.d/nginx /etc/profile.d/tengine.sh /etc/profile.d/tengine.disable; echo "${CMSG}Tengine uninstall completed! ${CEND}"; }
  [ -d "${openresty_install_dir}" ] && { killall nginx > /dev/null 2>&1; rm -rf ${openresty_install_dir} /etc/init.d/nginx /etc/logrotate.d/nginx /etc/profile.d/openresty.sh /etc/profile.d/openresty.disable; echo "${CMSG}OpenResty uninstall completed! ${CEND}"; }
  [ -e "/lib/systemd/system/nginx.service" ] && { systemctl disable nginx > /dev/null 2>&1; rm -f /lib/systemd/system/nginx.service; }
  [ -d "${apache_install_dir}" ] && { service httpd stop > /dev/null 2>&1; rm -rf ${apache_install_dir} /etc/init.d/httpd /etc/logrotate.d/apache /etc/profile.d/apachehttpd.sh; echo "${CMSG}Apache uninstall completed! ${CEND}"; }
  [ -e "/lib/systemd/system/httpd.service" ] && { systemctl disable httpd > /dev/null 2>&1; rm -f /lib/systemd/system/httpd.service; } 
  [ -d "${tomcat_install_dir}" ] && { killall java > /dev/null 2>&1; rm -rf ${tomcat_install_dir} /etc/init.d/tomcat /etc/logrotate.d/tomcat; echo "${CMSG}Tomcat uninstall completed! ${CEND}"; }
  sed -i 's@^website_name=.*@website_name=@' ./options.conf
  sed -i 's@^backup_content=.*@backup_content=@' ./options.conf
  [ -d "${apr_install_dir}" ] && rm -rf ${apr_install_dir}
  Uninstall_Pcre;Uninstall_NginxDesktop;Uninstall_OpenrestyDesktop;Uninstall_TengineDesktop;Uninstall_ApacheHttpdDesktop;Uninstall_LNMPDesktop;Uninstall_LAMPDesktop;Uninstall_SwithDevEnvDesktop;Uninstall_StopAllDesktop
}

Print_MySQL() {
  [ -e "${db_install_dir}" ] && echo ${db_install_dir}
  [ -e "/etc/init.d/mysqld" ] && echo /etc/init.d/mysqld
  [ -e "/etc/my.cnf" ] && echo /etc/my.cnf
}

Print_PostgreSQL() {
  [ -e "${pgsql_install_dir}" ] && echo ${pgsql_install_dir}
  [ -e "/etc/init.d/postgresql" ] && echo /etc/init.d/postgresql
  [ -e "/lib/systemd/system/postgresql.service" ] && echo /lib/systemd/system/postgresql.service
}

Print_MongoDB() {
  [ -e "${mongo_install_dir}" ] && echo ${mongo_install_dir}
  [ -e "/etc/init.d/mongod" ] && echo /etc/init.d/mongod
  [ -e "/lib/systemd/system/mongod.service" ] && echo /lib/systemd/system/mongod.service
  [ -e "/etc/mongod.conf" ] && echo /etc/mongod.conf
}

Print_Sqlite() {
  [ -e "/usr/local/bin/sqlite3" ] && echo /usr/local/bin/sqlite3
}

Uninstall_MySQL() {
  # uninstall mysql,mariadb,percona
  if [ -d "${db_install_dir}/support-files" ]; then
    service mysqld stop > /dev/null 2>&1
    rm -rf ${db_install_dir} /etc/init.d/mysqld /etc/my.cnf* /etc/ld.so.conf.d/*{mysql,mariadb,percona}*.conf
    id -u mysql >/dev/null 2>&1 ; [ $? -eq 0 ] && userdel mysql
    [ -e "${db_data_dir}" ] && /bin/mv ${db_data_dir}{,$(date +%Y%m%d%H)}
    sed -i 's@^dbrootpwd=.*@dbrootpwd=@' ./data/database.pwd
    sed -i "s@${db_install_dir}/bin:@@" /etc/profile
    Uninstall_MysqlDesktop
    echo "${CMSG}MySQL uninstall completed! ${CEND}"
  fi
}

Uninstall_PostgreSQL() {
  # uninstall postgresql
  if [ -e "${pgsql_install_dir}/bin/psql" ]; then
    service postgresql stop > /dev/null 2>&1
    rm -rf ${pgsql_install_dir} /etc/init.d/postgresql
    [ -e "/lib/systemd/system/postgresql.service" ] && { systemctl disable postgresql > /dev/null 2>&1; rm -f /lib/systemd/system/postgresql.service; }
    [ -e "${php_install_dir}/etc/php.d/pgsql.ini" ] && rm -f ${php_install_dir}/etc/php.d/pgsql.ini
    id -u postgres >/dev/null 2>&1 ; [ $? -eq 0 ] && userdel postgres
    [ -e "${pgsql_data_dir}" ] && /bin/mv ${pgsql_data_dir}{,$(date +%Y%m%d%H)}
    sed -i 's@^dbpostgrespwd=.*@dbpostgrespwd=@' ./data/database.pwd
    sed -i "s@${pgsql_install_dir}/bin:@@" /etc/profile
    Uninstall_PostgresqlDesktop
    echo "${CMSG}PostgreSQL uninstall completed! ${CEND}"
  fi
}

Uninstall_MongoDB() {
  # uninstall mongodb
  if [ -e "${mongo_install_dir}/bin/mongo" ]; then
    service mongod stop > /dev/null 2>&1
    rm -rf ${mongo_install_dir} /etc/mongod.conf /etc/init.d/mongod /tmp/mongo*.sock
    [ -e "/lib/systemd/system/mongod.service" ] && { systemctl disable mongod > /dev/null 2>&1; rm -f /lib/systemd/system/mongod.service; }
    [ -e "${php_install_dir}/etc/php.d/mongo.ini" ] && rm -f ${php_install_dir}/etc/php.d/mongo.ini
    [ -e "${php_install_dir}/etc/php.d/mongodb.ini" ] && rm -f ${php_install_dir}/etc/php.d/mongodb.ini
    id -u mongod > /dev/null 2>&1 ; [ $? -eq 0 ] && userdel mongod
    [ -e "${mongo_data_dir}" ] && /bin/mv ${mongo_data_dir}{,$(date +%Y%m%d%H)}
    sed -i 's@^dbmongopwd=.*@dbmongopwd=@' ./data/database.pwd
    sed -i "s@${mongo_install_dir}/bin:@@" /etc/profile
    Uninstall_MongoDBDesktop
    echo "${CMSG}MongoDB uninstall completed! ${CEND}"
  fi
}

Print_ElasticStack() {
  [ -e "/usr/share/elasticsearch/bin/elasticsearch" ] && echo /usr/share/elasticsearch/bin/elasticsearch
  [ -e "/usr/share/elasticsearch/bin/elasticsearch" ] && /usr/share/elasticsearch/bin/elasticsearch -version
}

Print_AllMessageQueue() {
  Print_Kafka
  Print_Rabbitmq
  Print_Rocketmq
}

Uninstall_AllMessageQueue() {
  . ./devbase/message-queue/kafka.sh;Uninstall_Kafka
  . ./devbase/system-lib/librdkafka.sh;Uninstall_Librdkafka
  . ./devbase/message-queue/rabbitmq.sh;Uninstall_RabbitMQ
  . ./devbase/message-queue/rocketmq.sh;Uninstall_RocketMQ
  Uninstall_RabbitmqDesktop;Uninstall_KafkaDesktop;Uninstall_ZookeeperDesktop;Uninstall_RocketmqDesktop
}

Print_Kafka() {
  [ -e "${kafka_install_dir}" ] && echo ${kafka_install_dir}
  [ -e "/lib/systemd/system/zookeeper.service" ] && echo "/lib/systemd/system/zookeeper.service"
  [ -e "/lib/systemd/system/kafka.service" ] && echo "/lib/systemd/system/kafka.service"
}

Print_Rabbitmq() {
  [ -e "${rabbitmq_install_dir}" ] && echo ${rabbitmq_install_dir}
}

Print_Rocketmq() {
  [ -e "${rocketmq_install_dir}" ] && echo ${rocketmq_install_dir}
}

Print_PHP() {
  [ -e "${php_install_dir}" ] && echo ${php_install_dir}
  [ -e "/etc/init.d/php-fpm" ] && echo /etc/init.d/php-fpm
  [ -e "/lib/systemd/system/php-fpm.service" ] && echo /lib/systemd/system/php-fpm.service
}

Print_MPHP() {
  [ -e "${php_install_dir}${mphp_ver}" ] && echo ${php_install_dir}${mphp_ver}
  [ -e "/etc/init.d/php${mphp_ver}-fpm" ] && echo /etc/init.d/php${mphp_ver}-fpm
  [ -e "/lib/systemd/system/php${mphp_ver}-fpm.service" ] && echo /lib/systemd/system/php${mphp_ver}-fpm.service
}

Print_ALLPHP() {
  [ -e "${php_install_dir}" ] && echo ${php_install_dir}
  [ -e "/etc/init.d/php-fpm" ] && echo /etc/init.d/php-fpm
  [ -e "/lib/systemd/system/php-fpm.service" ] && echo /lib/systemd/system/php-fpm.service
  for php_ver in 53 54 55 56 70 71 72 73 74 80 81; do
    [ -e "${php_install_dir}${php_ver}" ] && echo ${php_install_dir}${php_ver}
    [ -e "/etc/init.d/php${php_ver}-fpm" ] && echo /etc/init.d/php${php_ver}-fpm
    [ -e "/lib/systemd/system/php${php_ver}-fpm.service" ] && echo /lib/systemd/system/php${php_ver}-fpm.service
  done
  [ -e "${imagick_install_dir}" ] && echo ${imagick_install_dir}
  [ -e "${gmagick_install_dir}" ] && echo ${gmagick_install_dir}
  [ -e "${curl_install_dir}" ] && echo ${curl_install_dir}
  [ -e "${freetype_install_dir}" ] && echo ${freetype_install_dir}
  [ -e "${libiconv_install_dir}" ] && echo ${libiconv_install_dir}
}

Uninstall_PHP() {
  [ -e "/etc/init.d/php-fpm" ] && { service php-fpm stop > /dev/null 2>&1; rm -f /etc/init.d/php-fpm; }
  [ -e "/lib/systemd/system/php-fpm.service" ] && { systemctl stop php-fpm > /dev/null 2>&1; systemctl disable php-fpm > /dev/null 2>&1; rm -f /lib/systemd/system/php-fpm.service; }
  [ -e "${apache_install_dir}/conf/httpd.conf" ] && [ -n "`grep libphp ${apache_install_dir}/conf/httpd.conf`" ] && sed -i '/libphp/d' ${apache_install_dir}/conf/httpd.conf
  [ -e "${php_install_dir}" ] && { rm -rf ${php_install_dir}; echo "${CMSG}PHP uninstall completed! ${CEND}"; }
  rm -rf /etc/profile.d/php.sh
  Uninstall_PHPFPMDesktop;Uninstall_LNMPDesktop;
}

Uninstall_MPHP() {
  [ -e "/etc/init.d/php${mphp_ver}-fpm" ] && { service php${mphp_ver}-fpm stop > /dev/null 2>&1; rm -f /etc/init.d/php${mphp_ver}-fpm; }
  [ -e "/lib/systemd/system/php${mphp_ver}-fpm.service" ] && { systemctl stop php${mphp_ver}-fpm > /dev/null 2>&1; systemctl disable php${mphp_ver}-fpm > /dev/null 2>&1; rm -f /lib/systemd/system/php${mphp_ver}-fpm.service; }
  [ -e "${php_install_dir}${mphp_ver}" ] && { rm -rf ${php_install_dir}${mphp_ver}; echo "${CMSG}PHP${mphp_ver} uninstall completed! ${CEND}"; }
}

Uninstall_ALLPHP() {
  [ -e "/etc/init.d/php-fpm" ] && { service php-fpm stop > /dev/null 2>&1; rm -f /etc/init.d/php-fpm; }
  [ -e "/lib/systemd/system/php-fpm.service" ] && { systemctl stop php-fpm > /dev/null 2>&1; systemctl disable php-fpm > /dev/null 2>&1; rm -f /lib/systemd/system/php-fpm.service; }
  [ -e "${apache_install_dir}/conf/httpd.conf" ] && [ -n "`grep libphp ${apache_install_dir}/conf/httpd.conf`" ] && sed -i '/libphp/d' ${apache_install_dir}/conf/httpd.conf
  [ -e "${php_install_dir}" ] && { rm -rf ${php_install_dir}; echo "${CMSG}PHP uninstall completed! ${CEND}"; }
  rm -rf /etc/profile.d/php.sh
  for php_ver in 53 54 55 56 70 71 72 73 74 80 81 82 83; do
    [ -e "/etc/init.d/php${php_ver}-fpm" ] && { service php${php_ver}-fpm stop > /dev/null 2>&1; rm -f /etc/init.d/php${php_ver}-fpm; }
    [ -e "/lib/systemd/system/php${php_ver}-fpm.service" ] && { systemctl stop php${php_ver}-fpm > /dev/null 2>&1; systemctl disable php${php_ver}-fpm > /dev/null 2>&1; rm -f /lib/systemd/system/php${php_ver}-fpm.service; }
    [ -e "${php_install_dir}${php_ver}" ] && { rm -rf ${php_install_dir}${php_ver}; echo "${CMSG}PHP${php_ver} uninstall completed! ${CEND}"; }
  done
  [ -e "${imagick_install_dir}" ] && rm -rf ${imagick_install_dir}
  [ -e "${gmagick_install_dir}" ] && rm -rf ${gmagick_install_dir}
  [ -e "${curl_install_dir}" ] && rm -rf ${curl_install_dir}
  [ -e "${freetype_install_dir}" ] && rm -rf ${freetype_install_dir}
  [ -e "${libiconv_install_dir}" ] && rm -rf ${libiconv_install_dir}
  Uninstall_PHPFPMDesktop;Uninstall_LNMPDesktop
}

Uninstall_PHPcache() {
  . ./devbase/language/php/extension/zendopcache.sh
  . ./devbase/language/php/extension/xcache.sh
  . ./devbase/language/php/extension/apcu.sh
  . ./devbase/language/php/extension/eaccelerator.sh
  Uninstall_ZendOPcache
  Uninstall_XCache
  Uninstall_APCU
  Uninstall_eAccelerator
  # reload php
  [ -e "${php_install_dir}/sbin/php-fpm" ] && { [ -e "/bin/systemctl" ] && systemctl reload php-fpm || service php-fpm reload; }
  [ -n "${mphp_ver}" -a -e "${php_install_dir}${mphp_ver}/sbin/php-fpm" ] && { [ -e "/bin/systemctl" ] && systemctl reload php${mphp_ver}-fpm || service php${mphp_ver}-fpm reload; }
  [ -e "${apache_install_dir}/bin/apachectl" ] && ${apache_install_dir}/bin/apachectl -k graceful
}

Uninstall_PHPext() {
  # ZendGuardLoader
  if [ "${pecl_zendguardloader}" == '1' ]; then
    . ./devbase/language/php/extension/ZendGuardLoader.sh
    Uninstall_ZendGuardLoader
  fi

  # ioncube
  if [ "${pecl_ioncube}" == '1' ]; then
    . ./devbase/language/php/extension/ioncube.sh
    Uninstall_ionCube
  fi

  # SourceGuardian
  if [ "${pecl_sourceguardian}" == '1' ]; then
    . ./devbase/language/php/extension/sourceguardian.sh
    Uninstall_SourceGuardian
  fi

  # imagick
  if [ "${pecl_imagick}" == '1' ]; then
    . ./devbase/multimedia/ImageMagick.sh
    . ./devbase/language/php/extension/pecl_imagick.sh
    Uninstall_ImageMagick
    Uninstall_pecl_imagick
  fi

  # gmagick
  if [ "${pecl_gmagick}" == '1' ]; then
    . ./devbase/multimedia/GraphicsMagick.sh
    . ./devbase/language/php/extension/pecl_gmagick.sh
    Uninstall_GraphicsMagick
    Uninstall_pecl_gmagick
  fi

  # fileinfo
  if [ "${pecl_fileinfo}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_fileinfo.sh
    Uninstall_pecl_fileinfo
  fi

  # imap
  if [ "${pecl_imap}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_imap.sh
    Uninstall_pecl_imap
  fi

  # ldap
  if [ "${pecl_ldap}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_ldap.sh
    Uninstall_pecl_ldap
  fi

  # calendar
  if [ "${pecl_calendar}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_calendar.sh
    Uninstall_pecl_calendar
  fi

  # phalcon
  if [ "${pecl_phalcon}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_phalcon.sh
    Uninstall_pecl_phalcon
  fi

  # yaf
  if [ "${pecl_yaf}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_yaf.sh
    Uninstall_pecl_yaf
  fi

  # yar
  if [ "${pecl_yar}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_yar.sh
    Uninstall_pecl_yar
  fi

  # pecl_memcached
  if [ "${pecl_memcached}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_memcached.sh
    Uninstall_pecl_memcached
  fi

  # pecl_memcache
  if [ "${pecl_memcache}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_memcache.sh
    Uninstall_pecl_memcache
  fi

  # pecl_redis
  if [ "${pecl_redis}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_redis.sh
    Uninstall_pecl_redis
  fi

  # pecl_mongodb
  if [ "${pecl_mongodb}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_mongodb.sh
    Uninstall_pecl_mongodb
  fi

  # swoole
  if [ "${pecl_swoole}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_swoole.sh
    Uninstall_pecl_swoole
  fi

  # xdebug
  if [ "${pecl_xdebug}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_xdebug.sh
    Uninstall_pecl_xdebug
  fi

  # yasd_debug
  if [ "${yasd_debug}" == '1' ]; then
    . ./devbase/language/php/extension/yasd_debug.sh
    Uninstall_Yasd
  fi

  # event
  if [ "${pecl_event}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_event.sh
    Uninstall_pecl_event
  fi

  # parallel
  if [ "${pecl_parallel}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_parallel.sh
    Uninstall_pecl_parallel
  fi

   # ssh2
  if [ "${pecl_ssh2}" == '1' ]; then
    . ./devbase/system-lib/libssh2.sh
    . ./devbase/language/php/extension/pecl_ssh2.sh
    Uninstall_Libssh2
    Uninstall_pecl_ssh2
  fi

  # grpc
  if [ "${pecl_grpc}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_grpc.sh
    Uninstall_pecl_grpc
  fi

  # protobuf
  if [ "${pecl_protobuf}" == '1' ]; then
    . ./devbase/language/php/extension/pecl_protobuf.sh
    Uninstall_pecl_protobuf
  fi

  # rdkafka
  if [ "${pecl_rdkafka}" == '1' ]; then
    . ./devbase/system-lib/librdkafka.sh
    . ./devbase/language/php/extension/pecl_rdkafka.sh
    Uninstall_Librdkafka
    Uninstall_pecl_rdkafka
  fi

  # reload php
  [ -e "${php_install_dir}/sbin/php-fpm" ] && { [ -e "/bin/systemctl" ] && systemctl reload php-fpm || service php-fpm reload; }
  [ -n "${mphp_ver}" -a -e "${php_install_dir}${mphp_ver}/sbin/php-fpm" ] && { [ -e "/bin/systemctl" ] && systemctl reload php${mphp_ver}-fpm || service php${mphp_ver}-fpm reload; }
  [ -e "${apache_install_dir}/bin/apachectl" ] && ${apache_install_dir}/bin/apachectl -k graceful
}

Menu_PHPext() {
  while :; do
    echo 'Please select uninstall PHP extensions:'
    echo -e "\t${CMSG} 0${CEND}. Do not uninstall"
    echo -e "\t${CMSG} 1${CEND}. Uninstall zendguardloader(PHP<=5.6)"
    echo -e "\t${CMSG} 2${CEND}. Uninstall ioncube"
    echo -e "\t${CMSG} 3${CEND}. Uninstall sourceguardian(PHP<=7.2)"
    echo -e "\t${CMSG} 4${CEND}. Uninstall imagick"
    echo -e "\t${CMSG} 5${CEND}. Uninstall gmagick"
    echo -e "\t${CMSG} 6${CEND}. Uninstall fileinfo"
    echo -e "\t${CMSG} 7${CEND}. Uninstall imap"
    echo -e "\t${CMSG} 8${CEND}. Uninstall ldap"
    echo -e "\t${CMSG} 9${CEND}. Uninstall phalcon(PHP>=5.5)"
    echo -e "\t${CMSG}10${CEND}. Uninstall yaf(PHP>=7.0)"
    echo -e "\t${CMSG}11${CEND}. Uninstall redis"
    echo -e "\t${CMSG}12${CEND}. Uninstall memcached"
    echo -e "\t${CMSG}13${CEND}. Uninstall memcache"
    echo -e "\t${CMSG}14${CEND}. Uninstall mongodb"
    echo -e "\t${CMSG}15${CEND}. Uninstall pgsql"
    echo -e "\t${CMSG}16${CEND}. Uninstall swoole"
    echo -e "\t${CMSG}19${CEND}. Uninstall xdebug(PHP>=5.5)"
    echo -e "\t${CMSG}18${CEND}. Install yasd(PHP>=7.2)"
    echo -e "\t${CMSG}19${CEND}. Install event(PHP>=5.4)"
    echo -e "\t${CMSG}20${CEND}. Install parallel(PHP>=7.2)"
    echo -e "\t${CMSG}21${CEND}. Install ssh2"
    echo -e "\t${CMSG}22${CEND}. Install grpc(PHP>=7.0)"
    echo -e "\t${CMSG}23${CEND}. Install protobuf(PHP>=7.0)"
    echo -e "\t${CMSG}24${CEND}. Install rdkafka"
    read -e -p "Please input a number:(Default 0 press Enter) " phpext_option
    phpext_option=${phpext_option:-0}
    [ "${phpext_option}" == '0' ] && break
    array_phpext=(${phpext_option})
    array_all=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24)
    for v in ${array_phpext[@]}
    do
      [ -z "`echo ${array_all[@]} | grep -w ${v}`" ] && phpext_flag=1
    done
    if [ "${phpext_flag}" == '1' ]; then
      unset phpext_flag
      echo; echo "${CWARNING}input error! Please only input number 1 2 3 14 and so on${CEND}"; echo
      continue
    else      
      [ -n "`echo ${array_phpext[@]} | grep -w 1`" ] && pecl_zendguardloader=1
      [ -n "`echo ${array_phpext[@]} | grep -w 2`" ] && pecl_ioncube=1
      [ -n "`echo ${array_phpext[@]} | grep -w 3`" ] && pecl_sourceguardian=1
      [ -n "`echo ${array_phpext[@]} | grep -w 4`" ] && pecl_imagick=1
      [ -n "`echo ${array_phpext[@]} | grep -w 5`" ] && pecl_gmagick=1
      [ -n "`echo ${array_phpext[@]} | grep -w 6`" ] && pecl_fileinfo=1
      [ -n "`echo ${array_phpext[@]} | grep -w 7`" ] && pecl_imap=1
      [ -n "`echo ${array_phpext[@]} | grep -w 8`" ] && pecl_ldap=1
      [ -n "`echo ${array_phpext[@]} | grep -w 9`" ] && pecl_phalcon=1
      [ -n "`echo ${array_phpext[@]} | grep -w 10`" ] && pecl_yaf=1
      [ -n "`echo ${array_phpext[@]} | grep -w 11`" ] && pecl_redis=1
      [ -n "`echo ${array_phpext[@]} | grep -w 12`" ] && pecl_memcached=1
      [ -n "`echo ${array_phpext[@]} | grep -w 13`" ] && pecl_memcache=1
      [ -n "`echo ${array_phpext[@]} | grep -w 14`" ] && pecl_mongodb=1
      [ -n "`echo ${array_phpext[@]} | grep -w 15`" ] && pecl_pgsql=1
      [ -n "`echo ${array_phpext[@]} | grep -w 16`" ] && pecl_swoole=1
      [ -n "`echo ${array_phpext[@]} | grep -w 17`" ] && pecl_xdebug=1
      [ -n "`echo ${array_phpext[@]} | grep -w 18`" ] && pecl_yasd=1
      [ -n "`echo ${array_phpext[@]} | grep -w 19`" ] && pecl_event=1
      [ -n "`echo ${array_phpext[@]} | grep -w 20`" ] && pecl_parallel=1
      [ -n "`echo ${array_phpext[@]} | grep -w 21`" ] && pecl_ssh2=1
      [ -n "`echo ${array_phpext[@]} | grep -w 22`" ] && pecl_grpc=1
      [ -n "`echo ${array_phpext[@]} | grep -w 23`" ] && pecl_protobuf=1
      [ -n "`echo ${array_phpext[@]} | grep -w 24`" ] && pecl_rdkafka=1
      break
    fi
  done
}

Print_PureFtpd() {
  [ -e "${pureftpd_install_dir}" ] && echo ${pureftpd_install_dir}
  [ -e "/etc/init.d/pureftpd" ] && echo /etc/init.d/pureftpd
  [ -e "/lib/systemd/system/pureftpd.service" ] && echo /lib/systemd/system/pureftpd.service
}

Uninstall_PureFtpd() {
  [ -e "${pureftpd_install_dir}" ] && { service pureftpd stop > /dev/null 2>&1; rm -rf ${pureftpd_install_dir} /etc/init.d/pureftpd; echo "${CMSG}Pureftpd uninstall completed! ${CEND}"; }
  [ -e "/lib/systemd/system/pureftpd.service" ] && { systemctl disable pureftpd > /dev/null 2>&1; rm -f /lib/systemd/system/pureftpd.service; }
  Uninstall_PureFtpDesktop;
}

Print_Redis_server() {
  [ -e "${redis_install_dir}" ] && echo ${redis_install_dir}
  [ -e "/etc/init.d/redis-server" ] && echo /etc/init.d/redis-server
  [ -e "/lib/systemd/system/redis-server.service" ] && echo /lib/systemd/system/redis-server.service
}

Uninstall_Redis_server() {
  [ -e "${redis_install_dir}" ] && { service redis-server stop > /dev/null 2>&1; rm -rf ${redis_install_dir} /etc/init.d/redis-server /usr/local/bin/redis-*; echo "${CMSG}Redis uninstall completed! ${CEND}"; }
  [ -e "/lib/systemd/system/redis-server.service" ] && { systemctl disable redis-server > /dev/null 2>&1; rm -f /lib/systemd/system/redis-server.service; }
  Uninstall_RedisDesktop;
}

Print_Memcached_server() {
  [ -e "${memcached_install_dir}" ] && echo ${memcached_install_dir}
  [ -e "/etc/init.d/memcached" ] && echo /etc/init.d/memcached
  [ -e "/usr/bin/memcached" ] && echo /usr/bin/memcached
}

Uninstall_Memcached_server() {
  [ -e "${memcached_install_dir}" ] && { service memcached stop > /dev/null 2>&1; rm -rf ${memcached_install_dir} /lib/systemd/system/memcached.service /etc/init.d/memcached /usr/bin/memcached; echo "${CMSG}Memcached uninstall completed! ${CEND}"; }
  Uninstall_MemcachedDesktop;
}

Print_FFmpeg() {
  [ -e "/usr/bin/ffmpeg" ] && ffmpeg -version
}

Print_Webp() {
  [ -e "/usr/bin/webpinfo" ] && webpinfo -version
}

Print_phpMyAdmin() {
  [ -d "${wwwroot_dir}/default/phpMyAdmin" ] && echo ${wwwroot_dir}/default/phpMyAdmin
}

Uninstall_phpMyAdmin() {
  [ -d "${wwwroot_dir}/default/phpMyAdmin" ] && rm -rf ${wwwroot_dir}/default/phpMyAdmin
}

Print_Supervisord() {
  [ -d "/usr/bin/supervisord" ] && echo /usr/bin/supervisord
}

Print_libevent() {
  [ -d "${libevent_install_dir}" ] && echo ${libevent_install_dir}
}

Print_Conda() {
  [ -d "${conda_install_dir}" ] && echo ${conda_install_dir}
}

Print_Node() {
  [ -e "${node_install_dir}" ] && echo ${node_install_dir}
  [ -e "/etc/profile.d/node.sh" ] && echo /etc/profile.d/node.sh
}

Print_Nvm() {
  [ -d "/home/${run_user}/.nvm" ] && echo "/home/${run_user}/.nvm"
}

Print_Go() {
  [ -d "${go_install_dir}${go120_ver}" ] && echo "${go_install_dir}${go120_ver}"
  [ -d "${go_install_dir}${go119_ver}" ] && echo "${go_install_dir}${go119_ver}"
  [ -d "${go_install_dir}${go118_ver}" ] && echo "${go_install_dir}${go118_ver}"
  [ -d "${go_install_dir}${go117_ver}" ] && echo "${go_install_dir}${go117_ver}"
  [ -L "${go_install_dir}" ] && echo "${go_install_dir}"
}

Print_SSH() {
  [ -e "/usr/sbin/sshd" ] && echo "/usr/sbin/sshd"
}

Print_Erlang() {
  [ -d "${erlang_install_dir}" ] && echo ${erlang_install_dir}
}

Print_Docker() {
  echo 'docker'
}

Menu() {
while :; do
  printf "
What Are You Doing?
\t${CMSG} 0${CEND}. Uninstall All
\t${CMSG} 1${CEND}. Uninstall Nginx/Tengine/OpenResty/Apache/Tomcat
\t${CMSG} 2${CEND}. Uninstall MySQL/MariaDB/Percona
\t${CMSG} 3${CEND}. Uninstall PostgreSQL
\t${CMSG} 4${CEND}. Uninstall MongoDB
\t${CMSG} 5${CEND}. Uninstall Sqlite
\t${CMSG} 6${CEND}. Uninstall ElasticsearchStack
\t${CMSG} 7${CEND}. Uninstall All Message Queue
\t${CMSG} 8${CEND}. Uninstall Kafka
\t${CMSG} 9${CEND}. Uninstall Rabbitmq
\t${CMSG} 10${CEND}. Uninstall Rocketmq
\t${CMSG} 11${CEND}. Uninstall PureFtpd
\t${CMSG} 12${CEND}. Uninstall Redis
\t${CMSG} 13${CEND}. Uninstall Memcached
\t${CMSG} 14${CEND}. Uninstall FFmpeg
\t${CMSG} 15${CEND}. Uninstall phpmyadmin
\t${CMSG} 16${CEND}. Uninstall All PHP
\t${CMSG} 17${CEND}. Uninstall PHP opcode cache
\t${CMSG} 18${CEND}. Uninstall PHP extensions
\t${CMSG} 19${CEND}. Uninstall All Service Desktop
\t${CMSG} 20${CEND}. Uninstall Nodejs (PATH: ${node_install_dir})
\t${CMSG} 21${CEND}. Uninstall Nvm
\t${CMSG} 22${CEND}. Uninstall Go
\t${CMSG} 23${CEND}. Uninstall SSH(openssh-server)
\t${CMSG} 24${CEND}. Uninstall JDK
\t${CMSG} 25${CEND}. Uninstall Supervisord
\t${CMSG} 26${CEND}. Uninstall Docker
\t${CMSG} 27${CEND}. Uninstall Conda
\t${CMSG} q${CEND}. Exit
"
  echo
  read -e -p "Please input the correct option: " Number
  if [[ ! "${Number}" =~ ^[0-9,q]$|^1[0-9]|^2[0-6]$ ]]; then
    echo "${CWARNING}input error! Please only input 0~26 and q${CEND}"
  else
    case "$Number" in
    0)
      Print_Warn
      Print_web
      Print_MySQL
      Print_PostgreSQL
      Print_MongoDB
      Print_Sqlite
      Print_ElasticStack
      Print_AllMessageQueue
      Print_ALLPHP
      Print_PureFtpd
      Print_Redis_server
      Print_Memcached_server
      Print_FFmpeg
      Print_Conda
      Print_Node
      Print_Nvm
      Print_Go
      Print_SSH
      Print_JDK
      Print_Erlang
      Print_phpMyAdmin
      Print_Supervisord
      Uninstall_status
      if [ "${uninstall_flag}" == 'y' ]; then
        Uninstall_Web
        Uninstall_MySQL
        Uninstall_PostgreSQL
        Uninstall_MongoDB
        Uninstall_Sqlite3
        Uninstall_ElasticStack
        Uninstall_Cerebro
        Uninstall_AllMessageQueue
        Uninstall_ALLPHP
        Uninstall_PureFtpd
        Uninstall_Redis_server
        Uninstall_Memcached_server
        Uninstall_FFmpeg
        Uninstall_FFmpegDesktop
        Uninstall_phpMyAdmin
        Uninstall_Conda
        Uninstall_Node
        Uninstall_Nvm
        Uninstall_Go
        Uninstall_OpensshServer
        Uninstall_JDK
        Uninstall_Erlang
        Uninstall_Supervisor
        Uninstall_alldesktop
        Uninstall_Docker_Desktop
        Uninstall_Docker_Engine
        Uninstall_Docker_Repository
      else
        exit
      fi
      ;;
    1)
      Print_Warn
      Print_web
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Web || exit
      ;;
    2)
      Print_Warn
      Print_MySQL
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_MySQL || exit
      ;;
    3)
      Print_Warn
      Print_PostgreSQL
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_PostgreSQL || exit
      ;;
    4)
      Print_Warn
      Print_MongoDB
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_MongoDB || exit
      ;;
    5)
      Print_Warn
      Print_Sqlite
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Sqlite3 || exit
      ;;
    6)
      Print_Warn
      Print_ElasticStack
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_ElasticStack;Uninstall_ElasticStackDesktop || exit
      ;;
    7)
      Print_Warn
      Print_AllMessageQueue
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_AllMessageQueue || exit
      ;;
    8)
      Print_Warn
      Print_Kafka
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Kafka;Uninstall_KafkaDesktop || exit
      ;;
    9)
      Print_Warn
      Print_Rabbitmq
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_RabbitMQ;Uninstall_RabbitmqDesktop || exit
      ;;
    10)
      Print_Warn
      Print_Rocketmq
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_RocketMQ || exit
      ;;
    11)
      Print_PureFtpd
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_PureFtpd;Uninstall_PureFtpDesktop || exit
      ;;
    12)
      Print_Redis_server
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Redis_server;Uninstall_RedisDesktop || exit
      ;;
    13)
      Print_Memcached_server
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Memcached_server;Uninstall_MemcachedDesktop || exit
      ;;
    14)
      Print_FFmpeg
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_FFmpeg;Uninstall_FFmpegDesktop || exit
      ;;
    15)
      Print_phpMyAdmin
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_phpMyAdmin || exit
      ;;
    16)
      Print_ALLPHP
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_ALLPHP || exit
      ;;
    17)
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_PHPcache || exit
      ;;
    18)
      Menu_PHPext
      [ "${phpext_option}" != '0' ] && Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_PHPext || exit
      ;;
    19)
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_alldesktop || exit
      ;;
    20)
      Print_Node
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Node || exit
      ;;
    21)
      Print_Nvm
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Nvm || exit
      ;;
    22)
      Print_Go
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Go || exit
      ;;
    23)
      Print_SSH
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_OpensshServer || exit
      ;;
    24)
      Print_JDK
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_JDK || exit
      ;;
    25)
      Print_Supervisord
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Supervisor;Uninstall_SupervisorDesktop || exit
      ;;
    26)
      Print_Docker
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Docker_Desktop;Uninstall_Docker_Engine;Uninstall_Docker_Repository || exit
      ;;
    27)
      Print_Conda
      Uninstall_status
      [ "${uninstall_flag}" == 'y' ] && Uninstall_Conda || exit
      ;;
    q)
      exit
      ;;
    esac
  fi
done
}

if [ ${ARG_NUM} == 0 ]; then
  Menu
else
  Uninstall_status

  if [ "${uninstall_flag}" == 'y' ]; then
    [ "${all_flag}" == 'y' ] && Uninstall_alldesktop
    [ "${web_flag}" == 'y' ] && Uninstall_Web
    [ "${mysql_flag}" == 'y' ] && Uninstall_MySQL
    [ "${postgresql_flag}" == 'y' ] && Uninstall_PostgreSQL
    [ "${mongodb_flag}" == 'y' ] && Uninstall_MongoDB
    [ "${sqlite_flag}" == 'y' ] && Uninstall_Sqlite3
    [ "${redis_flag}" == 'y' ] && Uninstall_Redis_server
    [ "${memcached_flag}" == 'y' ] && Uninstall_Memcached_server
    [ "${elastic_stack_flag}" == 'y' ] && Uninstall_ElasticStack;Uninstall_ElasticStackDesktop
    [ "${allmq_flag}" == 'y' ] && Uninstall_AllMessageQueue

    if [ "${allphp_flag}" == 'y' ]; then
      Uninstall_ALLPHP
    else
      [ "${mphp_flag}" == 'y' ] && [ "${phpcache_flag}" != 'y' ] && [ -z "${php_extensions}" ] && Uninstall_MPHP
      [ "${mphp_flag}" == 'y' ] && [ "${phpcache_flag}" == 'y' ] && { php_install_dir=${php_install_dir}${mphp_ver}; Uninstall_PHPcache; }
      [ "${mphp_flag}" == 'y' ] && [ -n "${php_extensions}" ] && { php_install_dir=${php_install_dir}${mphp_ver}; Uninstall_PHPext; }
      [ "${phpcache_flag}" == 'y' ] && Uninstall_PHPcache
      [ -n "${php_extensions}" ] && Uninstall_PHPext
    fi

    [ "${pureftpd_flag}" == 'y' ] && Uninstall_PureFtpd
    [ "${supervisord_flag}" == 'y' ] && Uninstall_Supervisor
    [ "${ffmpeg_flag}" == 'y' ] && Uninstall_FFmpeg;Uninstall_FFmpegDesktop
    [ "${nodejs_env_flag}" == 'y' ] && Uninstall_Node;Uninstall_Nvm
    [ "${python_env_flag}" == 'y' ] && Uninstall_Conda
    [ "${go_env_flag}" == 'y' ] && Uninstall_Go
        
    if [ "${docker_flag}" == 'y' ]; then
      Uninstall_Docker_Desktop
      Uninstall_Docker_Engine
      Uninstall_Docker_Repository
    fi
  fi
fi

if [ ${ARG_NUM} == 0 ]; then
  while :; do echo
    echo "${CMSG}Please restart the server and see if the services start up fine.${CEND}"
    read -e -p "Do you want to restart OS ? [y/n]: " reboot_flag
    if [[ ! "${reboot_flag}" =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      break
    fi
  done
fi

[ "${reboot_flag}" == 'y' ] && reboot