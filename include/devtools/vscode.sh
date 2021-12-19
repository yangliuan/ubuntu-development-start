#!/bin/bash
Install_Vscode(){
    src_url=$(/usr/local/php/bin/php ./include/devtools/get_redirect_url.php)
    src_url="http://vscode.cdn.azure.cn/stable/${src_url#*stable/}"
    pushd ${oneinstack_dir}/src > /dev/null
    Download_src
    echo "Download vscode ..."
    popd > /dev/null
}