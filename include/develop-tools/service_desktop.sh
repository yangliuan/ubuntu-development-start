#!/bin/bash
Install_ServiceDesktop() {
    pushd ${oneinstack_dir}/desktop > /dev/null
    cp -rfv elasticsearch.desktop /usr/share/applications
    cp -rfv httpd.desktop /usr/share/applications
    cp -rfv memcached.desktop /usr/share/applications
    cp -rfv mysql.desktop /usr/share/applications
    cp -rfv nginx.desktop /usr/share/applications
    cp -rfv redis.desktop /usr/share/applications
    chmod -R 777 /usr/share/applications
    popd > /dev/null
}

Uninstall_ServiceDesktop() {
    rm -rfv /usr/share/applications/elasticsearch.desktop
    rm -rfv /usr/share/applications/httpd.desktop
    rm -rfv /usr/share/applications/memcached.desktop
    rm -rfv /usr/share/applications/mysql.desktop
    rm -rfv /usr/share/applications/nginx.desktop
    rm -rfv /usr/share/applications/redis.desktop
}

Install_PHPService() {
    cp -rfv lnmp-start.desktop /usr/share/applications
    cp -rfv php-fpm.desktop /usr/share/applications
}

Uninstall_PHPService() {
    rm -rfv /usr/share/applications/lnmp-start.desktop
    rm -rfv /usr/share/applications/php-fpm.desktop
}



