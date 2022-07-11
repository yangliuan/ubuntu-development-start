#!/bin/bash
chmod -R 777 /usr/share/applications

##database and nosql#####################################################
Install_ElasticsearchDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv elasticsearch.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_ElasticsearchDesktop() {
    rm -rfv /usr/share/applications/elasticsearch.desktop
}

Install_MysqlDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv mysql.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_MysqlDesktop() {
    rm -rfv /usr/share/applications/mysql.desktop
}

Install_PostgresqlDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv postgresql.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_PostgresqlDesktop() {
    rm -rfv /usr/share/applications/postgresql.desktop
}

Install_MongoDBDesktop() {
  pushd ${oneinstack_dir}/desktop > /dev/null
  cp -rfv mongodb.desktop /usr/share/applications
  popd > /dev/null
}

Uninstall_MongoDBDesktop() {
  rm -rfv /usr/share/applications/mongodb.desktop
}

Install_MemcachedDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv memcached.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_MemcachedDesktop() {
    rm -rfv /usr/share/applications/memcached.desktop
}

Install_RedisDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv redis.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_RedisDesktop() {
    rm -rfv /usr/share/applications/redis.desktop
}

##web server################################################
Install_ApacheHttpdDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv httpd.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_ApacheHttpdDesktop() {
    rm -rfv /usr/share/applications/httpd.desktop
}

Install_NginxDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv nginx.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_NginxDesktop() {
    rm -rfv /usr/share/applications/nginx.desktop
}

Install_TomcatDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv tomcat.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_TomcatDesktop() {
    rm -rfv /usr/share/applications/tomcat.desktop
}

##ftp##################################################
Install_PureFtpDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv pure-ftpd.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_PureFtpDesktop() {
    rm -rfv /usr/share/applications/pure-ftpd.desktop
}

##php####################################################
Install_PHPFPMDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv php-fpm.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_PHPFPMDesktop() {
    rm -rfv /usr/share/applications/php-fpm.desktop
}

Install_LNMPDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv lnmp-start.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_LNMPDesktop() {
    rm -rfv /usr/share/applications/lnmp-start.desktop
}

Install_LAMPDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv lnmp-start.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_LAMPDesktop() {
    rm -rfv /usr/share/applications/lnmp-start.desktop
}

##Supervisor###########################################
Install_SupervisorDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv supervisord.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_SupervisorDesktop() {
    rm -rfv /usr/share/applications/supervisord.desktop
}

##message queue########################################
Install_KafkaDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv kafka.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_KafkaDesktop() {
    rm -rfv /usr/share/applications/kafka.desktop
}

Install_RabbitmqDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv rabbitmq.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_RabbitmqDesktop() {
    rm -rfv /usr/share/applications/rabbitmq.desktop
}
