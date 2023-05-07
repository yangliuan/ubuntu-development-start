#!/bin/bash
#https://sqlite.org/howtocompile.html
#https://sqlite.org/download.html
#https://github.com/sqlite/sqlite
Install_Sqlite3() {
    pushd ${oneinstack_dir}/src > /dev/null
    src_url=https://sqlite.org/2023/sqlite-autoconf-${sqlite3_ver}.tar.gz && Download_src
    tar -zxvf sqlite-autoconf-${sqlite3_ver}.tar.gz
    pushd sqlite-autoconf-${sqlite3_ver} > /dev/null
    ./configure
    make -j ${THREAD}
    make install
    
    if [ -e "/usr/local/bin/sqlite3" ]; then
        . /etc/profile
        rm -rf sqlite-autoconf-${sqlite3_ver}
        echo "${CSUCCESS}Sqlite3 installed successfully! ${CEND}"
    else
        echo "${CFAILURE}Sqlite3 install failed, Please Contact the author! ${CEND}"
        kill -9 $$; exit 1;
    fi

    popd > /dev/null
    popd > /dev/null
}

Uninstall_Sqlite3() {
    rm -rfv /usr/local/bin/sqlite3 
    rm -rfv /usr/local/include/sqlite3.h
    rm -rfv /usr/local/include/sqlite3ext.h 
    rm -rfv /usr/local/lib/libsqlite3.a 
    rm -rfv /usr/local/lib/libsqlite3.la 
    rm -rfv /usr/local/lib/libsqlite3.so 
    rm -rfv /usr/local/lib/libsqlite3.so.0 
    rm -rfv /usr/local/lib/libsqlite3.so.0.8.6
}