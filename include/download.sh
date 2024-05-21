#!/bin/bash
# Author:  yeho <lj2007331 AT gmail.com>
# BLOG:  https://linuxeye.com
#
# Notes: OneinStack for CentOS/RedHat 7+ Debian 8+ and Ubuntu 16+
#
# Project home page:
#       https://oneinstack.com
#       https://github.com/oneinstack/oneinstack

Download_src() {
  [ -s "${src_url##*/}" ] && echo "[${CMSG}${src_url##*/}${CEND}] found" || { wget --limit-rate=100M --tries=6 -c --no-check-certificate ${src_url}; sleep 1; }
  if [ ! -e "${src_url##*/}" ]; then
    echo "${CFAILURE}Auto download failed! You can manually download ${src_url} into the oneinstack/src directory.${CEND}"
    kill -9 $$; exit 1;
  else
    chown -R ${run_user}:${run_group} ${src_url##*/}
  fi
}

Check_Ubsoft_src() {
  if [ ! -e "${ubdevenv_dir}/src/ubsoft" ]; then
    mkdir ${ubdevenv_dir}/src/ubsoft
    chown -Rv ${run_user}:root ${ubdevenv_dir}/src/ubsoft
  fi
}

Check_Devtools_src() {
  if [ ! -e "${ubdevenv_dir}/src/devtools" ]; then
    mkdir ${ubdevenv_dir}/src/devtools
    chown -Rv ${run_user}:root ${ubdevenv_dir}/src/devtools
  fi
}

Check_Devbase_src() {
  if [ ! -e "${ubdevenv_dir}/src/devbase" ]; then
    mkdir ${ubdevenv_dir}/src/devbase
    chown -Rv ${run_user}:root ${ubdevenv_dir}/src/devbase
  fi
}

Check_Devbase_sub() {
   if [ -e "${ubdevenv_dir}/src/devbase" ]; then
    # 指定目录
    parent_dir="${ubdevenv_dir}/src/devbase"
    # 要创建的子目录名称列表
    sub_dirs=("python" "php" "golang" "nodejs" "erlang" "library" "webserver" "database" "multimedia")
    # 创建子目录
    for dir_name in "${sub_dirs[@]}"; do
        if [ ! -d "$parent_dir/$dir_name" ]; then
            mkdir -p "$parent_dir/$dir_name"
            chown -Rv ${run_user}:root "$parent_dir/$dir_name"
            echo "Created directory: $parent_dir/$dir_name"
        fi
    done
  fi
}