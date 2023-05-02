#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                  install base develop environment      
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
. ./include/base_desktop.sh
. ./include/develop-tools/develop_config.sh

dbrootpwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
dbpostgrespwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
dbmongopwd=`< /dev/urandom tr -dc A-Za-z0-9 | head -c8`
dbinstallmethod=1

version() {
  echo "version: 1.0"
  echo "updated date: 2022-07-11"
}

Show_Help() {
  version
  echo "Usage: $0  command ...[parameters]....
  --help, -h                  Show this help message, More: https://oneinstack.com/auto
  --version, -v               Show version info
  --nginx_option [1-3]        Install Nginx server version
  --apache                    Install Apache
  --apache_mode_option [1-2]  Apache2.4 mode, 1(default): php-fpm, 2: mod_php
  --apache_mpm_option [1-3]   Apache2.4 MPM, 1(default): event, 2: prefork, 3: worker
  --php_option [1-12]         Install PHP version
  --mphp_ver [53~81]          Install another PHP version (PATH: ${php_install_dir}\${mphp_ver})
  --mphp_addons               Only install another PHP addons
  --phpcache_option [1-4]     Install PHP opcode cache, default: 1 opcache
  --php_extensions [ext name] Install PHP extensions, include zendguardloader,ioncube,
                              sourceguardian,imagick,gmagick,fileinfo,imap,ldap,calendar,phalcon,
                              yaf,yar,redis,memcached,memcache,mongodb,swoole,event,xdebug,yasd
  --nodejs                    Install Nodejs
  --nvm                       Install nvm
  --tomcat_option [1-4]       Install Tomcat version
  --jdk_option [1-2]          Install JDK version
  --db_option [1-14]          Install DB version
  --dbinstallmethod [1-2]     DB install method, default: 1 binary install
  --dbrootpwd [password]      DB super password
  --pureftpd                  Install Pure-Ftpd
  --redis                     Install Redis
  --memcached                 Install Memcached
  --phpmyadmin                Install phpMyAdmin
  --python                    Install Python (PATH: ${python_install_dir})
  --go                        install go lasted
  --ssh_port [No.]            SSH port
  --firewall                  Enable firewall
  --reboot                    Restart the server after installation
  "
}

