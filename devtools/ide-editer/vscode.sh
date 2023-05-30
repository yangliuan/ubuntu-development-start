#!/bin/bash
Install_Vscode() {
    url="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
    #发送cURL请求，检索下载链接的最终URL
    src_url=$(curl -sIL -o /dev/null -w '%{url_effective}' "$url")
    echo "$src_url"
    #将下载链接替换成中文cdn
    src_url="http://vscode.cdn.azure.cn/stable/${src_url#*stable/}"
    file_name="code_${src_url#*code_}"
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download vscode ..." && Download_src
    dpkg -i ${file_name}
    #rm -rfv ${file_name}
    popd > /dev/null
}

Uninstall_Vscode() {
   dpkg -P code
   apt-get autoclean
}

