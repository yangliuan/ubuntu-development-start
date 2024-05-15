#!/bin/bash
Install_MysqlWorkbench() {
    pushd ${ubdevenv_dir}/src/devtools > /dev/null
    echo "Download Mysql-workbench..."
    src_url="https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb" && Download_src
    dpkg -i "mysql-workbench-community_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb"
    #libmysqlclient21 libpcrecpp0v5 libproj22 libzip4 mysql-common proj-data
    apt-get install -y -f
    popd > /dev/null
}

Uninstall_MysqlWorkbench() {
    apt-get autoremove -y mysql-workbench-community
}