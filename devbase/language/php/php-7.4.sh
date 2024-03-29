#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_PHP74() {
  pushd ${ubdevenv_dir}/src > /dev/null
  
  . ${ubdevenv_dir}/devbase/system-lib/iconv.sh
  Install_Libiconv

  if [ ! -e "${curl_install_dir}/lib/libcurl.la" ]; then
    tar xzf curl-${curl_ver}.tar.gz
    pushd curl-${curl_ver} > /dev/null
    [ -e "/usr/local/lib/libnghttp2.so" ] && with_nghttp2='--with-nghttp2=/usr/local'
    ./configure --prefix=${curl_install_dir} ${php74_with_ssl} ${with_nghttp2}
    make -j ${THREAD} && make install
    popd > /dev/null
    rm -rf curl-${curl_ver}
  fi

  . ${ubdevenv_dir}/devbase/system-lib/libfreetype.sh
  Install_Libfreetype

  . ${ubdevenv_dir}/devbase/system-lib/libargon2.sh
  Install_Libargon2

  . ${ubdevenv_dir}/devbase/system-lib/libsodium.sh
  Install_Libsodium

  . ${ubdevenv_dir}/devbase/system-lib/libzip.sh
  Install_Libzip

  . ${ubdevenv_dir}/devbase/system-lib/mhash.sh
  Install_Mhash

  [ -z "`grep /usr/local/lib /etc/ld.so.conf.d/*.conf`" ] && echo '/usr/local/lib' > /etc/ld.so.conf.d/local.conf
  ldconfig

  id -g ${run_group} >/dev/null 2>&1
  [ $? -ne 0 ] && groupadd ${run_group}
  id -u ${run_user} >/dev/null 2>&1
  [ $? -ne 0 ] && useradd -g ${run_group} -M -s /sbin/nologin ${run_user}

  tar xzf php-${php74_ver}.tar.gz
  pushd php-${php74_ver} > /dev/null
  if [ -e ext/openssl/openssl.c ] && ! grep -Eqi '^#ifdef RSA_SSLV23_PADDING' ext/openssl/openssl.c; then
    sed -i '/OPENSSL_SSLV23_PADDING/i#ifdef RSA_SSLV23_PADDING' ext/openssl/openssl.c
    sed -i '/OPENSSL_SSLV23_PADDING/a#endif' ext/openssl/openssl.c
  fi
  make clean
  export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig/:$PKG_CONFIG_PATH
  [ ! -d "${php_install_dir}" ] && mkdir -p ${php_install_dir}
  [ "${phpcache_option}" == '1' ] && phpcache_arg='--enable-opcache' || phpcache_arg='--disable-opcache'

  if [ -e "${apache_install_dir}/bin/apxs" ]; then
    ./configure --prefix=${php_install_dir} --with-config-file-path=${php_install_dir}/etc \
    --with-config-file-scan-dir=${php_install_dir}/etc/php.d \
    --with-fpm-user=${run_user} --with-fpm-group=${run_group} --enable-fpm \
    --with-apxs2=${apache_install_dir}/bin/apxs ${phpcache_arg} --disable-fileinfo \
    --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
    --with-iconv-dir=${libiconv_install_dir} --with-freetype --with-jpeg --with-webp --with-zlib \
    --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-exif \
    --enable-sysvsem --enable-inline-optimization ${php74_with_curl} --enable-mbregex \
    --enable-mbstring --with-password-argon2 --with-sodium=/usr/local --enable-gd ${php74_with_openssl} \
    --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-ftp --enable-intl --with-xsl \
    --with-gettext --with-zip=/usr/local --enable-soap --disable-debug ${php_modules_options}
  else
    ./configure --prefix=${php_install_dir} --with-config-file-path=${php_install_dir}/etc \
    --with-config-file-scan-dir=${php_install_dir}/etc/php.d \
    --with-fpm-user=${run_user} --with-fpm-group=${run_group} --enable-fpm ${phpcache_arg} --disable-fileinfo \
    --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd \
    --with-iconv-dir=${libiconv_install_dir} --with-freetype --with-jpeg --with-webp --with-zlib \
    --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-exif \
    --enable-sysvsem --enable-inline-optimization ${php74_with_curl} --enable-mbregex \
    --enable-mbstring --with-password-argon2 --with-sodium=/usr/local --enable-gd ${php74_with_openssl} \
    --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-ftp --enable-intl --with-xsl \
    --with-gettext --with-zip=/usr/local --enable-soap --disable-debug ${php_modules_options}
  fi
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

  . ${ubdevenv_dir}/devbase/language/php/extension/zendopcache.sh
  [ "${phpcache_option}" == '1' ] && Set_OPcacheIni

  #config env path php-fpm.conf php.ini
  . ${ubdevenv_dir}/devbase/language/php/config_env.sh
  Set_PhpFpm_Systemd
  Set_PhpFpm
  Set_PhpIni
  Set_EnvPath
  
  popd > /dev/null
  rm -rf php-${php74_ver}
  popd > /dev/null
}
