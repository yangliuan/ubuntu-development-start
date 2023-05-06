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

  #config env path php-fpm.conf php.ini
  . ${oneinstack_dir}/include/language/php/config_env.sh
  Set_PhpFpm_Systemd
  Set_PhpFpm
  Set_PhpIni
  Set_EnvPath
  
  popd > /dev/null
  [ -e "${php_install_dir}/bin/phpize" ] && rm -rf php-${php53_ver}
  popd > /dev/null
}
