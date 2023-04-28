#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack
#

Install_PHP53() {
  pushd ${oneinstack_dir}/src > /dev/null

  . ${oneinstack_dir}/include/system-lib/iconv.sh
  Install_Libiconv

  . ${oneinstack_dir}/include/system-lib/libcurl.sh
  Install_Libcurl_PHP5

  . ${oneinstack_dir}/include/system-lib/libfreetype.sh
  Install_Libfreetype

  . ${oneinstack_dir}/include/system-lib/mcrypt.sh
  Install_Libmcrypt

  . ${oneinstack_dir}/include/system-lib/mhash.sh
  Install_Mhash

  [ -z "`grep /usr/local/lib /etc/ld.so.conf.d/*.conf`" ] && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
  ldconfig

  Install_Mcrypt
  
  id -g ${run_group} >/dev/null 2>&1
  [ $? -ne 0 ] && groupadd ${run_group}
  id -u ${run_user} >/dev/null 2>&1
  [ $? -ne 0 ] && useradd -g ${run_group} -M -s /sbin/nologin ${run_user}

  tar xzf php-${php53_ver}.tar.gz
  patch -d php-${php53_ver} -p0 < fpm-race-condition.patch
  pushd php-${php53_ver} > /dev/null
  patch -p1 < ../patch/php5.3patch
  patch -p1 < ../debian_patches_disable_SSLv2_for_openssl_1_0_0.patch
  make clean
  [ ! -d "${php_install_dir}" ] && mkdir -p ${php_install_dir}
  { [ ${Debian_ver} -ge 10 >/dev/null 2>&1 ] || [ ${Ubuntu_ver} -ge 19 >/dev/null 2>&1 ]; } || intl_modules_options='--enable-intl'

  if [ -e "${apache_install_dir}/bin/apxs" ]; then
    ./configure --prefix=${php_install_dir} --with-config-file-path=${php_install_dir}/etc \
    --with-config-file-scan-dir=${php_install_dir}/etc/php.d \
    --with-fpm-user=${run_user} --with-fpm-group=${run_group} --enable-fpm \
    --with-apxs2=${apache_install_dir}/bin/apxs --disable-fileinfo \
    --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
    --with-iconv-dir=${libiconv_install_dir} --with-freetype-dir=${freetype_install_dir} --with-jpeg-dir --with-png-dir --with-webp-dir --with-zlib \
    --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-exif \
    --enable-sysvsem --enable-inline-optimization ${php5_with_curl} --enable-mbregex \
    --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf ${php5_with_openssl} \
    --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-ftp --with-xsl ${intl_modules_options} \
    --with-gettext --enable-zip --enable-soap --disable-debug ${php_modules_options}
  else
    ./configure --prefix=${php_install_dir} --with-config-file-path=${php_install_dir}/etc \
    --with-config-file-scan-dir=${php_install_dir}/etc/php.d \
    --with-fpm-user=${run_user} --with-fpm-group=${run_group} --enable-fpm --disable-fileinfo \
    --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
    --with-iconv-dir=${libiconv_install_dir} --with-freetype-dir=${freetype_install_dir} --with-jpeg-dir --with-png-dir --with-webp-dir --with-zlib \
    --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-exif \
    --enable-sysvsem --enable-inline-optimization ${php5_with_curl} --enable-mbregex \
    --enable-mbstring --with-mcrypt --with-gd --enable-gd-native-ttf ${php5_with_openssl} \
    --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-ftp --with-xsl ${intl_modules_options} \
    --with-gettext --enable-zip --enable-soap --disable-debug ${php_modules_options}
  fi
  { [ ${Debian_ver} -ge 10 >/dev/null 2>&1 ] || [ ${Ubuntu_ver} -ge 19 >/dev/null 2>&1 ]; } || sed -i '/^BUILD_/ s/\$(CC)/\$(CXX)/g' Makefile
  make ZEND_EXTRA_LIBS='-liconv' -j ${THREAD}
  make install

  if [ -e "${php_install_dir}/bin/phpize" ]; then
    [ ! -e "${php_install_dir}/etc/php.d" ] && mkdir -p ${php_install_dir}/etc/php.d
    echo "${CSUCCESS}PHP installed successfully! ${CEND}"
  else
    rm -rf ${php_install_dir}
    echo "${CFAILURE}PHP install failed, Please Contact the author! ${CEND}"
    kill -9 $$; exit 1;
  fi

  . ${oneinstack_dir}/include/language/php/config_env.sh; Config_Current
  . /etc/profile

  # wget -c http://pear.php.net/go-pear.phar
  # ${php_install_dir}/bin/php go-pear.phar

  /bin/cp php.ini-development ${php_install_dir}/etc/php.ini

  sed -i "s@^memory_limit.*@memory_limit = ${Memory_limit}M@" ${php_install_dir}/etc/php.ini
  sed -i 's@^output_buffering =@output_buffering = On\noutput_buffering =@' ${php_install_dir}/etc/php.ini
  #sed -i 's@^;cgi.fix_pathinfo.*@cgi.fix_pathinfo=0@' ${php_install_dir}/etc/php.ini
  sed -i 's@^short_open_tag = Off@short_open_tag = On@' ${php_install_dir}/etc/php.ini
  sed -i 's@^expose_php = On@expose_php = Off@' ${php_install_dir}/etc/php.ini
  sed -i 's@^request_order.*@request_order = "CGP"@' ${php_install_dir}/etc/php.ini
  sed -i "s@^;date.timezone.*@date.timezone = ${timezone}@" ${php_install_dir}/etc/php.ini
  sed -i 's@^post_max_size.*@post_max_size = 100M@' ${php_install_dir}/etc/php.ini
  sed -i 's@^upload_max_filesize.*@upload_max_filesize = 50M@' ${php_install_dir}/etc/php.ini
  sed -i 's@^max_execution_time.*@max_execution_time = 5@' ${php_install_dir}/etc/php.ini
  sed -i 's@^disable_functions.*@disable_functions = passthru,exec,system,chroot,chgrp,chown,shell_exec,proc_open,proc_get_status,ini_alter,ini_restore,dl,readlink,symlink,popepassthru,stream_socket_server,fsocket,popen@' ${php_install_dir}/etc/php.ini
  [ -e /usr/sbin/sendmail ] && sed -i 's@^;sendmail_path.*@sendmail_path = /usr/sbin/sendmail -t -i@' ${php_install_dir}/etc/php.ini

  # php-fpm Init Script
  /bin/cp ${oneinstack_dir}/init.d/php-fpm.service /lib/systemd/system/
  sed -i "s@/usr/local/php@${php_install_dir}@g" /lib/systemd/system/php-fpm.service

  cat > ${php_install_dir}/etc/php-fpm.conf <<EOF
;;;;;;;;;;;;;;;;;;;;;
; FPM Configuration ;
;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
; Global Options ;
;;;;;;;;;;;;;;;;;;

[global]
pid = run/php-fpm.pid
error_log = log/php-fpm.log
log_level = warning

emergency_restart_threshold = 30
emergency_restart_interval = 60s
process_control_timeout = 5s
daemonize = yes

;;;;;;;;;;;;;;;;;;;;
; Pool Definitions ;
;;;;;;;;;;;;;;;;;;;;

[${run_user}]
listen = /dev/shm/php-cgi.sock
listen.backlog = -1
listen.allowed_clients = 127.0.0.1
listen.owner = ${run_user}
listen.group = ${run_group}
listen.mode = 0666
user = ${run_user}
group = ${run_group}

pm = static
pm.max_children = ${THREAD}
pm.max_requests = 1000
request_terminate_timeout = 60
request_slowlog_timeout = 5

pm.status_path = /php-fpm_status
slowlog = var/log/slow.log
rlimit_files = 51200
rlimit_core = 0

catch_workers_output = yes
;env[HOSTNAME] = $HOSTNAME
env[PATH] = /usr/local/bin:/usr/bin:/bin
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp
EOF

  popd > /dev/null
  [ -e "${php_install_dir}/bin/phpize" ] && rm -rf php-${php53_ver}
  popd > /dev/null
}
