#!/bin/bash
custom_dir=$(dirname "`readlink -f $0`")

# uninstall ubsoft use costom agruments
bash ${custom_dir}/setup/uninstall_ubsoft.sh --deepinwine --dingtalk --linuxqq --feishu --neteasy_cloudmusic --qqmusic --peek --custom

# uninstall ubsoft use costom agruments
bash ${custom_dir}/setup/uninstall_devbase.sh --web --mysql --postgresql --mongodb --sqlite --redis --memcached --elastic_stack --allmq --allphp --pureftpd --supervisord --ffmpeg --nodejs_env --python_env --go_env --docker

# uninstall devtools use costom agruments
bash ${custom_dir}/setup/uninstall_devtools.sh --openssh_server --switchhost --rdm --navicat_premium --mysql_workbench --remmina --wireshark --terminal_net_tools --postman --runapi --apifox --oss_browser --virtualbox --filezilla --jmeter --obs_studio --rabbitvcs_nautilus

# install devaddons use costom agruments
bash ${custom_dir}/setup/devaddons.sh --uninstall --composer --ngx_lua_waf --supervisord --phpmyadmin