ARG_NUM=$#
TEMP=`getopt -o hvV --long help,version,nginx_option:,apache,apache_mode_option:,apache_mpm_option:,php_option:,mphp_ver:,mphp_addons,phpcache_option:,php_extensions:,nodejs,nvm,tomcat_option:,jdk_option:,db_option:,dbrootpwd:,dbinstallmethod:,pureftpd,redis,memcached,phpmyadmin,python,go,ssh_port:,firewall,reboot -- "$@" 2>/dev/null`
[ $? != 0 ] && echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
eval set -- "${TEMP}"
while :; do
  [ -z "$1" ] && break;
  case "$1" in
    -h|--help)
      Show_Help; exit 0
      ;;
    -v|-V|--version)
      version; exit 0
      ;;
    --nginx_option)
      nginx_option=$2; shift 2
      [[ ! ${nginx_option} =~ ^[1-3]$ ]] && { echo "${CWARNING}nginx_option input error! Please only input number 1~3${CEND}"; exit 1; }
      [ "${nginx_option}" = '1' -a -e "${nginx_install_dir}/sbin/nginx" ] && { echo "${CWARNING}Nginx already installed! ${CEND}"; unset nginx_option; }
      [ "${nginx_option}" = '2' -a -e "${tengine_install_dir}/sbin/nginx" ] && { echo "${CWARNING}Tengine already installed! ${CEND}"; unset nginx_option; }
      [ "${nginx_option}" = '3' -a -e "${openresty_install_dir}/nginx/sbin/nginx" ] && { echo "${CWARNING}OpenResty already installed! ${CEND}"; unset nginx_option; }
      ;;
    --apache)
      apache_flag=y; shift 1
      [ -e "${apache_install_dir}/bin/httpd" ] && { echo "${CWARNING}Aapche already installed! ${CEND}"; unset apache_flag; }
      ;;
    --apache_mode_option)
      apache_mode_option=$2; shift 2
      [[ ! ${apache_mode_option} =~ ^[1-2]$ ]] && { echo "${CWARNING}apache_mode_option input error! Please only input number 1~2${CEND}"; exit 1; }
      ;;
    --apache_mpm_option)
      apache_mpm_option=$2; shift 2
      [[ ! ${apache_mpm_option} =~ ^[1-3]$ ]] && { echo "${CWARNING}apache_mpm_option input error! Please only input number 1~3${CEND}"; exit 1; }
      ;;
    --php_option)
      php_option=$2; shift 2
      [[ ! ${php_option} =~ ^[1-9]$|^1[0-2]$ ]] && { echo "${CWARNING}php_option input error! Please only input number 1~12${CEND}"; exit 1; }
      php_suffix=([1]=53 [2]=54 [3]=55 [4]=56 [5]=70 [6]=71 [7]=72 [8]=73 [9]=74 [10]=80 [11]=81 [12]=82)
      php_install_dir="${php_install_dir}${php_suffix[$php_option]}"
      [ -e "${php_install_dir}/bin/phpize" ] && { echo "${CWARNING}PHP already installed! ${CEND}"; unset php_option; }
      ;;
    --mphp_ver)
      mphp_ver=$2; mphp_flag=y; shift 2
      [[ ! "${mphp_ver}" =~ ^5[3-6]$|^7[0-4]$|^8[0-1]$ ]] && { echo "${CWARNING}mphp_ver input error! Please only input number 53~81${CEND}"; exit 1; }
      ;;
    --mphp_addons)
      mphp_addons_flag=y; shift 1
      ;;
    --phpcache_option)
      phpcache_option=$2; shift 2
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
      [ -n "`echo ${php_extensions} | grep -w event`" ] && pecl_event=1
      [ -n "`echo ${php_extensions} | grep -w xdebug`" ] && pecl_xdebug=1
      [ -n "`echo ${php_extensions} | grep -w yasd`" ] && pecl_yasd=1
      [ -n "`echo ${php_extensions} | grep -w parallel`" ] && pecl_parallel=1
      ;;
    --nodejs)
      nodejs_method=1; shift 1
      [ -e "${nodejs_install_dir}/bin/node" ] && { echo "${CWARNING}Nodejs already installed! ${CEND}"; unset nodejs_method; }
      ;;
    --nvm)
      nodejs_method=2; shift 1
      [ -e "/home/${run_user}/.nvm" ] && { echo "${CWARNING}nvm already installed! ${CEND}"; unset nodejs_method;}
      ;;
    --tomcat_option)
      tomcat_option=$2; shift 2
      [[ ! ${tomcat_option} =~ ^[1-4]$ ]] && { echo "${CWARNING}tomcat_option input error! Please only input number 1~4${CEND}"; exit 1; }
      [ -e "$tomcat_install_dir/conf/server.xml" ] && { echo "${CWARNING}Tomcat already installed! ${CEND}" ; unset tomcat_option; }
      ;;
    --jdk_option)
      jdk_option=$2; shift 2
      [[ ! ${jdk_option} =~ ^[1-2]$ ]] && { echo "${CWARNING}jdk_option input error! Please only input number 1~2${CEND}"; exit 1; }
      ;;
    --db_option)
      db_option=$2; shift 2
      if [[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]]; then
        [ -d "${db_install_dir}/support-files" ] && { echo "${CWARNING}MySQL already installed! ${CEND}"; unset db_option; }
      elif [ "${db_option}" == '13' ]; then
        [ -e "${pgsql_install_dir}/bin/psql" ] && { echo "${CWARNING}PostgreSQL already installed! ${CEND}"; unset db_option; }
      elif [ "${db_option}" == '14' ]; then
        [ -e "${mongo_install_dir}/bin/mongo" ] && { echo "${CWARNING}MongoDB already installed! ${CEND}"; unset db_option; }
      else
        echo "${CWARNING}db_option input error! Please only input number 1~14${CEND}"
        exit 1
      fi
      ;;
    --dbrootpwd)
      dbrootpwd=$2; shift 2
      dbpostgrespwd="${dbrootpwd}"
      dbmongopwd="${dbrootpwd}"
      ;;
    --dbinstallmethod)
      dbinstallmethod=$2; shift 2
      [[ ! ${dbinstallmethod} =~ ^[1-2]$ ]] && { echo "${CWARNING}dbinstallmethod input error! Please only input number 1~2${CEND}"; exit 1; }
      ;;
    --pureftpd)
      pureftpd_flag=y; shift 1
      [ -e "${pureftpd_install_dir}/sbin/pure-ftpwho" ] && { echo "${CWARNING}Pure-FTPd already installed! ${CEND}"; unset pureftpd_flag; }
      ;;
    --redis)
      redis_flag=y; shift 1
      [ -e "${redis_install_dir}/bin/redis-server" ] && { echo "${CWARNING}redis-server already installed! ${CEND}"; unset redis_flag; }
      ;;
    --memcached)
      memcached_flag=y; shift 1
      [ -e "${memcached_install_dir}/bin/memcached" ] && { echo "${CWARNING}memcached-server already installed! ${CEND}"; unset memcached_flag; }
      ;;
    --phpmyadmin)
      phpmyadmin_flag=y; shift 1
      [ -d "${wwwroot_dir}/default/phpMyAdmin" ] && { echo "${CWARNING}phpMyAdmin already installed! ${CEND}"; unset phpmyadmin_flag; }
      ;;
    --python)
      python_flag=y; shift 1
      ;;
    --go)
      go_option=1; shift 1
      ;;
    --ssh_port)
      ssh_port=$2; shift 2
      ;;
    --firewall)
      firewall_flag=y; shift 1
      ;;
    --reboot)
      reboot_flag=y; shift 1
      ;;
    --)
      shift
      ;;
    *)
      echo "${CWARNING}ERROR: unknown argument! ${CEND}" && Show_Help && exit 1
      ;;
  esac
