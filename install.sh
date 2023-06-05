#!/bin/bash
custom_dir=$(dirname "`readlink -f $0`")

# install devbase use costom agruments
bash ${custom_dir}/setup/install_devbase.sh --nginx_option 1  --apache --apache_mode_option 1 --apache_mpm_option 1 --php_option 12 --phpcache_option 1 --php_extensions imagickfileinforedismemcachedeventpARallelrdkafka --jdk_option 2 --db_option 1 --dbrootpwd 123456 --dbinstallmethod 1 --elastic_stack --pureftpd --redis --memcached --mq_option 1 --nodejs_method 2 --python_option 2 --go_option 1 --ffmpeg --docker

# install devtools use costom agruments
bash ${custom_dir}/setup/install_devtools.sh --openssh_server --switchhost --rdm --navicat_premium --mysql_workbench --remmina --wireshark --terminal_net_tools --postman --runapi --apifox --oss_browser --virtualbox --filezilla --jmeter --vscode --obs_studio --rabbitvcs_nautilus

# install devaddons use costom agruments
bash ${custom_dir}/setup/devaddons.sh --install --composer --ngx_lua_waf --supervisord --phpmyadmin

# install ubsoft use costom agruments
bash ${custom_dir}/setup/install_ubsoft.sh --input_method_option 2 --chrome --dingtalk --linuxqq --feishu --flameshot --indicator_sysmonitor --neteasy_cloudmusic --qqmusic --peek --qv2ray --theme_tools --bilibili_video_downloader --wps --custom --fceux --deepinwine