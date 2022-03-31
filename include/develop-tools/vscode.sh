#!/bin/bash
Install_Vscode() {
    src_url=$(/usr/local/php/bin/php ./include/develop-tools/get_redirect_url.php)
    src_url="http://vscode.cdn.azure.cn/stable/${src_url#*stable/}"
    file_name="code_${src_url#*code_}"
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download vscode ..." && Download_src
    dpkg -i ${file_name}
    rm -rfv ${file_name}
    popd > /dev/null
}

Unstall_Vscode() {
   dpkg -P code
   apt-get autoclean
}