#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 6+ Debian 8+ and Ubuntu 14+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_AliSQL56() {
  pushd ${ubdevenv_dir}/src > /dev/null
  id -u mysql >/dev/null 2>&1
  [ $? -ne 0 ] && useradd -M -s /sbin/nologin mysql

  [ ! -d "${alisql_install_dir}" ] && mkdir -p ${alisql_install_dir}
  mkdir -p ${alisql_data_dir};chown mysql:mysql -R ${alisql_data_dir}

  tar xzf alisql-${alisql_ver}.tar.gz
  pushd alisql-${alisql_ver}
  cmake . -DCMAKE_INSTALL_PREFIX=${alisql_install_dir} \
  -DCMAKE_BUILD_TYPE="Release" \
  -DWITH_EMBEDDED_SERVER=0 \
  -DWITH_EXTRA_CHARSETS=all \
  -DWITH_MYISAM_STORAGE_ENGINE=1 \
  -DWITH_INNOBASE_STORAGE_ENGINE=1 \
  -DWITH_PARTITION_STORAGE_ENGINE=1 \
  -DWITH_CSV_STORAGE_ENGINE=1 \
  -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
  -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
  -DWITH_FEDERATED_STORAGE_ENGINE=1 \
  -DWITH_PERFSCHEMA_STORAGE_ENGINE=1 \
  -DWITH_TOKUDB_STORAGE_ENGINE=0
  make -j ${THREAD}
  make install
  popd

  if [ -d "${alisql_install_dir}/support-files" ]; then
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    sed -i "s+^dbrootpwd.*+dbrootpwd='${dbrootpwd}'+" ../data/database.pwd
    echo "${CSUCCESS}AliSQL installed successfully! ${CEND}"
    rm -rf alisql-${alisql_ver}
  else
    rm -rf ${alisql_install_dir}
    rm -rf alisql-${alisql_ver}
    echo "${CFAILURE}AliSQL install failed, Please contact the author! ${CEND}" && lsb_release -a
    kill -9 $$
  fi
  /bin/cp ${alisql_install_dir}/support-files/mysql.server /etc/init.d/mysqld
  [ -z "`grep transparent_hugepage /etc/init.d/mysqld`" ] && sed -i "s@^basedir=.*@echo never > /sys/kernel/mm/transparent_hugepage/enabled\n&@" /etc/init.d/mysqld
  sed -i "s@^basedir=.*@basedir=${alisql_install_dir}@" /etc/init.d/mysqld
  sed -i "s@^datadir=.*@datadir=${alisql_data_dir}@" /etc/init.d/mysqld
  chmod +x /etc/init.d/mysqld
  systemctl daemon-reload 

  popd

  # my.cnf
  [ -d "/etc/mysql" ] && /bin/mv /etc/mysql{,_bk}
  cat > /etc/my.cnf << EOF
[client]
port = 3306
socket = /tmp/mysql.sock
default-character-set = utf8mb4

[mysql]
prompt="AliSQL [\\d]> "
no-auto-rehash

[mysqld]
port = 3306
socket = /tmp/mysql.sock

basedir = ${alisql_install_dir}
datadir = ${alisql_data_dir}
pid-file = ${alisql_data_dir}/mysql.pid
user = mysql
bind-address = 0.0.0.0
server-id = 1

init-connect = 'SET NAMES utf8mb4'
character-set-server = utf8mb4

skip-name-resolve
#skip-networking
back_log = 300

max_connections = 1000
max_connect_errors = 6000
open_files_limit = 65535
table_open_cache = 128
max_allowed_packet = 500M
binlog_cache_size = 1M
max_heap_table_size = 8M
tmp_table_size = 16M

read_buffer_size = 2M
read_rnd_buffer_size = 8M
sort_buffer_size = 8M
join_buffer_size = 8M
key_buffer_size = 4M

thread_cache_size = 8

query_cache_type = 1
query_cache_size = 8M
query_cache_limit = 2M

ft_min_word_len = 4

log_bin = mysql-bin
binlog_format = mixed
expire_logs_days = 7

log_error = ${alisql_data_dir}/mysql-error.log
slow_query_log = 1
long_query_time = 1
slow_query_log_file = ${alisql_data_dir}/mysql-slow.log

performance_schema = 0
explicit_defaults_for_timestamp

#lower_case_table_names = 1

skip-external-locking

default_storage_engine = InnoDB
innodb_file_per_table = 1
innodb_open_files = 500
innodb_buffer_pool_size = 64M
innodb_write_io_threads = 4
innodb_read_io_threads = 4
innodb_thread_concurrency = 0
innodb_purge_threads = 1
innodb_flush_log_at_trx_commit = 2
innodb_log_buffer_size = 2M
innodb_log_file_size = 32M
innodb_log_files_in_group = 3
innodb_max_dirty_pages_pct = 90
innodb_lock_wait_timeout = 120

bulk_insert_buffer_size = 8M
myisam_sort_buffer_size = 8M
myisam_max_sort_file_size = 10G
myisam_repair_threads = 1

