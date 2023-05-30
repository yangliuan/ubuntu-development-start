#!/bin/bash
# 定义函数：读取指定目录下所有扩展名为.sh的脚本文件，并将其作为可执行文件运行
Source_Shells() {
    for file in "${shell_dir}"/*.sh; do
        echo "Processing: ${file}"
        if [ -r "${file}" ]; then
            # 运行该文件中的代码
            . "${file}"
        fi
    done
}
