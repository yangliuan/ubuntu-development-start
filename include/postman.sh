#!/bin/bash
Install_Postman(){
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download postman ..."
    src_url=https://dl.pstmn.io/download/latest/linux64 && Download_src
}