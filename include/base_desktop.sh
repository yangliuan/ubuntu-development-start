#!/bin/bash

chmod -R 777 /usr/share/applications

Install_PHPServiceDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null

    cp -rfv lnmp-start.desktop /usr/share/applications
    cp -rfv lamp-start.desktop /usr/share/applications
    cp -rfv php-fpm.desktop /usr/share/applications

    popd > /dev/null
}

Uninstall_PHPServiceDesktop() {
    rm -rfv /usr/share/applications/lnmp-start.desktop
    rm -rfv /usr/share/applications/lamp-start.desktop
    rm -rfv /usr/share/applications/php-fpm.desktop
}

Install_ElasticsearchDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv elasticsearch.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_ElasticsearchDesktop() {
    rm -rfv /usr/share/applications/elasticsearch.desktop
}

Install_ApacheHttpdDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv httpd.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_ApacheHttpdDesktop() {
    rm -rfv /usr/share/applications/httpd.desktop
}

Install_MemcachedDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv memcached.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_MemcachedDesktop() {
    rm -rfv /usr/share/applications/memcached.desktop
}

Install_MysqlDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv memcached.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_MysqlDesktop() {
    rm -rfv /usr/share/applications/memcached.desktop
}

Install_MysqlDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv mysql.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_MysqlDesktop() {
    rm -rfv /usr/share/applications/mysql.desktop
}

Install_NginxDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv nginx.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_NginxDesktop() {
    rm -rfv /usr/share/applications/nginx.desktop
}

Install_RedisDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv redis.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_RedisDesktop() {
    rm -rfv /usr/share/applications/redis.desktop
}

Install_PureFtpDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv pure-ftpd.desktop /usr/share/applications
    popd > /dev/null
}

Uninstall_PureFtpDesktop() {
    rm -rfv /usr/share/applications/pure-ftpd.desktop
}

Install_PHPFPMDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv php-fpm.desktop /usr/share/applications
    popd > /dev/null
}

uninstall_PHPFPMDesktop() {
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


