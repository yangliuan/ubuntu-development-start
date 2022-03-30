#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                  install language develop environment      
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

dbrootpwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
dbpostgrespwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
dbmongopwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
dbinstallmethod=1
ARG_NUM=$#

# Use default SSH port 22. If you use another SSH port on your server
if [ -e "/etc/ssh/sshd_config" ]; then
  [ -z "`grep ^Port /etc/ssh/sshd_config`" ] && now_ssh_port=22 || now_ssh_port=`grep ^Port /etc/ssh/sshd_config | awk '{print $2}' | head -1`
  while :; do echo
    [ ${ARG_NUM} == 0 ] && read -e -p "Please input SSH port(Default: ${now_ssh_port}): " ssh_port
    ssh_port=${ssh_port:-${now_ssh_port}}
    if [ ${ssh_port} -eq 22 >/dev/null 2>&1 -o ${ssh_port} -gt 1024 >/dev/null 2>&1 -a ${ssh_port} -lt 65535 >/dev/null 2>&1 ]; then
      break
    else
      echo "${CWARNING}input error! Input range: 22,1025~65534${CEND}"
      exit 1
    fi
  done

  if [ -z "`grep ^Port /etc/ssh/sshd_config`" -a "${ssh_port}" != '22' ]; then
    sed -i "s@^#Port.*@&\nPort ${ssh_port}@" /etc/ssh/sshd_config
  elif [ -n "`grep ^Port /etc/ssh/sshd_config`" ]; then
    sed -i "s@^Port.*@Port ${ssh_port}@" /etc/ssh/sshd_config
  fi
fi

