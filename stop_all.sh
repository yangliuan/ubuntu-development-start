#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
clear
printf "
####################################################################
                          stop all service      
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
. ./include/get_char.sh

if [[ -e "/lib/systemd/system/nginx.service" ]]; then
    systemctl stop nginx.service
fi

if [[ -e "/lib/systemd/system/php-fpm.service" ]]; then
    systemctl stop php-fpm.service
fi

if [[ -e "/etc/init.d/mysqld/mysql.server" ]]; then
    systemctl stop mysql.service
fi

if [[ -e "/lib/systemd/system/redis-server.service" ]]; then
    systemctl stop redis-server.service
fi

if [[ -e "/etc/init.d/memcached" ]]; then
    systemctl stop memcached.service
fi

if [[ -e "/lib/systemd/system/mongod.service" ]]; then
    systemctl stop mongod.service
fi

if [[ -e "/lib/systemd/system/postgresql.service" ]]; then
    systemctl stop postgresql.service
fi

echo "stop all service successed!"