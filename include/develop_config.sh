#!/bin/bash
NginxDevConfig() {
    #修改nginx权限，让运行用户有权限操作指令
    if [ -e "${nginx_install_dir}" ]; then
        pushd ${nginx_install_dir}/sbin > /dev/null 
        chown -Rv root.${run_user} nginx
        chmod -Rv 750 nginx
        chmod -Rv u+s nginx
        chmod -R 777 ${nginx_install_dir}/conf
        popd > /dev/null
        if [ -e "${nginx_conf_backup_dir}" ]; then
            cp -rfv ${nginx_conf_backup_dir}/* ${nginx_install_dir}/conf/
            [ -z "`grep 'study\/\*\.conf;' ${nginx_install_dir}/conf/nginx.conf`" ] && sed -i "s@include\ vhost\/\*.conf;@include vhost/*.conf;\n  include work/*.conf;\n  include study/*.conf;@g" ${nginx_install_dir}/conf/nginx.conf
            chmod -R 777 ${nginx_install_dir}/conf/
        fi
    fi
}

TengineDevConfig() {
    #修改tengine权限，让运行用户有权限操作指令
    if [ -e "${tengine_install_dir}" ]; then
        pushd ${tengine_install_dir}/sbin > /dev/null 
        chown -Rv root.${run_user} nginx
        chmod -Rv 750 nginx
        chmod -Rv u+s nginx
        chmod -R 777 ${tengine_install_dir}/conf
        popd > /dev/null
        if [ -e "${nginx_conf_backup_dir}" ]; then
            cp -rfv ${nginx_conf_backup_dir}/* ${tengine_install_dir}/conf/
            [ -z "`grep 'study\/\*\.conf;' ${tengine_install_dir}/conf/nginx.conf`" ] && sed -i "s@include\ vhost\/\*.conf;@include vhost/*.conf;\n  include work/*.conf;\n  include study/*.conf;@g" ${tengine_install_dir}/conf/nginx.conf
            chmod -R 777 ${tengine_install_dir}/conf/
        fi
    fi
}

OpenRestyDevConfig() {
    #修改openresty权限，让运行用户有权限操作指令
    if [ -e "${openresty_install_dir}" ];then
        pushd ${openresty_install_dir}/nginx/sbin > /dev/null 
        chown -Rv root.${run_user} nginx
        chmod -Rv 750 nginx
        chmod -Rv u+s nginx
        chmod -R 777 ${openresty_install_dir}/nginx/conf
        popd > /dev/null
        if [ -e "${nginx_conf_backup_dir}" ]; then
            cp -rfv ${nginx_conf_backup_dir}/* ${openresty_install_dir}/nginx/conf/
            [ -z "`grep 'study\/\*\.conf;' ${openresty_install_dir}/conf/nginx.conf`" ] && sed -i "s@include\ vhost\/\*.conf;@include vhost/*.conf;\n  include work/*.conf;\n  include study/*.conf;@g" ${openresty_install_dir}/nginx/conf/nginx.conf
            chmod -R 777 ${openresty_install_dir}/nginx/conf
        fi
    fi
}

WwwlogsDevConfig() {
    #日志目录开发配置
    if [ ! -d "${wwwlogs_dir}" ];then
        mkdir ${wwwlogs_dir}
        chown -Rv ${run_user}.root ${wwwlogs_dir}
    fi
}

PhpDevConfig() {
     #修改所有版本php配置文件权限为777方便用编辑器编辑
    php_dir=(`find /usr/local -maxdepth 1 -type d -name "php*" | sort`)

    if [ ${#php_dir[*]} -gt 0 ];then
        for i in ${!php_dir[@]};do echo
            chmod -Rv 777 ${php_dir[i]}/etc/
        done
        
        #首次运行设置php默认版本
        if [ ! -L "/usr/local/php" ];then
            ln -sv ${php_dir[i]} /usr/local/php
        fi
    fi
}