if [ ${ARG_NUM} == 0 ]; then
  if [ ! -e ~/.oneinstack ]; then
    # check iptables
    while :; do echo
      read -e -p "Do you want to enable iptables? [y/n]: " iptables_flag
      if [[ ! ${iptables_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
        break
      fi
    done
  fi

  # check Web server
  while :; do echo
    read -e -p "Do you want to install Web server? [y/n]: " web_flag
    if [[ ! ${web_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      if [ "${web_flag}" == 'y' ]; then
        # Nginx/Tegine/OpenResty
        while :; do echo
          echo 'Please select Nginx server:'
          echo -e "\t${CMSG}1${CEND}. Install Nginx"
          echo -e "\t${CMSG}2${CEND}. Install Tengine"
          echo -e "\t${CMSG}3${CEND}. Install OpenResty"
          echo -e "\t${CMSG}4${CEND}. Do not install"
          read -e -p "Please input a number:(Default 1 press Enter) " nginx_option
          nginx_option=${nginx_option:-1}
          if [[ ! ${nginx_option} =~ ^[1-4]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~4${CEND}"
          else
            [ "${nginx_option}" = '1' -a -e "${nginx_install_dir}/sbin/nginx" ] && { echo "${CWARNING}Nginx${nginx_option} already installed! ${CEND}"; unset nginx_option; }
            [ "${nginx_option}" = '2' -a -e "${tengine_install_dir}/sbin/nginx" ] && { echo "${CWARNING}Tengine${nginx_option} already installed! ${CEND}"; unset nginx_option; }
            [ "${nginx_option}" = '3' -a -e "${openresty_install_dir}/nginx/sbin/nginx" ] && { echo "${CWARNING}OpenResty${nginx_option} already installed! ${CEND}"; unset nginx_option; }
            break
          fi
        done

        # Apache
        while :; do echo
          read -e -p "Do you want to install Apache? [y/n]: " apache_flag
          if [[ ! ${apache_flag} =~ ^[y,n]$ ]]; then
            echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
          else
            [ "${apache_flag}" == 'y' -a -e "${apache_install_dir}/bin/httpd" ] && { echo "${CWARNING}Aapche already installed! ${CEND}"; unset apache_flag; }
            break
          fi
        done
        # Apache2.4 mode and Apache2.4 MPM
        if [ "${apache_flag}" == 'y' -o -e "${apache_install_dir}/bin/httpd" ]; then
          while :; do echo
            echo 'Please select Apache mode:'
            echo -e "\t${CMSG}1${CEND}. php-fpm"
            echo -e "\t${CMSG}2${CEND}. mod_php"
            read -e -p "Please input a number:(Default 1 press Enter) " apache_mode_option
            apache_mode_option=${apache_mode_option:-1}
            if [[ ! ${apache_mode_option} =~ ^[1-2]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~2${CEND}"
            else
              break
            fi
          done
          while :; do echo
            echo 'Please select Apache MPM:'
            echo -e "\t${CMSG}1${CEND}. event"
            echo -e "\t${CMSG}2${CEND}. prefork"
            echo -e "\t${CMSG}3${CEND}. worker"
            read -e -p "Please input a number:(Default 1 press Enter) " apache_mpm_option
            apache_mpm_option=${apache_mpm_option:-1}
            if [[ ! ${apache_mpm_option} =~ ^[1-3]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~3${CEND}"
            else
              break
            fi
          done
        fi
        # Tomcat
        while :; do echo
          echo 'Please select tomcat server:'
          echo -e "\t${CMSG}1${CEND}. Install Tomcat-10"
          echo -e "\t${CMSG}2${CEND}. Install Tomcat-9"
          echo -e "\t${CMSG}3${CEND}. Install Tomcat-8"
          echo -e "\t${CMSG}4${CEND}. Install Tomcat-7"
          echo -e "\t${CMSG}5${CEND}. Do not install"
          read -e -p "Please input a number:(Default 5 press Enter) " tomcat_option
          tomcat_option=${tomcat_option:-5}
          if [[ ! ${tomcat_option} =~ ^[1-5]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~5${CEND}"
          else
            [ "${tomcat_option}" != '5' -a -e "$tomcat_install_dir/conf/server.xml" ] && { echo "${CWARNING}Tomcat already installed! ${CEND}" ; unset tomcat_option; }
            if [[ "${tomcat_option}" =~ ^[1-2]$ ]]; then
              while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}1${CEND}. Install JDK-11.0"
                echo -e "\t${CMSG}2${CEND}. Install JDK-1.8"
                read -e -p "Please input a number:(Default 1 press Enter) " jdk_option
                jdk_option=${jdk_option:-1}
                if [[ ! ${jdk_option} =~ ^[1-2]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                else
                  break
                fi
              done
            elif [ "${tomcat_option}" == '3' ]; then
              while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}1${CEND}. Install JDK-11.0"
                echo -e "\t${CMSG}2${CEND}. Install JDK-1.8"
                echo -e "\t${CMSG}3${CEND}. Install JDK-1.7"
                read -e -p "Please input a number:(Default 2 press Enter) " jdk_option
                jdk_option=${jdk_option:-2}
                if [[ ! ${jdk_option} =~ ^[1-3]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1~3${CEND}"
                else
                  break
                fi
              done
            elif [ "${tomcat_option}" == '4' ]; then
              while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}2${CEND}. Install JDK-1.8"
                echo -e "\t${CMSG}3${CEND}. Install JDK-1.7"
                echo -e "\t${CMSG}4${CEND}. Install JDK-1.6"
                read -e -p "Please input a number:(Default 3 press Enter) " jdk_option
                jdk_option=${jdk_option:-3}
                if [[ ! ${jdk_option} =~ ^[2-4]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 2~4${CEND}"
                else
                  break
                fi
              done
            fi
            break
          fi
        done
      fi
      break
    fi
  done

  # choice database
  while :; do echo
    read -e -p "Do you want to install Database? [y/n]: " db_flag
    if [[ ! ${db_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      if [ "${db_flag}" == 'y' ]; then
        while :; do echo
          echo 'Please select a version of the Database:'
          echo -e "\t${CMSG} 1${CEND}. Install MySQL-8.0"
          echo -e "\t${CMSG} 2${CEND}. Install MySQL-5.7"
          echo -e "\t${CMSG} 3${CEND}. Install MySQL-5.6"
          echo -e "\t${CMSG} 4${CEND}. Install MySQL-5.5"
          echo -e "\t${CMSG} 5${CEND}. Install MariaDB-10.6"
          echo -e "\t${CMSG} 6${CEND}. Install MariaDB-10.5"
          echo -e "\t${CMSG} 7${CEND}. Install MariaDB-10.4"
          echo -e "\t${CMSG} 8${CEND}. Install MariaDB-5.5"
          echo -e "\t${CMSG} 9${CEND}. Install Percona-8.0"
          echo -e "\t${CMSG}10${CEND}. Install Percona-5.7"
          echo -e "\t${CMSG}11${CEND}. Install Percona-5.6"
          echo -e "\t${CMSG}12${CEND}. Install Percona-5.5"
          echo -e "\t${CMSG}13${CEND}. Install PostgreSQL"
          echo -e "\t${CMSG}14${CEND}. Install MongoDB"
          read -e -p "Please input a number:(Default 2 press Enter) " db_option
          db_option=${db_option:-2}
          [[ "${db_option}" =~ ^9$|^14$ ]] && [ "${OS_BIT}" == '32' ] && { echo "${CWARNING}By not supporting 32-bit! ${CEND}"; continue; }
          if [[ "${db_option}" =~ ^[1-9]$|^1[0-4]$ ]]; then
            if [ "${db_option}" == '13' ]; then
              [ -e "${pgsql_install_dir}/bin/psql" ] && { echo "${CWARNING}PostgreSQL already installed! ${CEND}"; unset db_option; break; }
            elif [ "${db_option}" == '14' ]; then
              [ -e "${mongo_install_dir}/bin/mongo" ] && { echo "${CWARNING}MongoDB already installed! ${CEND}"; unset db_option; break; }
            else
              [ -d "${db_install_dir}/support-files" ] && { echo "${CWARNING}MySQL already installed! ${CEND}"; unset db_option; break; }
            fi
            while :; do
              if [ "${db_option}" == '13' ]; then
                read -e -p "Please input the postgres password of PostgreSQL(default: ${dbpostgrespwd}): " dbpwd
                dbpwd=${dbpwd:-${dbpostgrespwd}}
              elif [ "${db_option}" == '14' ]; then
                read -e -p "Please input the root password of MongoDB(default: ${dbmongopwd}): " dbpwd
                dbpwd=${dbpwd:-${dbmongopwd}}
              else
                read -e -p "Please input the root password of MySQL(default: ${dbrootpwd}): " dbpwd
                dbpwd=${dbpwd:-${dbrootpwd}}
              fi
              [ -n "`echo ${dbpwd} | grep '[+|&]'`" ] && { echo "${CWARNING}input error,not contain a plus sign (+) and & ${CEND}"; continue; }
              if (( ${#dbpwd} >= 5 )); then
                if [ "${db_option}" == '13' ]; then
                  dbpostgrespwd=${dbpwd}
                elif [ "${db_option}" == '14' ]; then
                  dbmongopwd=${dbpwd}
                else
                  dbrootpwd=${dbpwd}
                fi
                break
              else
                echo "${CWARNING}password least 5 characters! ${CEND}"
              fi
            done
            # choose install methods
            if [[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]]; then
              while :; do echo
                echo "Please choose installation of the database:"
                echo -e "\t${CMSG}1${CEND}. Install database from binary package."
                echo -e "\t${CMSG}2${CEND}. Install database from source package."
                read -e -p "Please input a number:(Default 1 press Enter) " dbinstallmethod
                dbinstallmethod=${dbinstallmethod:-1}
                if [[ ! ${dbinstallmethod} =~ ^[1-2]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                else
                  break
                fi
              done
            fi
            break
          else
            echo "${CWARNING}input error! Please only input number 1~14${CEND}"
          fi
        done
      fi
      break
    fi
  done

  # check elasticsearch
  while :; do echo
    read -e -p "Do you want to install elasticsearch stack? [y/n]: " elasticsearch_flag
    elasticsearch_flag=${elasticsearch_flag:-y}
    if [[ ! ${elasticsearch_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${elasticsearch_flag}" == 'y' -a -e "/usr/share/elasticsearch/bin/elasticsearch" ] && { echo "${CWARNING}elasticsearch already installed! ${CEND}"; unset elasticsearch_flag; }
        break
    fi
  done

  # check Pureftpd
  while :; do echo
    read -e -p "Do you want to install Pure-FTPd? [y/n]: " pureftpd_flag
    if [[ ! ${pureftpd_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      [ "${pureftpd_flag}" == 'y' -a -e "${pureftpd_install_dir}/sbin/pure-ftpwho" ] && { echo "${CWARNING}Pure-FTPd already installed! ${CEND}"; unset pureftpd_flag; }
      break
    fi
  done

  # check phpMyAdmin
  if [[ ${php_option} =~ ^[1-9]$|^1[0-1]$ ]] || [ -e "${php_install_dir}/bin/phpize" ]; then
    while :; do echo
      read -e -p "Do you want to install phpMyAdmin? [y/n]: " phpmyadmin_flag
      if [[ ! ${phpmyadmin_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
        [ "${phpmyadmin_flag}" == 'y' -a -d "${wwwroot_dir}/default/phpMyAdmin" ] && { echo "${CWARNING}phpMyAdmin already installed! ${CEND}"; unset phpmyadmin_flag; }
        break
      fi
    done
  fi

  # check redis
  while :; do echo
    read -e -p "Do you want to install redis-server? [y/n]: " redis_flag
    if [[ ! ${redis_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      [ "${redis_flag}" == 'y' -a -e "${redis_install_dir}/bin/redis-server" ] && { echo "${CWARNING}redis-server already installed! ${CEND}"; unset redis_flag; }
      break
    fi
  done

  # check memcached
  while :; do echo
    read -e -p "Do you want to install memcached-server? [y/n]: " memcached_flag
    if [[ ! ${memcached_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      [ "${memcached_flag}" == 'y' -a -e "${memcached_install_dir}/bin/memcached" ] && { echo "${CWARNING}memcached-server already installed! ${CEND}"; unset memcached_flag; }
      break
    fi
  done

  # check message queue
  while :; do echo
    read -e -p "Do you want to install message queue? [y/n]: " message_queue_flag
    if [[ ! ${message_queue_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      if [ "${message_queue_flag}" == 'y' ]; then
        while :; do echo
          echo 'Please select message queue:'
          echo -e "\t${CMSG}1${CEND}. Install Kafka"
          echo -e "\t${CMSG}2${CEND}. Install Rabbitmq"
          echo -e "\t${CMSG}3${CEND}. Install Rocketmq"
          echo -e "\t${CMSG}4${CEND}. Do not install"
          read -e -p "Please input a number:(Default 1 press Enter) " message_queue_option
          message_queue_option=${message_queue_option:-1}
          if [[ ! ${message_queue_option} =~ ^[1-4]$ ]]; then
            echo "${CWARNING}input error! Please only input number 1~4${CEND}"
          else
             [ "${message_queue_option}" = '1' -a -e "${kafka_install_dir}" ] && { echo "${CWARNING}Kafka${message_queue_option} already installed! ${CEND}"; unset message_queue_option; }
            [ "${message_queue_option}" = '2' -a -e "${rabbitmq_install_dir}" ] && { echo "${CWARNING}Rabbitmq${message_queue_option} already installed! ${CEND}"; unset message_queue_option; }
            [ "${message_queue_option}" = '3' -a -e "${rocketmq_install_dir}" ] && { echo "${CWARNING}Rocketmq${message_queue_option} already installed! ${CEND}"; unset message_queue_option; }
            break
          fi
        done
      fi
      break
    fi
  done

  # check ffmpeg
  while :; do echo
    read -e -p "Do you want to install ffmpeg? [y/n]: " ffmpeg_flag
    ffmpeg_flag=${ffmpeg_flag:-y}
    if [[ ! ${ffmpeg_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${ffmpeg_flag}" == 'y' -a -e "/usr/bin/ffmpeg" ] && { echo "${CWARNING}ffmpeg already installed! ${CEND}"; unset ffmpeg_flag; }
        break
    fi
  done
fi

if [[ ${nginx_option} =~ ^[1-3]$ ]] || [ "${apache_flag}" == 'y' ] || [[ ${tomcat_option} =~ ^[1-4]$ ]]; then
  [ ! -d ${wwwroot_dir}/default ] && mkdir -p ${wwwroot_dir}/default
  [ ! -d ${wwwlogs_dir} ] && mkdir -p ${wwwlogs_dir}
fi
[ -d /data ] && chmod 755 /data

# install wget gcc curl python
if [ ! -e ~/.oneinstack ]; then
  downloadDepsSrc=1
  [ "${PM}" == 'apt-get' ] && apt-get -y update > /dev/null
  [ "${PM}" == 'yum' ] && yum clean all
  ${PM} -y install wget gcc curl python
  [ "${RHEL_ver}" == '8' ] && { yum -y install python36; sudo alternatives --set python /usr/bin/python3; }
  clear
fi

# get the IP information
IPADDR=$(./include/get_ipaddr.py)
PUBLIC_IPADDR=$(./include/get_public_ipaddr.py)
IPADDR_COUNTRY=$(./include/get_ipaddr_state.py ${PUBLIC_IPADDR})

#clear latest install.log
echo > ${oneinstack_dir}/install.log

# Check download source packages
. ./include/check_download.sh
[ "${armplatform}" == "y" ] && dbinstallmethod=2
checkDownload 2>&1 | tee -a ${oneinstack_dir}/install.log

# del openssl for jcloud
[ -e "/usr/local/bin/openssl" ] && rm -rf /usr/local/bin/openssl
[ -e "/usr/local/include/openssl" ] && rm -rf /usr/local/include/openssl

# get OS Memory
. ./include/memory.sh

if [ ! -e ~/.oneinstack ]; then
  # Check binary dependencies packages
  . ./include/check_sw.sh
  case "${LikeOS}" in
    "RHEL")
      installDepsRHEL 2>&1 | tee ${oneinstack_dir}/install.log
      . include/init_RHEL.sh 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    "Debian")
      installDepsDebian 2>&1 | tee ${oneinstack_dir}/install.log
      . include/init_Debian.sh 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    "Ubuntu")
      installDepsUbuntu 2>&1 | tee ${oneinstack_dir}/install.log
      . include/init_Ubuntu.sh 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
  esac
  # Install dependencies from source package
  installDepsBySrc 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# start Time
startTime=`date +%s`

# Jemalloc
if [[ ${nginx_option} =~ ^[1-3]$ ]] || [[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]]; then
  . include/jemalloc.sh
  Install_Jemalloc | tee -a ${oneinstack_dir}/install.log
fi

# openSSL
if [[ ${tomcat_option} =~ ^[1-4]$ ]] || [ "${apache_flag}" == 'y' ] || [[ ${php_option} =~ ^[1-9]$|^1[0-1]$ ]] || [[ "${mphp_ver}" =~ ^5[3-6]$|^7[0-4]$|^8[0-1]$ ]]; then
  . include/openssl.sh
  Install_openSSL | tee -a ${oneinstack_dir}/install.log
fi

# Database
case "${db_option}" in
  1)
    [ "${LikeOS}" == 'RHEL' ] && [ ${RHEL_ver} -le 6 >/dev/null 2>&1 ] && dbinstallmethod=1 && checkDownload
    . include/database/mysql-8.0.sh
    Install_MySQL80 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/database/mysql-5.7.sh
    Install_MySQL57 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/database/mysql-5.6.sh
    Install_MySQL56 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/database/mysql-5.5.sh
    Install_MySQL55 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  5)
    . include/database/mariadb-10.6.sh
    Install_MariaDB106 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  6)
    . include/database/mariadb-10.5.sh
    Install_MariaDB105 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  7)
    . include/database/mariadb-10.4.sh
    Install_MariaDB104 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  8)
    . include/database/mariadb-5.5.sh
    Install_MariaDB55 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  9)
    [ "${LikeOS}" == 'RHEL' ] && [ ${RHEL_ver} -le 6 >/dev/null 2>&1 ] && dbinstallmethod=1 && checkDownload
    [ "${LikeOS}" == 'RHEL' ] && [ "${RHEL_ver}" == '8' ] && dbinstallmethod=2 && checkDownload
    . include/database/percona-8.0.sh
    Install_Percona80 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  10)
    . include/database/percona-5.7.sh
    Install_Percona57 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  11)
    . include/database/percona-5.6.sh
    Install_Percona56 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  12)
    . include/database/percona-5.5.sh
    Install_Percona55 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  13)
    . include/database/postgresql.sh
    Install_PostgreSQL 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  14)
    . include/database/mongodb.sh
    Install_MongoDB 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# Elasticsearch
if [ "${elasticsearch_flag}" == 'y' ]; then  
  . include/fulltext-search/elasticsearch_stack.sh
  Install_Elasticsearch 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_Cerebro 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# Nginx server
case "${nginx_option}" in
  1)
    . include/webserver/nginx.sh
    Install_Nginx 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/webserver/tengine.sh
    Install_Tengine 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/webserver/openresty.sh
    Install_OpenResty 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# Apache
if [ "${apache_flag}" == 'y' ]; then
  apache_mode_option=${apache_mode_option:-1}
  apache_mpm_option=${apache_mpm_option:-1}
  . include/webserver/apache.sh
  Install_Apache 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# ffmpeg
if [ "${ffmpeg_flag}" == 'y' ]; then  
    . include/multimedia/ffmpeg.sh
    Install_FFmpeg 2>&1 | tee -a ${oneinstack_dir}/install.log
fi


endTime=`date +%s`
((installTime=($endTime-$startTime)/60))
echo "####################Congratulations########################"
echo "Total OneinStack Install Time: ${CQUESTION}${installTime}${CEND} minutes"
[[ "${nginx_option}" =~ ^[1-3]$ ]] && echo -e "\n$(printf "%-32s" "Nginx install dir":)${CMSG}${web_install_dir}${CEND}"
[ "${apache_flag}" == 'y' ] && echo -e "\n$(printf "%-32s" "Apache install dir":)${CMSG}${apache_install_dir}${CEND}"
[[ "${tomcat_option}" =~ ^[1-4]$ ]] && echo -e "\n$(printf "%-32s" "Tomcat install dir":)${CMSG}${tomcat_install_dir}${CEND}"
[[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]] && echo -e "\n$(printf "%-32s" "Database install dir:")${CMSG}${db_install_dir}${CEND}"
[[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]] && echo "$(printf "%-32s" "Database data dir:")${CMSG}${db_data_dir}${CEND}"
[[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]] && echo "$(printf "%-32s" "Database user:")${CMSG}root${CEND}"
[[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]] && echo "$(printf "%-32s" "Database password:")${CMSG}${dbrootpwd}${CEND}"
[ "${db_option}" == '13' ] && echo -e "\n$(printf "%-32s" "PostgreSQL install dir:")${CMSG}${pgsql_install_dir}${CEND}"
[ "${db_option}" == '13' ] && echo "$(printf "%-32s" "PostgreSQL data dir:")${CMSG}${pgsql_data_dir}${CEND}"
[ "${db_option}" == '13' ] && echo "$(printf "%-32s" "PostgreSQL user:")${CMSG}postgres${CEND}"
[ "${db_option}" == '13' ] && echo "$(printf "%-32s" "postgres password:")${CMSG}${dbpostgrespwd}${CEND}"
[ "${db_option}" == '14' ] && echo -e "\n$(printf "%-32s" "MongoDB install dir:")${CMSG}${mongo_install_dir}${CEND}"
[ "${db_option}" == '14' ] && echo "$(printf "%-32s" "MongoDB data dir:")${CMSG}${mongo_data_dir}${CEND}"
[ "${db_option}" == '14' ] && echo "$(printf "%-32s" "MongoDB user:")${CMSG}root${CEND}"
[ "${db_option}" == '14' ] && echo "$(printf "%-32s" "MongoDB password:")${CMSG}${dbmongopwd}${CEND}"
[ "${pureftpd_flag}" == 'y' ] && echo -e "\n$(printf "%-32s" "Pure-FTPd install dir:")${CMSG}${pureftpd_install_dir}${CEND}"
[ "${pureftpd_flag}" == 'y' ] && echo "$(printf "%-32s" "Create FTP virtual script:")${CMSG}./pureftpd_vhost.sh${CEND}"
[ "${phpmyadmin_flag}" == 'y' ] && echo -e "\n$(printf "%-32s" "phpMyAdmin dir:")${CMSG}${wwwroot_dir}/default/phpMyAdmin${CEND}"
[ "${phpmyadmin_flag}" == 'y' ] && echo "$(printf "%-32s" "phpMyAdmin Control Panel URL:")${CMSG}http://${IPADDR}/phpMyAdmin${CEND}"
[ "${redis_flag}" == 'y' ] && echo -e "\n$(printf "%-32s" "redis install dir:")${CMSG}${redis_install_dir}${CEND}"
[ "${memcached_flag}" == 'y' ] && echo -e "\n$(printf "%-32s" "memcached install dir:")${CMSG}${memcached_install_dir}${CEND}"