done

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
  # check iptables
  while :; do echo
    read -e -p "Do you want to enable firewall? [y/n](default:n): " firewall_flag
    firewall_flag=${firewall_flag:-n}
    if [[ ! ${firewall_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
      break
    fi
  done

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
            if [[ "${tomcat_option}" =~ ^[1-3]$ ]]; then
              while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}1${CEND}. Install openjdk-8-jdk"
                echo -e "\t${CMSG}2${CEND}. Install openjdk-11-jdk"
                read -e -p "Please input a number:(Default 1 press Enter) " jdk_option
                jdk_option=${jdk_option:-1}
                if [[ ! ${jdk_option} =~ ^[1-2]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                else
                  break
                fi
              done
            elif [ "${tomcat_option}" == '4' ]; then
              while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}1${CEND}. Install openjdk-8-jdk"
                read -e -p "Please input a number:(Default 1 press Enter) " jdk_option
                jdk_option=${jdk_option:-1}
                if [[ ! ${jdk_option} =~ ^1$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1${CEND}"
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

            if [[ ${message_queue_option} =~ ^[1-3]$ ]]; then
              while :; do echo
                echo 'Please select JDK version:'
                echo -e "\t${CMSG}1${CEND}. Install openjdk-8-jdk"
                echo -e "\t${CMSG}2${CEND}. Install openjdk-11-jdk"
                read -e -p "Please input a number:(Default 2 press Enter) " jdk_option
                jdk_option=${jdk_option:-1}
                if [[ ! ${jdk_option} =~ ^[1-3]$ ]]; then
                  echo "${CWARNING}input error! Please only input number 1~3${CEND}"
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

  # check supervisord
  while :; do echo
    read -e -p "Do you want to install supervisord? [y/n]: " supervisord_flag
    supervisord_flag=${supervisord_flag:-y}
    if [[ ! ${supervisord_flag} =~ ^[y,n]$ ]]; then
        echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
    else
        [ "${supervisord_flag}" == 'y' -a -e "/usr/bin/supervisord" ] && { echo "${CWARNING}supervisord already installed! ${CEND}"; unset supervisord_flag; }
        break
    fi
  done

  # choice php
  while :; do echo
  read -e -p "Do you want to install PHP? [y/n]: " php_flag
  if [[ ! ${php_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
  else
      if [ "${php_flag}" == 'y' ]; then
      while :; do echo
          echo 'Please select a version of the PHP:'
          echo -e "\t${CMSG} 1${CEND}. Install php-5.3"
          echo -e "\t${CMSG} 2${CEND}. Install php-5.4"
          echo -e "\t${CMSG} 3${CEND}. Install php-5.5"
          echo -e "\t${CMSG} 4${CEND}. Install php-5.6"
          echo -e "\t${CMSG} 5${CEND}. Install php-7.0"
          echo -e "\t${CMSG} 6${CEND}. Install php-7.1"
          echo -e "\t${CMSG} 7${CEND}. Install php-7.2"
          echo -e "\t${CMSG} 8${CEND}. Install php-7.3"
          echo -e "\t${CMSG} 9${CEND}. Install php-7.4"
          echo -e "\t${CMSG}10${CEND}. Install php-8.0"
          echo -e "\t${CMSG}11${CEND}. Install php-8.1"
          echo -e "\t${CMSG}12${CEND}. Install php-8.2"
          read -e -p "Please input a number:(Default 7 press Enter) " php_option
          php_option=${php_option:-11}
          php_suffix=([1]=53 [2]=54 [3]=55 [4]=56 [5]=70 [6]=71 [7]=72 [8]=73 [9]=74 [10]=80 [11]=81 [12]=82)
          if [[ ! ${php_option} =~ ^[1-9]$|^1[0-2]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~11${CEND}"
          else
              #环境变量路径
              php_env_dir="${php_install_dir}"
              #根据选项增加php安装目录后缀
              php_install_dir="${php_install_dir}${php_suffix[$php_option]}"
              [ -e "${php_install_dir}/bin/phpize" ] && { echo "${CWARNING}PHP already installed! ${CEND}"; unset php_option; break; }
          break
          fi
      done
      fi
      break
  fi
  done

  # check php ver
  if [ -e "${php_install_dir}/bin/phpize" ]; then
      PHP_detail_ver=$(${php_install_dir}/bin/php-config --version)
      PHP_main_ver=${PHP_detail_ver%.*}
  fi

  # PHP opcode cache and extensions
  if [[ ${php_option} =~ ^[1-9]$|^1[0-2]$ ]] || [ -e "${php_install_dir}/bin/phpize" ]; then
  while :; do echo
      read -e -p "Do you want to install opcode cache of the PHP? [y/n]: " phpcache_flag
      if [[ ! ${phpcache_flag} =~ ^[y,n]$ ]]; then
      echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
      if [ "${phpcache_flag}" == 'y' ]; then
          if [ "${php_option}" == '1' -o "${PHP_main_ver}" == '5.3' ]; then
          while :; do
              echo 'Please select a opcode cache of the PHP:'
              echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
              echo -e "\t${CMSG}2${CEND}. Install APCU"
              echo -e "\t${CMSG}3${CEND}. Install XCache"
              echo -e "\t${CMSG}4${CEND}. Install eAccelerator-0.9"
              read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
              phpcache_option=${phpcache_option:-1}
              if [[ ! ${phpcache_option} =~ ^[1-4]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~4${CEND}"
              else
              break
              fi
          done
          fi
          if [ "${php_option}" == '2' -o "${PHP_main_ver}" == '5.4' ]; then
          while :; do
              echo 'Please select a opcode cache of the PHP:'
              echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
              echo -e "\t${CMSG}2${CEND}. Install APCU"
              echo -e "\t${CMSG}3${CEND}. Install XCache"
              echo -e "\t${CMSG}4${CEND}. Install eAccelerator-1.0-dev"
              read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
              phpcache_option=${phpcache_option:-1}
              if [[ ! ${phpcache_option} =~ ^[1-4]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~4${CEND}"
              else
              break
              fi
          done
          fi
          if [ "${php_option}" == '3' -o "${PHP_main_ver}" == '5.5' ]; then
          while :; do
              echo 'Please select a opcode cache of the PHP:'
              echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
              echo -e "\t${CMSG}2${CEND}. Install APCU"
              echo -e "\t${CMSG}3${CEND}. Install XCache"
              read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
              phpcache_option=${phpcache_option:-1}
              if [[ ! ${phpcache_option} =~ ^[1-3]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~3${CEND}"
              else
              break
              fi
          done
          fi
          if [ "${php_option}" == '4' -o "${PHP_main_ver}" == '5.6' ]; then
          while :; do
              echo 'Please select a opcode cache of the PHP:'
              echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
              echo -e "\t${CMSG}2${CEND}. Install XCache"
              echo -e "\t${CMSG}3${CEND}. Install APCU"
              read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
              phpcache_option=${phpcache_option:-1}
              if [[ ! ${phpcache_option} =~ ^[1-3]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~3${CEND}"
              else
              break
              fi
          done
          fi
          if [[ ${php_option} =~ ^[5-9]$|^1[0-1]$ ]] || [[ "${PHP_main_ver}" =~ ^7.[0-4]$|^8.[0-2]$ ]]; then
          while :; do
              echo 'Please select a opcode cache of the PHP:'
              echo -e "\t${CMSG}1${CEND}. Install Zend OPcache"
              echo -e "\t${CMSG}2${CEND}. Install APCU"
              read -e -p "Please input a number:(Default 1 press Enter) " phpcache_option
              phpcache_option=${phpcache_option:-1}
              if [[ ! ${phpcache_option} =~ ^[1-2]$ ]]; then
              echo "${CWARNING}input error! Please only input number 1~2${CEND}"
              else
              break
              fi
          done
          fi
      fi
      break
      fi
  done

  # set xcache passwd
  if [ "${phpcache_option}" == '3' ]; then
      while :; do
      read -e -p "Please input xcache admin password: " xcachepwd
      (( ${#xcachepwd} >= 5 )) && { xcachepwd_md5=$(echo -n "${xcachepwd}" | md5sum | awk '{print $1}') ; break ; } || echo "${CFAILURE}xcache admin password least 5 characters! ${CEND}"
      done
  fi

  # PHP extension
  while :; do
      echo
      echo 'Please select PHP extensions:'
      echo -e "\t${CMSG} 0${CEND}. Do not install"
      echo -e "\t${CMSG} 1${CEND}. Install zendguardloader(PHP<=5.6)"
      echo -e "\t${CMSG} 2${CEND}. Install ioncube"
      echo -e "\t${CMSG} 3${CEND}. Install sourceguardian(PHP<=7.2)"
      echo -e "\t${CMSG} 4${CEND}. Install imagick"
      echo -e "\t${CMSG} 5${CEND}. Install gmagick"
      echo -e "\t${CMSG} 6${CEND}. Install fileinfo"
      echo -e "\t${CMSG} 7${CEND}. Install imap"
      echo -e "\t${CMSG} 8${CEND}. Install ldap"
      echo -e "\t${CMSG} 9${CEND}. Install phalcon(PHP>=5.5)"
      echo -e "\t${CMSG}10${CEND}. Install yaf(PHP>=7.0)"
      echo -e "\t${CMSG}11${CEND}. Install redis"
      echo -e "\t${CMSG}12${CEND}. Install memcached"
      echo -e "\t${CMSG}13${CEND}. Install memcache"
      echo -e "\t${CMSG}14${CEND}. Install mongodb"
      echo -e "\t${CMSG}15${CEND}. Install pgsql"
      echo -e "\t${CMSG}16${CEND}. Install swoole"
      echo -e "\t${CMSG}17${CEND}. Install event(PHP>=5.4)"
      echo -e "\t${CMSG}18${CEND}. Install grpc(PHP>=7.0)"
      echo -e "\t${CMSG}19${CEND}. Install xdebug(PHP>=5.5)"
      echo -e "\t${CMSG}20${CEND}. Install yasd(PHP>=7.2)"
      echo -e "\t${CMSG}21${CEND}. Install parallel(PHP>=7.2)"
      read -e -p "Please input numbers:(Default '4 6 11 16 17' press Enter) " phpext_option
      phpext_option=${phpext_option:-'4 6 11 16 17'}
      [ "${phpext_option}" == '0' ] && break
      array_phpext=(${phpext_option})
      array_all=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21)
      for v in ${array_phpext[@]}
      do
      [ -z "`echo ${array_all[@]} | grep -w ${v}`" ] && phpext_flag=1
      done
      if [ "${phpext_flag}" == '1' ]; then
      unset phpext_flag
      echo; echo "${CWARNING}input error! Please only input number 4 6 11 16 17 and so on${CEND}"; echo
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
      [ -n "`echo ${array_phpext[@]} | grep -w 17`" ] && pecl_event=1
      [ -n "`echo ${array_phpext[@]} | grep -w 18`" ] && pecl_grpc=1
      [ -n "`echo ${array_phpext[@]} | grep -w 19`" ] && pecl_xdebug=1
      [ -n "`echo ${array_phpext[@]} | grep -w 20`" ] && pecl_yasd=1
      [ -n "`echo ${array_phpext[@]} | grep -w 21`" ] && pecl_parallel=1
      break
      fi
  done
  fi

  # check Nodejs
  while :; do echo
      read -e -p "Do you want to install Nodejs? [y/n]: " nodejs_flag
      if [[ ! ${nodejs_flag} =~ ^[y,n]$ ]]; then
          echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
          # choice Nodejs install method
          if [ "${nodejs_flag}" == 'y' ]; then
              while :; do echo
                  echo 'Please select method:'
                  echo -e "\t${CMSG}1${CEND}. official install"
                  echo -e "\t${CMSG}2${CEND}. use nvm"
                  read -e -p "Please input a number:(Default 1 press Enter) " nodejs_method
                  nodejs_method=${nodejs_method:-1}
                  if [[ ! ${nodejs_method} =~ ^[1-2]$ ]]; then
                      echo "${CWARNING}input error! Please only input number 1~2${CEND}"
                  else
                    [ "${nodejs_method}" = "1" -a -e "${node_install_dir}/bin/node" ] && { echo "${CWARNING}Nodejs already installed! ${CEND}"; unset nodejs_method; break; }
                    [ "${nodejs_method}" = "2" -a -e "/home/${run_user}/.nvm" ] && { echo "${CWARNING}nvm already installed! ${CEND}"; unset nodejs_method; break; }
                    break
                  fi
              done
          fi
          break
      fi
  done


  # check go
  while :; do echo
      read -e -p "Do you want to install Go? [y/n]: " go_flag
      if [[ ! ${go_flag} =~ ^[y,n]$ ]]; then
          echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
          # choice go install method
          if [ "${go_flag}" == 'y' ]; then
              while :; do echo
                  echo 'Please select go version:'
                  echo -e "\t${CMSG}1${CEND}. 1.19"
                  echo -e "\t${CMSG}1${CEND}. 1.18"
                  echo -e "\t${CMSG}2${CEND}. 1.17"
                  read -e -p "Please input a number:(Default 1 press Enter) " go_option
                  go_option=${go_option:-1}
                  if [[ ! ${go_option} =~ ^[1-3]$ ]]; then
                      echo "${CWARNING}input error! Please only input number 1~3${CEND}"
                  else
                      break
                  fi
              done
          fi
          break
      fi
  done

  # check python
  while :; do echo
      read -e -p "Do you want to install python? [y/n]: " python_flag
      if [[ ! ${python_flag} =~ ^[y,n]$ ]]; then
          echo "${CWARNING}input error! Please only input 'y' or 'n'${CEND}"
      else
          break
      fi
  done
fi

if [ ! -e ~/.oneinstack ]; then
  # install wget gcc curl python
  downloadDepsSrc=1
  apt-get -y install wget gcc curl python
  clear
fi

# get the IP information
IPADDR=$(./include/ois.${ARCH} ip_local)
OUTIP_STATE=$(./include/ois.${ARCH} ip_state)

#clear latest install.log
echo > ${oneinstack_dir}/install.log

# Check download source packages
. ./include/check_download.sh
[ "${armplatform}" == "y" ] && dbinstallmethod=2
checkDownload 2>&1 | tee -a ${oneinstack_dir}/install.log
 
. ./include/system-lib/openssl.sh
. ./include/system-lib/libevent.sh

# get OS Memory
. ./include/memory.sh
if [ ! -e ~/.oneinstack ]; then
  # Check binary dependencies packages
  . ./include/check_sw.sh
  installDepsUbuntu 2>&1 | tee ${oneinstack_dir}/install.log
  . include/init_Ubuntu.sh 2>&1 | tee -a ${oneinstack_dir}/install.log
  # Install dependencies from source package
  installDepsBySrc 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# start Time
startTime=`date +%s`

if [[ ${php_option} =~ ^[1-9]$|^1[0-1]$ ]]; then
  . include/multimedia/libwebp.sh
  Install_Libwebp | tee -a ${oneinstack_dir}/install.log
fi

# iptables
if [ "${iptables_flag}" == "y" ]; then
  ./include/firewall/iptables.sh
  Install_Iptables 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# Jemalloc
if [[ ${nginx_option} =~ ^[1-3]$ ]] || [[ "${db_option}" =~ ^[1-9]$|^1[0-2]$ ]]; then
  . include/system-lib/jemalloc.sh
  Install_Jemalloc | tee -a ${oneinstack_dir}/install.log
fi

# Database
case "${db_option}" in
  1)
    . include/database/mysql-8.0.sh
    Install_MySQL80 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_MysqlDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/database/mysql-5.7.sh
    Install_MySQL57 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_MysqlDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/database/mysql-5.6.sh
    Install_MySQL56 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_MysqlDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/database/mysql-5.5.sh
    Install_MySQL55 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_MysqlDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
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
    Install_PostgresqlDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  14)
    . include/database/mongodb.sh
    Install_MongoDB 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_MongoDBDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# Elasticsearch
if [ "${elasticsearch_flag}" == 'y' ]; then  
  . include/fulltext-search/elasticsearch_stack.sh
  Install_Elasticsearch 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_Cerebro 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_ElasticsearchDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_Config 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# Nginx server
case "${nginx_option}" in
  1)
    . include/webserver/nginx.sh
    Install_Nginx 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_NginxDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    NginxDevConfig 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/webserver/tengine.sh
    Install_Tengine 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_NginxDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    TengineDevConfig 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/webserver/openresty.sh
    Install_OpenResty 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_OpenrestryDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    OpenRestyDevConfig 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# Apache
if [ "${apache_flag}" == 'y' ]; then
  apache_mode_option=${apache_mode_option:-1}
  apache_mpm_option=${apache_mpm_option:-1}
  . include/webserver/apache.sh
  Install_Apache 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_ApacheHttpdDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# JDK
case "${jdk_option}" in
  1)
    . include/language/java/jdk/openjdk-8.sh
    Install_OpenJDK8 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/language/java/jdk/openjdk-11.sh
    Install_OpenJDK11 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

case "${tomcat_option}" in
  1)
    . include/webserver/tomcat-10.sh
    Install_Tomcat10 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_TomcatDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/webserver/tomcat-9.sh
    Install_Tomcat9 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_TomcatDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/webserver/tomcat-8.sh
    Install_Tomcat8 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_TomcatDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/webserver/tomcat-7.sh
    Install_Tomcat7 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_TomcatDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# Pure-FTPd
if [ "${pureftpd_flag}" == 'y' ]; then
  . include/ftp/pureftpd.sh
  Install_PureFTPd 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_PureFtpDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# redis
if [ "${redis_flag}" == 'y' ]; then
  . include/database/cache/redis.sh
  Install_redis_server 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_RedisDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# memcached
if [ "${memcached_flag}" == 'y' ]; then
  . include/database/cache/memcached.sh
  Install_memcached_server 2>&1 | tee -a ${oneinstack_dir}/install.log
  Install_MemcachedDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# message queue
case "${message_queue_option}" in
  1)
    . include/message-queue/kafka.sh
    Install_Kafka 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    if [ ! -L "/usr/local/bin/erl" ]; then
      . include/language/erlang/erlang.sh
      Install_Erlang 2>&1 | tee -a ${oneinstack_dir}/install.log
    fi
    . include/message-queue/rabbitmq.sh
    Install_RabbitMQ 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/message-queue/rocketmq.sh
    Install_RocketMQ 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# ffmpeg
if [ "${ffmpeg_flag}" == 'y' ]; then  
    . include/multimedia/ffmpeg.sh
    Install_FFmpeg 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# supervisord
if [ "${supervisord_flag}" == 'y' ]; then
    . include/language/python/supervisor.sh
    Install_Supervisor 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_SupervisorDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

# PHP
case "${php_option}" in
  1)
    . include/language/php/php-5.3.sh
    Install_PHP53 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/language/php/php-5.4.sh
    Install_PHP54 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    . include/language/php/php-5.5.sh
    Install_PHP55 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  4)
    . include/language/php/php-5.6.sh
    Install_PHP56 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  5)
    . include/language/php/php-7.0.sh
    Install_PHP70 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  6)
    . include/language/php/php-7.1.sh
    Install_PHP71 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  7)
    . include/language/php/php-7.2.sh
    Install_PHP72 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  8)
    . include/language/php/php-7.3.sh
    Install_PHP73 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  9)
    . include/language/php/php-7.4.sh
    Install_PHP74 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  10)
    . include/language/php/php-8.0.sh
    Install_PHP80 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  11)
    . include/language/php/php-8.1.sh
    Install_PHP81 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  12)
    . include/language/php/php-8.2.sh
    Install_PHP82 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# PHP addons
PHP_addons() {
  # PHP opcode cache
  case "${phpcache_option}" in
    1)
      . include/language/php/extension/zendopcache.sh
      Install_ZendOPcache 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    2)
      . include/language/php/extension/apcu.sh
      Install_APCU 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    3)
      . include/language/php/extension/xcache.sh
      Install_XCache 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
    4)
      . include/language/php/extension/eaccelerator.sh
      Install_eAccelerator 2>&1 | tee -a ${oneinstack_dir}/install.log
      ;;
  esac

  # ZendGuardLoader
  if [ "${pecl_zendguardloader}" == '1' ]; then
    . include/language/php/extension/ZendGuardLoader.sh
    Install_ZendGuardLoader 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # ioncube
  if [ "${pecl_ioncube}" == '1' ]; then
    . include/language/php/extension/ioncube.sh
    Install_ionCube 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # SourceGuardian
  if [ "${pecl_sourceguardian}" == '1' ]; then
    . include/language/php/extension/sourceguardian.sh
    Install_SourceGuardian 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # imagick
  if [ "${pecl_imagick}" == '1' ]; then
    . include/multimedia/libwebp.sh
    . include/multimedia/ImageMagick.sh
    . include/language/php/extension/pecl_imagick.sh
    Install_Libwebp 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_ImageMagick 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_pecl_imagick 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # gmagick
  if [ "${pecl_gmagick}" == '1' ]; then
    . include/language/php/extension/GraphicsMagick.sh
    Install_GraphicsMagick 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_pecl_gmagick 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # fileinfo
  if [ "${pecl_fileinfo}" == '1' ]; then
    . include/language/php/extension/pecl_fileinfo.sh
    Install_pecl_fileinfo 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # imap
  if [ "${pecl_imap}" == '1' ]; then
    . include/language/php/extension/pecl_imap.sh
    Install_pecl_imap 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # ldap
  if [ "${pecl_ldap}" == '1' ]; then
    . include/language/php/extension/pecl_ldap.sh
    Install_pecl_ldap 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # calendar
  if [ "${pecl_calendar}" == '1' ]; then
    . include/language/php/extension/pecl_calendar.sh
    Install_pecl_calendar 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # phalcon
  if [ "${pecl_phalcon}" == '1' ]; then
    . include/language/php/extension/pecl_phalcon.sh
    Install_pecl_phalcon 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # yaf
  if [ "${pecl_yaf}" == '1' ]; then
    . include/language/php/extension/pecl_yaf.sh
    Install_pecl_yaf 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # yar
  if [ "${pecl_yar}" == '1' ]; then
    . include/language/php/extension/pecl_yar.sh
    Install_pecl_yar 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_memcached
  if [ "${pecl_memcached}" == '1' ]; then
    . include/language/php/extension/pecl_memcached.sh
    Install_pecl_memcached 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_memcache
  if [ "${pecl_memcache}" == '1' ]; then
    . include/language/php/extension/pecl_memcache.sh
    Install_pecl_memcache 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_redis
  if [ "${pecl_redis}" == '1' ]; then
    . include/language/php/extension/pecl_redis.sh
    Install_pecl_redis 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_mongodb
  if [ "${pecl_mongodb}" == '1' ]; then
    . include/language/php/extension/pecl_mongodb.sh
    Install_pecl_mongodb 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # pecl_pgsql
  if [ "${pecl_pgsql}" == '1' ]; then
    . include/language/php/extension/pecl_pgsql.sh
    Install_pecl_pgsql 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # swoole
  if [ "${pecl_swoole}" == '1' ]; then
    . include/language/php/extension/pecl_swoole.sh
    Install_pecl_swoole 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # event
  if [ "${pecl_event}" == '1' ]; then
    . include/language/php/extension/pecl_event.sh
    Install_pecl_event 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # grpc
  if [ "${pecl_grpc}" == '1' ]; then
    . include/language/php/extension/pecl_grpc.sh
    Install_pecl_grpc 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # xdebug
  if [ "${pecl_xdebug}" == '1' ]; then
    . include/language/php/extension/pecl_xdebug.sh
    Install_pecl_xdebug 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # yasd debug
  if [ "${pecl_yasd}" == '1' ]; then
    . include/language/php/extension/yasd_debug.sh
    Install_Yasd 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi

  # parallel
  if [ "${pecl_parallel}" == '1' ]; then
    . include/language/php/extension/pecl_parallel.sh
    Install_Parallel 2>&1 | tee -a ${oneinstack_dir}/install.log
  fi
}

