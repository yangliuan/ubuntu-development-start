#!/bin/bash
Set_DevConfig(){
    #修改nginx权限，让运行用户有权限操作指令
    if [ -e "${nginx_install_dir}" ];then
        pushd ${nginx_install_dir}/sbin > /dev/null 
        chown root.${run_user} nginx
        chmod 750 nginx
        chmod u+s nginx
        popd > /dev/null
    fi

    #修改tengine权限，让运行用户有权限操作指令
    if [ -e "${tengine_install_dir}" ];then
        pushd ${tengine_install_dir}/nginx/sbin > /dev/null 
        chown root.${run_user} nginx
        chmod 750 nginx
        chmod u+s nginx
        popd > /dev/null
    fi

    #修改openresty权限，让运行用户有权限操作指令
    if [ -e "${openresty_install_dir}" ];then
        pushd ${openresty_install_dir}/nginx/sbin > /dev/null 
        chown root.${run_user} nginx
        chmod 750 nginx
        chmod u+s nginx
        popd > /dev/null
    fi

    #设置php默认版本
    source ${oneinstack_dir}/switch/php.sh

    #修改所有版本php配置文件权限为777方便用编辑器编辑
}
