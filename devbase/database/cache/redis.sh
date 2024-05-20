#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Install_redis_server() {
  pushd ${ubdevenv_dir}/src/devbase/database > /dev/null
  # redis-server
  echo "Download redis-server..."
  src_url=http://download.redis.io/releases/redis-${redis_ver}.tar.gz && Download_src
  
  tar xzf redis-${redis_ver}.tar.gz
  pushd redis-${redis_ver} > /dev/null
  if [ "${OS_BIT}" == '32' -a "${armplatform}" != 'y' ]; then
    sed -i '1i\CFLAGS= -march=i686' src/Makefile
    sed -i 's@^OPT=.*@OPT=-O2 -march=i686@' src/.make-settings
  fi
  make -j ${THREAD}
  if [ -f "src/redis-server" ]; then
    mkdir -p ${redis_install_dir}/{bin,etc,var}
    /bin/cp src/{redis-benchmark,redis-check-aof,redis-check-rdb,redis-cli,redis-sentinel,redis-server} ${redis_install_dir}/bin/
    /bin/cp redis.conf ${redis_install_dir}/etc/
    ln -s ${redis_install_dir}/bin/* /usr/local/bin/
    sed -i 's@pidfile.*@pidfile /var/run/redis/redis.pid@' ${redis_install_dir}/etc/redis.conf
    sed -i "s@logfile.*@logfile ${redis_install_dir}/var/redis.log@" ${redis_install_dir}/etc/redis.conf
    sed -i "s@^dir.*@dir ${redis_install_dir}/var@" ${redis_install_dir}/etc/redis.conf
    sed -i 's@daemonize no@daemonize yes@' ${redis_install_dir}/etc/redis.conf
    sed -i "s@^# bind 127.0.0.1@bind 127.0.0.1@" ${redis_install_dir}/etc/redis.conf
    redis_maxmemory=`expr $Mem / 8`000000
    [ -z "`grep ^maxmemory ${redis_install_dir}/etc/redis.conf`" ] && sed -i "s@maxmemory <bytes>@maxmemory <bytes>\nmaxmemory `expr $Mem / 8`000000@" ${redis_install_dir}/etc/redis.conf
    echo "${CSUCCESS}Redis-server installed successfully! ${CEND}"
    popd > /dev/null
    rm -rf redis-${redis_ver}
    id -u redis >/dev/null 2>&1
    [ $? -ne 0 ] && useradd -M -s /sbin/nologin redis
    chown -R redis:redis ${redis_install_dir}/{var,etc}

    
    /bin/cp ${ubdevenv_dir}/init.d/redis-server.service /lib/systemd/system/
    sed -i "s@/usr/local/redis@${redis_install_dir}@g" /lib/systemd/system/redis-server.service
   
    #[ -z "`grep 'vm.overcommit_memory' /etc/sysctl.conf`" ] && echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
    #sysctl -p
  else
    rm -rf ${redis_install_dir}
    echo "${CFAILURE}Redis-server install failed, Please contact the author! ${CEND}" && lsb_release -a
    kill -9 $$; exit 1;
  fi
  popd > /dev/null
}
