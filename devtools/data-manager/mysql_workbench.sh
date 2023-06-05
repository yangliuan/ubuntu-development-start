#!/bin/bash
Install_MysqlWorkbench() {
    pushd ${ubdevenv_dir}/src > /dev/null
    echo "Download Mysql-workbench..."
    src_url="https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb" && Download_src
    dpkg -i "mysql-workbench-community_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb"
    apt-get -y install -f
    #rm -rfv "mysql-workbench-community-dbgsym_${mysql_workbench_ver}-1ubuntu${VERSION_ID}_amd64.deb"
    popd > /dev/null
}

# Build_MysqlWorkBench() {
#     pushd ${ubdevenv_dir}/src > /dev/null
#     if [ ! -e "mysql-workbench-8.0.33.tar.gz" ]; then
#         src_url="https://github.com/mysql/mysql-workbench/archive/refs/tags/${mysql_workbench_ver}.tar.gz" && Download_src
#         mv ${mysql_workbench_ver}.tar.gz mysql-workbench-8.0.33.tar.gz
#     fi
    
#     dpkg -l | grep -q iodbc && apt-get remove -y iodbc
#     mysql_workbench_dependency="libzip-dev libxml2-dev libsigc++-2.0-dev libglade2-dev libglu1-mesa-dev libgl1-mesa-glx mesa-common-dev libmysqlclient-dev libmysqlcppconn-dev uuid-dev libpixman-1-dev libpcre3-dev libpango1.0-dev libcairo2-dev python-dev libboost-dev mysql-client libsqlite3-dev swig libvsqlitepp-dev libgdal-dev libgtk-3-dev libgtkmm-3.0-dev libssl-dev libsecret-1-dev libproj-dev libant4"

#     for mw_dep in ${mysql_workbench_dependency}; do
#         apt-get install -y ${mw_dep}
#     done

#     src_url="https://github.com/antlr/website-antlr4/blob/gh-pages/download/antlr-4.7.2-complete.jar" && Download_src
    
#     tar -zxvf mysql-workbench-${mysql_workbench_ver}.tar.gz
#     pushd mysql-workbench-${mysql_workbench_ver} > /dev/null
#     cmake . -DCMAKE_INSTALL_PREFIX=/usr 
#     -DWITH_ANTLR_JAR=${ubdevenv_dir}/src/antlr-4.7.2-complete.jar
#     make -j ${THREAD} && make install
#     popd > /dev/nulld
#     popd > /dev/null
# }

Uninstall_MysqlWorkbench() {
    dpkg -P mysql-workbench-community
    apt-get -y autoremove
}



