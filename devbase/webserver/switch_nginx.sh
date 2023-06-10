#!/bin/bash
#切换nginx
Switch_Nginx() {
    #定义nginx数组
    nginx_arr=()
    [ -e "${nginx_install_dir}/sbin/nginx" ] && nginx_arr[0]="nginx"
    [ -e "${tengine_install_dir}/sbin/nginx" ] && nginx_arr[1]="openresty"
    [ -e "${openresty_install_dir}/nginx/sbin/nginx" ] && nginx_arr[2]="tengine"

    for i in ${!nginx_arr[@]};do echo
        echo $i ${nginx_arr[i]}
    done

    #获取输入的nginx序号
    echo
    read -e -p "Please input a number :" nginx_option
    if [[ ! ${nginx_option} =~ ^[0-9]$|^6$ ]]; then
        echo "input error! Please only input number 0~${i}:"
    fi
    
    stop_nginx_service

    #更新systemd配置文件
    rm -rf /lib/systemd/system/nginx.service
    /bin/cp ${ubdevenv_dir}/init.d/nginx.service /lib/systemd/system/
    

    case "${nginx_option}" in
    0)
      sed -i "s@/usr/local/nginx@${nginx_install_dir}@g" /lib/systemd/system/nginx.service
      enable_nginxenv
      disable_openrestyenv
      disable_tengineenv
      ;;
    1)
      sed -i "s@/usr/local/nginx@${openresty_install_dir}/nginx@g" /lib/systemd/system/nginx.service
      disbale_nginxenv
      enable_openrestyenv
      disable_tengineenv
      ;;
    2)
      sed -i "s@/usr/local/nginx@${tengine_install_dir}@g" /lib/systemd/system/nginx.service
      disbale_nginxenv
      disable_openrestyenv
      enable_tengineenv
      ;;
    esac

    . /etc/profile
    nginx -v
    
    systemctl daemon-reload
}

stop_nginx_service() {
  # 检查 Nginx 服务状态
  if systemctl is-active --quiet nginx.service; then
      #echo "正在停止 Nginx 服务..."
      # 使用 systemctl 停止 Nginx 服务
      sudo systemctl stop nginx.service
  fi

  # 检查 Nginx 进程状态
  if pgrep -x nginx > /dev/null; then
      #echo "强制杀死 Nginx 进程..."
      # 使用 killall 命令强制杀死 Nginx 进程
      sudo killall -9 nginx
  fi
}

enable_nginxenv() {
  [ -e "/etc/profile.d/nginx.disable" ] && sudo mv /etc/profile.d/nginx.disable /etc/profile.d/nginx.sh
}

disbale_nginxenv() {
  [ -e "/etc/profile.d/nginx.sh" ] && sudo mv /etc/profile.d/nginx.sh /etc/profile.d/nginx.disable
}

enable_openrestyenv() {
  [ -e "/etc/profile.d/openresty.disable" ] && sudo mv /etc/profile.d/openresty.disable /etc/profile.d/openresty.sh
}

disable_openrestyenv() {
  [ -e "/etc/profile.d/openresty.sh" ] && sudo mv /etc/profile.d/openresty.sh /etc/profile.d/openresty.disable
}

enable_tengineenv() {
  [ -e "/etc/profile.d/tengine.disable" ] && sudo mv /etc/profile.d/tengine.disable /etc/profile.d/tengine.sh
}

disable_tengineenv() {
  [ -e "/etc/profile.d/tengine.sh" ] && sudo mv /etc/profile.d/tengine.sh /etc/profile.d/tengine.disable
}