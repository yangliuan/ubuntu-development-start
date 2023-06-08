#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

# check MySQL dir
[ -d "${mysql_install_dir}/support-files" ] && { db_install_dir=${mysql_install_dir}; db_data_dir=${mysql_data_dir}; }
[ -d "${mariadb_install_dir}/support-files" ] && { db_install_dir=${mariadb_install_dir}; db_data_dir=${mariadb_data_dir}; }
[ -d "${percona_install_dir}/support-files" ] && { db_install_dir=${percona_install_dir}; db_data_dir=${percona_data_dir}; }

# check Nginx dir
[ -e "${nginx_install_dir}/sbin/nginx" ] && web_install_dir=${nginx_install_dir}
[ -e "${tengine_install_dir}/sbin/nginx" ] && web_install_dir=${tengine_install_dir}
[ -e "${openresty_install_dir}/nginx/sbin/nginx" ] && web_install_dir=${openresty_install_dir}/nginx

# check database option
if [ ! -e "${ubdevenv_dir}/data/database.pwd" ]; then
    cat > ${ubdevenv_dir}/data/database.pwd << EOF
# [MySQL/MariaDB/Percona] automatically generated, You can't change
dbrootpwd=

# [PostgreSQL] automatically generated, You can't change
dbpostgrespwd=

# [MongoDB] automatically generated, You can't change
dbmongopwd=
EOF
fi

#check wwwroot_dir
if [ ! -d ${wwwroot_dir} ];then
    mkdir -p ${wwwroot_dir}
    chown -Rv ${run_user}.root ${wwwroot_dir}
fi

#check wwwroot_logs
if [ ! -d "${wwwlogs_dir}" ];then
    mkdir -p ${wwwlogs_dir}
    chown -Rv ${run_user}.root ${wwwlogs_dir}
fi