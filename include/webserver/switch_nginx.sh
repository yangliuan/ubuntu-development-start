#!/bin/bash
#切换nginx
Switch_Nginx() {
    #定义镜像数组
    nginx_arr[0]="nginx"
    nginx_arr[1]="openresty"
    nginx_arr[2]="tengine"

    for i in ${!nginx_arr[@]};do echo
        echo $i ${nginx_arr[i]}
    done

    #获取输入的nginx序号
    echo
    read -e -p "Please input a number :" nginx_option
    if [[ ! ${nginx_option} =~ ^[0-9]$|^6$ ]]; then
        echo "input error! Please only input number 0~${i}:"
    fi
    
    #更新systemd配置文件
    rm -rf /lib/systemd/system/nginx.service
    /bin/cp ${oneinstack_dir}/init.d/nginx.service /lib/systemd/system/
    
    #环境变量中原有的路径替换为空
    sed -i "s@${nginx_install_dir}/sbin:@@g" /etc/profile
    sed -i "s@${openresty_install_dir}/nginx/sbin:@@g" /etc/profile
    sed -i "s@${tengine_install_dir}/sbin:@@g" /etc/profile

    case "${nginx_option}" in
    0)
      sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /lib/systemd/system/nginx.service
      [ -z "`grep ^'export PATH=' /etc/profile`" ] && echo "export PATH=${nginx_install_dir}/sbin:\$PATH" >> /etc/profile
      [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep ${nginx_install_dir} /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${nginx_install_dir}/sbin:\1@" /etc/profile
      . /etc/profile
      ;;
    1)
      sed -i "s@/usr/local/nginx@${openresty_install_dir}/nginx@g" /lib/systemd/system/nginx.service
      [ -z "`grep ^'export PATH=' /etc/profile`" ] && echo "export PATH=${openresty_install_dir}/nginx/sbin:\$PATH" >> /etc/profile
      [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep ${openresty_install_dir} /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${openresty_install_dir}/nginx/sbin:\1@" /etc/profile
      . /etc/profile
      ;;
    2)
      sed -i "s@/usr/local/nginx@${tengine_install_dir}@g" /lib/systemd/system/nginx.service
      [ -z "`grep ^'export PATH=' /etc/profile`" ] && echo "export PATH=${tengine_install_dir}/sbin:\$PATH" >> /etc/profile
      [ -n "`grep ^'export PATH=' /etc/profile`" -a -z "`grep ${tengine_install_dir} /etc/profile`" ] && sed -i "s@^export PATH=\(.*\)@export PATH=${tengine_install_dir}/sbin:\1@" /etc/profile
      . /etc/profile
      ;;
    esac

    nginx -v
    
    systemctl daemon-reload
    systemctl start nginx.service
    systemctl status nginx.service
}