#!/bin/bash
Install_FileZilla(){
    pushd ${oneinstack_dir}/src > /dev/null
    
    echo "Download filezilla ftp client ..."
    src_url="http://mirror.yangliuan.cn/FileZilla_${filezilla_ver}_x86_64-linux-gnu.tar.bz2" && Download_src
    tar -jxvf FileZilla_${filezilla_ver}_x86_64-linux-gnu.tar.bz2
    mv -fv FileZilla3 /opt/filezilla3
    cp -rfv ${oneinstack_dir}/desktop/filezilla3.desktop /usr/share/applications/
    chown -Rv ${run_user}.${run_group} /opt/filezilla3
    chmod -Rv 755 /opt/filezilla3

    popd > /dev/null
}