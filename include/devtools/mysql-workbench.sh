#!/bin/bash
Mysql_Workbench(){
    pushd ${oneinstack_dir}/src > /dev/null
    echo "Download Mysql-workbench..."
    src_url="https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_${mysql_workbench_ver}-1ubuntu${Ubuntu_Ver}_amd64.deb" && Download_src
    dpkg -i "mysql-workbench-community_${mysql_workbench_ver}-1ubuntu${Ubuntu_Ver}_amd64.deb"
    apt install -f
    popd > /dev/null
}