#!/bin/bash
#https://sqlite.org/howtocompile.html
#https://sqlite.org/download.html
#https://github.com/sqlite/sqlite
Install_Sqlite3() {
    pushd ${ubdevenv_dir}/src/devbase/database > /dev/null
    src_url=https://sqlite.org/2023/sqlite-autoconf-${sqlite3_ver}.tar.gz && Download_src
    tar -zxvf sqlite-autoconf-${sqlite3_ver}.tar.gz
    pushd sqlite-autoconf-${sqlite3_ver} > /dev/null
    ./configure
    make -j ${THREAD} && make install
    popd > /dev/null

    if [ -e "/usr/local/bin/sqlite3" ]; then
        . /etc/profile
        rm -rf sqlite-autoconf-${sqlite3_ver}
        echo "${CSUCCESS}Sqlite3 installed successfully! ${CEND}"
    else
        echo "${CFAILURE}Sqlite3 install failed, Please Contact the author! ${CEND}"
        kill -9 $$; exit 1;
    fi

    popd > /dev/null
}

Uninstall_Sqlite3() {
    rm -rfv /usr/local/bin/sqlite3 
    rm -rfv /usr/local/include/sqlite3.h /usr/local/include/sqlite3ext.h 
    
    pushd /usr/local/lib > /dev/null
    rm -rfv libsqlite3.a libsqlite3.la libsqlite3.so libsqlite3.so.0 libsqlite3.so.0.8.6
    popd > /dev/null
}