[ "${mphp_addons_flag}" != 'y' ] && PHP_addons

# mphp
if [ "${mphp_flag}" == 'y' ]; then
  . include/language/php/mphp.sh
  Install_MPHP 2>&1 | tee -a ${oneinstack_dir}/install.log
  php_install_dir=${php_install_dir}${mphp_ver}
  PHP_addons
fi

# nodejs
case "${nodejs_method}" in
  1)
    . include/language/nodejs/node.sh
    Install_Node 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
    . include/language/nodejs/nvm.sh
    Install_Nvm 2>&1 | tee -a ${oneinstack_dir}/install.log
    Install_Wine 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# go
case "${go_option}" in
  1)
    go_ver="${go119_ver}"
    . include/language/go/go.sh
    Install_Go 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  2)
     go_ver="${go118_ver}"
    . include/language/go/go.sh
    Install_Go 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
  3)
    go_ver="${go117_ver}"
    . include/language/go/go.sh
    Install_Go 2>&1 | tee -a ${oneinstack_dir}/install.log
    ;;
esac

# python
if [ "${python_flag}" == 'y' ]; then
  . include/language/python/python.sh
  Install_Python 2>&1 | tee -a ${oneinstack_dir}/install.log
fi

if [[ ${php_option} =~ ^[1-9]$|^1[0-2]$ ]]; then
  #php开发配置
  PhpDevConfig | tee -a ${oneinstack_dir}/install.log
