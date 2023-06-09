#!/bin/bash
##devbase/database and nosql#####################################################
Install_ElasticStackDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv elasticstack.desktop elasticsearch.desktop kibana.desktop logstash.desktop cerebro.desktop beats.desktop /usr/share/applications
    popd > /dev/null

    pushd /usr/share/applications/ > /dev/null
    chown -Rv ${run_user}.${run_group} elasticstack.desktop elasticsearch.desktop kibana.desktop logstash.desktop cerebro.desktop beats.desktop
    popd > /dev/null
}

Uninstall_ElasticStackDesktop() {
    pushd /usr/share/applications/ > /dev/null
    rm -rfv elasticsearch.desktop kibana.desktop logstash.desktop cerebro.desktop beats.desktop
    popd > /dev/null
}

Install_MysqlDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv mysql.desktop  /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/mysql.desktop
    popd > /dev/null
}

Uninstall_MysqlDesktop() {
    rm -rfv /usr/share/applications/mysql.desktop
}

Install_PostgresqlDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv postgresql.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/postgresql.desktop
    popd > /dev/null
}

Uninstall_PostgresqlDesktop() {
    rm -rfv /usr/share/applications/postgresql.desktop
}

Install_MongoDBDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv mongodb.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/mongodb.desktop
    popd > /dev/null
}

Uninstall_MongoDBDesktop() {
    rm -rfv /usr/share/applications/mongodb.desktop
}

Install_MemcachedDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv memcached.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/memcached.desktop
    popd > /dev/null
}

Uninstall_MemcachedDesktop() {
    rm -rfv /usr/share/applications/memcached.desktop
}

Install_RedisDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv redis.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/redis.desktop
    popd > /dev/null
}

Uninstall_RedisDesktop() {
    rm -rfv /usr/share/applications/redis.desktop
}

##web server################################################
Install_ApacheHttpdDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv httpd.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/httpd.desktop
    popd > /dev/null
}

Uninstall_ApacheHttpdDesktop() {
    rm -rfv /usr/share/applications/httpd.desktop
}

Install_NginxDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv nginx.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/nginx.desktop
    popd > /dev/null
}

Uninstall_NginxDesktop() {
    rm -rfv /usr/share/applications/nginx.desktop
}

Install_TengineDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv tenigne.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/tenigne.desktop
    popd > /dev/null
}

Uninstall_TengineDesktop() {
    rm -rfv /usr/share/applications/tenigne.desktop
}

Install_OpenrestyDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv openresty.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/openresty.desktop
    popd > /dev/null
}

Uninstall_OpenrestyDesktop() {
    rm -rfv /usr/share/applications/openresty.desktop
}

Install_TomcatDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv tomcat.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/tomcat.desktop
    popd > /dev/null
}

Uninstall_TomcatDesktop() {
    rm -rfv /usr/share/applications/tomcat.desktop
}

##ftp##################################################
Install_PureFtpDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv pure-ftpd.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/pure-ftpd.desktop
    popd > /dev/null
}

Uninstall_PureFtpDesktop() {
    rm -rfv /usr/share/applications/pure-ftpd.desktop
}

##php####################################################
Install_PHPFPMDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv php-fpm.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/php-fpm.desktop
    popd > /dev/null
}

Uninstall_PHPFPMDesktop() {
    rm -rfv /usr/share/applications/php-fpm.desktop
}

Install_LNMPDesktop() {
    if [[ -e "${nginx_install_dir}/sbin/nginx" ]]; then
        nginx_flag=true
    elif [[ -e "${tengine_install_dir}/sbin/nginx" ]]; then
        nginx_flag=true
    elif [[ -e "${openresty_install_dir}/nginx/sbin/nginx" ]]; then
        nginx_flag=true
    else
        nginx_flag=false
    fi

    if [[ $nginx_flag == true ]] && [[ -L "/usr/local/php" ]] && [[ -d "${db_install_dir}/support-files" ]]; then
        pushd ${ubdevenv_dir}/desktop > /dev/null
        cp -rfv lnmp-start.desktop /usr/share/applications
        chown -Rv ${run_user}.${run_group} /usr/share/applications/lnmp-start.desktop
        popd > /dev/null
    fi
}

