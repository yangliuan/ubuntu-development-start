#!/bin/bash
Set_DevConfig(){
    source ${oneinstack_dir}/switch/php.sh

    if [ -e "${nginx_install_dir}" ];then
        pushd ${nginx_install_dir}/sbin > /dev/null 
        chown root.${run_user} nginx
        chmod 750 nginx
        chmod u+s nginx
        popd > /dev/null
    fi

    if [ -e "${tengine_install_dir}" ];then
        pushd ${tengine_install_dir}/nginx/sbin > /dev/null 
        chown root.${run_user} nginx
        chmod 750 nginx
        chmod u+s nginx
        popd > /dev/null
    fi

    if [ -e "${openresty_install_dir}" ];then
        pushd ${openresty_install_dir}/nginx/sbin > /dev/null 
        chown root.${run_user} nginx
        chmod 750 nginx
        chmod u+s nginx
        popd > /dev/null
    fi
}