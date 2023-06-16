#!/bin/bash
version() {
  echo "version: 1.0"
  echo "updated date: 2023-06-01"
}

Show_Ubsoft_Help() {
  version
  echo "Usage: $0  command ...[parameters]....
  --help, -h                  Show this help message
  --version, -v               Show version info
  --driver                    install driver
  --input_method_option[1-3]  input method googlepin sogoupin baidupin       
  --baidunetdisk              baidu network disk
  --chrome                    chrome broswer
  --deepinwine                deepin software wechat qq...
  --dingtalk                  alibaba dingtalk IM tool
  --linuxqq                   tencent qq for linux IM tool
  --feishu                    byte dance office tool
  --flameshot                 screentshot
  --indicator_sysmonitor      taskbar system monitoring
  --indicator_stickynotes     note tool
  --lantern                   science online
  --neteasy_cloudmusic        music platform
  --qqmusic                   music platform
  --peek                      screenshot for video
  --qv2ray                    science online
  --sougoupinyin              sougou input
  --sunlogin                  remote control tool
  --theme_tools               ubuntu theme tools
  --bilibili_video_downloader bilibili video downloader
  --wps                       wps office
  --xDroid                    android runtime
  --conky                     conky
  --my_weather_indicator      weather indicator
  --custom                    config options install custom software
  --fceux                     fceux game simulator
  --reboot                    reboot system
  "
}

Show_Devbase_Help() {
  version
  echo "Usage: $0  command ...[parameters]....
  --help, -h                  Show this help message, More: https://oneinstack.com/auto
  --version, -v               Show version info
  --nginx_option [1-3]        Install Nginx server version
  --apache                    Install Apache
  --apache_mode_option [1-2]  Apache2.4 mode, 1(default): php-fpm, 2: mod_php
  --apache_mpm_option [1-3]   Apache2.4 MPM, 1(default): event, 2: prefork, 3: worker
  --php_option [1-12]         Install PHP version
  --mphp_ver [53~81]          Install another PHP version (PATH: ${php_install_dir}\${mphp_ver})
  --mphp_addons               Only install another PHP addons
  --phpcache_option [1-4]     Install PHP opcode cache, default: 1 opcache
  --php_extensions [ext name] Install PHP extensions, include zendguardloader,ioncube,
                              sourceguardian,imagick,gmagick,fileinfo,imap,ldap,calendar,phalcon,
                              yaf,yar,redis,memcached,memcache,mongodb,swoole,event,xdebug,yasd
  --tomcat_option [1-4]       Install Tomcat version
  --jdk_option [1-2]          Install JDK version
  --db_option [1-14]          Install DB version
  --dbinstallmethod [1-2]     DB install method, default: 1 binary install
  --dbrootpwd [password]      DB super password
  --elastic_stack             Elastic stack
  --pureftpd                  Install Pure-Ftpd
  --redis                     Install Redis
  --memcached                 Install Memcached
  --mq_option[1-3]            Install Message Queue
  --nodejs_method[1-2]        Install Nodejs
  --python_option[1-2]        Install Python
  --go_option [1-4]           Install Go version
  --ffmpeg                    Install FFmpeg
  --docker                    Docker stack
  --ssh_port [No.]            SSH port
  --firewall                  Enable firewall
  --reboot                    Restart the server after installation
  "
}

Show_Devtools_Help() {
  version
  echo "Usage: $0  command ...[parameters]....
  --help, -h
  --version, -v 
  --switchhost
  --rdm
  --navicat_premium
  --mysql_workbench
  --remmina
  --wireshark
  --terminal_net_tools
  --postman
  --runapi
  --apifox
  --oss_browser
  --virtualbox
  --filezilla
  --jmeter
  --vscode
  --cursor
  --obs_studio
  --rabbitvcs_nautilus
  "
}

Show_Devaddons_Help() {
  version
  echo
  echo "Usage: $0  command ...
  --help, -h                  Show this help message
  --install, -i               Install
  --uninstall, -u             Uninstall
  --composer                  Composer
  --fail2ban                  Fail2ban
  --ngx_lua_waf               Ngx_lua_waf
  --supervisord               Supervisord
  --phpmyadmin                PhpMyAdmin
  "
}