Uninstall_LNMPDesktop() {
    rm -rfv /usr/share/applications/lnmp-start.desktop
}

Install_LAMPDesktop() {
    if [[ -e "${apache_install_dir}/bin/httpd" ]] && [[ -L "/usr/local/php" ]] && [[ -d "${db_install_dir}/support-files" ]]; then
        pushd ${ubdevenv_dir}/desktop > /dev/null
        cp -rfv lamp-start.desktop /usr/share/applications
        chown -Rv ${run_user}.${run_group} /usr/share/applications/lamp-start.desktop
        popd > /dev/null
    fi
}

Uninstall_LAMPDesktop() {
    rm -rfv /usr/share/applications/lamp-start.desktop
}

##Supervisor###########################################
Install_SupervisorDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv supervisord.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/supervisord.desktop
    popd > /dev/null
}

Uninstall_SupervisorDesktop() {
    rm -rfv /usr/share/applications/supervisord.desktop
}

##message queue########################################
Install_ZookeeperDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv zookeeper.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/zookeeper.desktop
    popd > /dev/null
}

Uninstall_ZookeeperDesktop() {
    rm -rfv /usr/share/applications/zookeeper.desktop
}

Install_KafkaDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv kafka.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/kafka.desktop
    popd > /dev/null
}

Uninstall_KafkaDesktop() {
    rm -rfv /usr/share/applications/kafka.desktop
}

Install_RabbitmqDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv rabbitmq.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/rabbitmq.desktop
    popd > /dev/null
}

Uninstall_RabbitmqDesktop() {
    rm -rfv /usr/share/applications/rabbitmq.desktop
}

Install_RocketmqDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv rocketmq.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/rocketmq.desktop
    popd > /dev/null
}

Uninstall_RocketmqDesktop() {
    rm -rfv /usr/share/applications/rocketmq.desktop
}

Install_SqliteDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv sqlite.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/sqlite.desktop
    popd > /dev/null
}

Uninstall_SqliteDesktop() {
    rm -rfv /usr/share/applications/sqlite.desktop
}

Install_FFmpegDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv ffmpeg.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/ffmpeg.desktop
    popd > /dev/null
}

Uninstall_FFmpegDesktop() {
    rm -rfv /usr/share/applications/ffmpeg.desktop
}

Install_SwithDevEnvDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv switchdevenv.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/switchdevenv.desktop
    popd > /dev/null
}

Uninstall_SwithDevEnvDesktop() {
    rm -rfv /usr/share/applications/switchdevenv.desktop
}

Install_SSHDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv openssh.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/openssh.desktop
    popd > /dev/null
}

Uninstall_SSHDesktop() {
    rm -rfv /usr/share/applications/openssh.desktop
}

Install_StopAllDesktop() {
    pushd ${ubdevenv_dir}/desktop > /dev/null
    cp -rfv stop-all.desktop /usr/share/applications
    chown -Rv ${run_user}.${run_group} /usr/share/applications/stop-all.desktop
    popd > /dev/null
    Change_Sudoers
}

Uninstall_StopAllDesktop() {
    rm -rfv /usr/share/applications/stop-all.desktop
}

Change_Sudoers() {
    if [ ! -e "/etc/sudoers.bak" ]; then
         # back up sudoers
        cp /etc/sudoers /etc/sudoers.bak
        # change sudoer for run_user
        sed -i "/^%sudo\s\+ALL=(ALL:ALL)\s\+ALL$/a ${run_user} ALL=(ALL) NOPASSWD: ALL" /etc/sudoers

        if [ $? -eq 0 ]; then
            echo "sudoers file edit success. ${run_user}, You don't need to enter a password for sudo operations"
        else
            echo "Failed to modify the sudoers file. Please manually check and restore the sudoers file."
        fi
    fi
}
