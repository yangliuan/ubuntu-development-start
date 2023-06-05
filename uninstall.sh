#!/bin/bash
custom_dir=$(dirname "`readlink -f $0`")

# uninstall ubsoft use costom agruments
bash ${custom_dir}/setup/uninstall_ubsoft.sh --deepinwine --dingtalk --linuxqq --feishu --neteasy_cloudmusic --qqmusic --peek --fceux

# install devaddons use costom agruments
bash ${custom_dir}/setup/devaddons.sh --uninstall --composer --supervisord --phpmyadmin

# uninstall ubsoft use costom agruments
bash ${custom_dir}/setup/uninstall_devbase.sh -q --all

# uninstall devtools use costom agruments
bash ${custom_dir}/setup/uninstall_devtools.sh --openssh_server --switchhost --rdm --navicat_premium --mysql_workbench --remmina --wireshark --terminal_net_tools --postman --runapi --apifox --oss_browser --filezilla --jmeter --obs_studio --rabbitvcs_nautilus

