#!/bin/bash
custom_dir=$(dirname "`readlink -f $0`")

# uninstall ubsoft use costom agruments
bash ${custom_dir}/setup/uninstall_ubsoft.sh --deepinwine --dingtalk --linuxqq --feishu --neteasy_cloudmusic --qqmusic --peek --custom