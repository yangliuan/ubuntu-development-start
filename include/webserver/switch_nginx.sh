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
    
    systemctl stop nginx.service

    #更新systemd配置文件
    rm -rf /lib/systemd/system/nginx.service
    /bin/cp ${oneinstack_dir}/init.d/nginx.service /lib/systemd/system/
    

    case "${nginx_option}" in
    0)
      sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /lib/systemd/system/nginx.service
      enable_nginxenv
      disable_openrestryenv
      disable_tengineenv
      ;;
    1)
      sed -i "s@/usr/local/nginx@${openresty_install_dir}/nginx@g" /lib/systemd/system/nginx.service
      disbale_nginxenv
      enable_openrestryenv
      disable_tengineenv
      ;;
    2)
      sed -i "s@/usr/local/nginx@${tengine_install_dir}@g" /lib/systemd/system/nginx.service
      disbale_nginxenv
      disable_openrestryenv
      enable_tengineenv
      ;;
    esac

    . /etc/profile
    nginx -v
    
    systemctl daemon-reload
    systemctl start nginx.service
    systemctl status nginx.service
}

enable_nginxenv() {
  [ -e "/etc/profile.d/nginx.disable" ] && mv /etc/profile.d/nginx.disable /etc/profile.d/nginx.sh
}

disbale_nginxenv() {
  [ -e "/etc/profile.d/nginx.sh" ] && mv /etc/profile.d/nginx.sh /etc/profile.d/nginx.disable
}

enable_openrestryenv() {
  [ -e "/etc/profile.d/openrestry.disable" ] && mv /etc/profile.d/openrestry.disable /etc/profile.d/openrestry.sh
}

disable_openrestryenv() {
  [ -e "/etc/profile.d/openrestry.sh" ] && mv /etc/profile.d/openrestry.sh /etc/profile.d/openrestry.disable
}

enable_tengineenv() {
  [ -e "/etc/profile.d/tengine.disable" ] && mv /etc/profile.d/tengine.disable /etc/profile.d/tengine.sh
}

disable_tengineenv() {
  [ -e "/etc/profile.d/tengine.sh" ] && mv /etc/profile.d/tengine.sh /etc/profile.d/tengine.disable
}