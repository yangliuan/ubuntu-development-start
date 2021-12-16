#!/bin/bash
Service_Desktop(){
    pushd ${oneinstack_dir}/desktop > /dev/null

    cp -rfv elasticsearch.desktop /usr/share/applications
    cp -rfv httpd.desktop /usr/share/applications
    cp -rfv lnmp-start.desktop /usr/share/applications
    cp -rfv memcached.desktop /usr/share/applications
    cp -rfv mysql.desktop /usr/share/applications
    cp -rfv nginx.desktop /usr/share/applications
    cp -rfv php-fpm.desktop /usr/share/applications
    cp -rfv redis.desktop /usr/share/applications

    popd > /dev/null
}