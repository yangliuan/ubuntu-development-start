#!/bin/bash

#set php env
Config_Current() {
    [ -z "`grep ^'export PATH=' /etc/profile`" ] && echo "export PATH=${php_env_dir}/bin:\$PATH" >> /etc/profile
    [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep ${php_env_dir} /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${php_env_dir}/bin:\1@" /etc/profile
    #切换成当前安装版本
    rm -rf /usr/local/php
    ln -s $php_install_dir /usr/local/php
    source /etc/profile
}

# php-fpm Init Script
Set_PhpFpm_Systemd() {
    #systemed
   /bin/cp ${oneinstack_dir}/init.d/php-fpm.service /lib/systemd/system/
   sed -i "s@/usr/local/php@${php_install_dir}@g" /lib/systemd/system/php-fpm.service
}

Set_PhpFpm() {
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
}

Set_PhpIni(){
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
}

