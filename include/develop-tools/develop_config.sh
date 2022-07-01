#!/bin/bash
Set_Develop_Config(){
    #修改nginx权限，让运行用户有权限操作指令
    if [ -e "${nginx_install_dir}" ];then
        pushd ${nginx_install_dir}/sbin > /dev/null 
        chown -Rv root.${run_user} nginx
        chmod -Rv 750 nginx
        chmod -Rv u+s nginx
        popd > /dev/null
    fi

    #修改tengine权限，让运行用户有权限操作指令
    if [ -e "${tengine_install_dir}" ];then
        pushd ${tengine_install_dir}/sbin > /dev/null 
        chown -Rv root.${run_user} nginx
        chmod -Rv 750 nginx
        chmod -Rv u+s nginx
        popd > /dev/null
    fi

    #修改openresty权限，让运行用户有权限操作指令
    if [ -e "${openresty_install_dir}" ];then
        pushd ${openresty_install_dir}/nginx/sbin > /dev/null 
        chown -Rv root.${run_user} nginx
        chmod -Rv 750 nginx
        chmod -Rv u+s nginx
        popd > /dev/null
    fi

    #修改所有版本php配置文件权限为777方便用编辑器编辑
    php_dir=(`find /usr/local -maxdepth 1 -type d -name "php*" | sort`)
    for i in ${!php_dir[@]};do echo
        chmod -Rv 777 ${php_dir[i]}/etc/
    done
    

    #首次运行设置php默认版本
    if [ ! -L "/usr/local/php" ];then
        ln -sv ${php_dir[i]} /usr/local/php
    fi
}