fi

# get web_install_dir and db_install_dir
. include/check_dir.sh

Install_LNMPDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
Install_LAMPDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
Install_StopAllDesktop 2>&1 | tee -a ${oneinstack_dir}/install.log
WwwlogsDevConfig 2>&1 | tee -a ${oneinstack_dir}/install.log

chmod -R 777 ${oneinstack_dir}/src

endTime=`date +%s`
((installTime=($endTime-$startTime)/60))
echo "####################Congratulations########################"
echo "Total OneinStack Install Time: ${CQUESTION}${installTime}${CEND} minutes"
[[ "${nginx_option}" =~ ^[1-3]$ ]] && echo -e "\n$(printf "%-32s" "Nginx install dir":)${CMSG}${nginx_install_dir}${CEND}"
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
[[ "${php_option}" =~ ^[1-9]$|^1[0-1]$ ]] && echo -e "\n$(printf "%-32s" "PHP install dir:")${CMSG}${php_install_dir}${CEND}"
[ "${phpcache_option}" == '1' ] && echo "$(printf "%-32s" "Opcache Control Panel URL:")${CMSG}http://${IPADDR}/ocp.php${CEND}"
[ "${phpcache_option}" == '2' ] && echo "$(printf "%-32s" "APC Control Panel URL:")${CMSG}http://${IPADDR}/apc.php${CEND}"
[ "${phpcache_option}" == '3' -a -e "${php_install_dir}/etc/php.d/xcache.ini" ] && echo "$(printf "%-32s" "xcache Control Panel URL:")${CMSG}http://${IPADDR}/xcache${CEND}"
[ "${phpcache_option}" == '3' -a -e "${php_install_dir}/etc/php.d/xcache.ini" ] && echo "$(printf "%-32s" "xcache user:")${CMSG}admin${CEND}"
[ "${phpcache_option}" == '3' -a -e "${php_install_dir}/etc/php.d/xcache.ini" ] && echo "$(printf "%-32s" "xcache password:")${CMSG}${xcachepwd}${CEND}"
[ "${phpcache_option}" == '4' -a -e "${php_install_dir}/etc/php.d/eaccelerator.ini" ] && echo "$(printf "%-32s" "eAccelerator Control Panel URL:")${CMSG}http://${IPADDR}/control.php${CEND}"
[ "${phpcache_option}" == '4' -a -e "${php_install_dir}/etc/php.d/eaccelerator.ini" ] && echo "$(printf "%-32s" "eAccelerator user:")${CMSG}admin${CEND}"
[ "${phpcache_option}" == '4' -a -e "${php_install_dir}/etc/php.d/eaccelerator.ini" ] && echo "$(printf "%-32s" "eAccelerator password:")${CMSG}eAccelerator${CEND}"
[ "${python_flag}" == 'y' -a -e "${python_install_dir}" ] && echo -e "\n$(printf "%-32s" "python install dir:")${CMSG}${python_install_dir}${CEND}"

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