interactive_timeout = 28800
wait_timeout = 28800

[mysqldump]
quick
max_allowed_packet = 500M

[myisamchk]
key_buffer_size = 8M
sort_buffer_size = 8M
read_buffer = 4M
write_buffer = 4M
EOF

  sed -i "s@max_connections.*@max_connections = $((${Mem}/3))@" /etc/my.cnf
  if [ ${Mem} -gt 1500 -a ${Mem} -le 2500 ]; then
    sed -i 's@^thread_cache_size.*@thread_cache_size = 16@' /etc/my.cnf
    sed -i 's@^query_cache_size.*@query_cache_size = 16M@' /etc/my.cnf
    sed -i 's@^myisam_sort_buffer_size.*@myisam_sort_buffer_size = 16M@' /etc/my.cnf
    sed -i 's@^key_buffer_size.*@key_buffer_size = 16M@' /etc/my.cnf
    sed -i 's@^innodb_buffer_pool_size.*@innodb_buffer_pool_size = 128M@' /etc/my.cnf
    sed -i 's@^tmp_table_size.*@tmp_table_size = 32M@' /etc/my.cnf
    sed -i 's@^table_open_cache.*@table_open_cache = 256@' /etc/my.cnf
  elif [ ${Mem} -gt 2500 -a ${Mem} -le 3500 ]; then
    sed -i 's@^thread_cache_size.*@thread_cache_size = 32@' /etc/my.cnf
    sed -i 's@^query_cache_size.*@query_cache_size = 32M@' /etc/my.cnf
    sed -i 's@^myisam_sort_buffer_size.*@myisam_sort_buffer_size = 32M@' /etc/my.cnf
    sed -i 's@^key_buffer_size.*@key_buffer_size = 64M@' /etc/my.cnf
    sed -i 's@^innodb_buffer_pool_size.*@innodb_buffer_pool_size = 512M@' /etc/my.cnf
    sed -i 's@^tmp_table_size.*@tmp_table_size = 64M@' /etc/my.cnf
    sed -i 's@^table_open_cache.*@table_open_cache = 512@' /etc/my.cnf
  elif [ ${Mem} -gt 3500 ]; then
    sed -i 's@^thread_cache_size.*@thread_cache_size = 64@' /etc/my.cnf
    sed -i 's@^query_cache_size.*@query_cache_size = 64M@' /etc/my.cnf
    sed -i 's@^myisam_sort_buffer_size.*@myisam_sort_buffer_size = 64M@' /etc/my.cnf
    sed -i 's@^key_buffer_size.*@key_buffer_size = 256M@' /etc/my.cnf
    sed -i 's@^innodb_buffer_pool_size.*@innodb_buffer_pool_size = 1024M@' /etc/my.cnf
    sed -i 's@^tmp_table_size.*@tmp_table_size = 128M@' /etc/my.cnf
    sed -i 's@^table_open_cache.*@table_open_cache = 1024@' /etc/my.cnf
  fi

  ${alisql_install_dir}/scripts/mysql_install_db --user=mysql --basedir=${alisql_install_dir} --datadir=${alisql_data_dir}

  [ "${Wsl}" == true ] && chmod 600 /etc/my.cnf
  chown mysql:mysql -R ${alisql_data_dir}
  [ -d "/etc/mysql" ] && mv /etc/mysql{,_bk}
  service mysqld start
  [ -z "$(grep ^'export PATH=' /etc/profile)" ] && echo "export PATH=${alisql_install_dir}/bin:\$PATH" >> /etc/profile
  [ -n "$(grep ^'export PATH=' /etc/profile)" -a -z "$(grep ${alisql_install_dir} /etc/profile)" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${alisql_install_dir}/bin:\1@" /etc/profile
  . /etc/profile

  ${alisql_install_dir}/bin/mysql -e "grant all privileges on *.* to root@'127.0.0.1' identified by \"${dbrootpwd}\" with grant option;"
  ${alisql_install_dir}/bin/mysql -e "grant all privileges on *.* to root@'localhost' identified by \"${dbrootpwd}\" with grant option;"
  ${alisql_install_dir}/bin/mysql -uroot -p${dbrootpwd} -e "delete from mysql.user where Password='';"
  ${alisql_install_dir}/bin/mysql -uroot -p${dbrootpwd} -e "delete from mysql.db where User='';"
  ${alisql_install_dir}/bin/mysql -uroot -p${dbrootpwd} -e "delete from mysql.proxies_priv where Host!='localhost';"
  ${alisql_install_dir}/bin/mysql -uroot -p${dbrootpwd} -e "drop database test;"
  ${alisql_install_dir}/bin/mysql -uroot -p${dbrootpwd} -e "reset master;"
  rm -rf /etc/ld.so.conf.d/{mysql,mariadb,percona,alisql}*.conf
  [ -e "${alisql_install_dir}/my.cnf" ] && rm -rf ${alisql_install_dir}/my.cnf
  echo "${alisql_install_dir}/lib" > /etc/ld.so.conf.d/z-alisql.conf
  ldconfig
  service mysqld stop
}
