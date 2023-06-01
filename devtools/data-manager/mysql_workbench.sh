#!/bin/bash
Install_MysqlWorkbench() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download Mysql-workbench..."
    #https://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-community-dbgsym_8.0.33-1ubuntu22.04_amd64.deb
    src_url="https://cdn.mysql.com/Downloads/MySQLGUITools/mysql-workbench-community-dbgsym_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb" && Download_src
    dpkg -i "mysql-workbench-community-dbgsym_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb"
    apt-get -y install -f
    #rm -rfv "mysql-workbench-community-dbgsym_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb"
    popd > /dev/null
}

Uninstall_MysqlWorkbench() {
    dpkg -P mysql-workbench-community
    apt-get -y autoremove
}