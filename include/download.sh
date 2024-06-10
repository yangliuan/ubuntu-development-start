#!/bin/bash
# Download_src_old() {
#   [ -s "${src_url##*/}" ] && echo "[${CMSG}${src_url##*/}${CEND}] found" || { wget --limit-rate=100M --tries=6 -c --no-check-certificate ${src_url}; sleep 1; }
#   if [ ! -e "${src_url##*/}" ]; then
#     echo "${CFAILURE}Auto download failed! You can manually download ${src_url} into the src directory.${CEND}"
#     kill -9 $$; exit 1;
#   else
#     chown -R ${run_user}:${run_group} ${src_url##*/}
#   fi
# }

# Function to download a file
Download_src() {
  # 提取文件名
  filename_ex=$(basename "${src_url%%\?*}")
  echo "full filename:"$filename_ex

  # 检查文件是否存在且非空，如果存在则输出提示信息，否则下载文件
  [ -s "$filename_ex" ] && echo "[${CMSG}$filename_ex${CEND}] found" || { wget --limit-rate=100M --tries=3 -c --no-check-certificate ${src_url} -O "$filename_ex"; sleep 1; }
  
  if [[ "$filename_ex" == *.tar.* ]]; then
    filename="${filename_ex%.tar.*}"
  elif [[ "$filename_ex" == *.zip || "$filename_ex" == *.rar || "$filename_ex" == *.gz || "$filename_ex" == *.bz2 || "$filename_ex" == *.xz || "$filename_ex" == *.7z || "$filename_ex" == *.z || "$filename_ex" == *.lzma || "$filename_ex" == *.lzo ]]; then
    filename="${filename_ex%.*}"
  elif [[ "$filename_ex" == *.* ]]; then
    filename="${filename_ex}"
  else
    filename="$filename_ex"
  fi
  echo "without extension filename:"$filename
 
  # 如果下载失败（文件不存在），输出错误信息并终止脚本
  if [ ! -e "$filename_ex" ]; then
    echo "${CFAILURE}Auto download failed! You can manually download ${src_url} into the src directory.${CEND}"
    kill -9 $$; exit 1;
  else
    # 下载成功后，更改文件所有者
    chown -R ${run_user}:${run_group} "$filename_ex"
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