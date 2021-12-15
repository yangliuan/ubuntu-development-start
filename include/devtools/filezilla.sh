#!/bin/bash
Install_FileZilla(){
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download filezilla ftp client ..."
    src_url="https://dl2.cdn.filezilla-project.org/client/FileZilla_3.57.0_x86_64-linux-gnu.tar.bz2?h=h0uJPV3og0sqFAmLl7LSvg&x=1639505245" && Download_src
}