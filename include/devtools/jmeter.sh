#!/bin/bash
Install_Jmeter(){
    pushd ${oneinstack_dir}/src > /dev/null

    echo "Download jmeter ..."
    src_url="https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${jmeter_ver}.zip" && Download_src
    unzip apache-jmeter-${jmeter_ver}.zip
    
}