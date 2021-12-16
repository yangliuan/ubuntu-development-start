#!/bin/bash
Install_FileZilla(){
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download filezilla ftp client ..."
    src_url="https://download.filezilla.cn/client/linux/FileZilla_3.56.0_i686-linux-gnu.tar.bz2" && Download_src
}