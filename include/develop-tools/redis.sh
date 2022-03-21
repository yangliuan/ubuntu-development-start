#!/bin/bash
Redis(){
    redis_dir=(`find /usr/local -maxdepth 1 -type d -name "redis*" | sort`)
    echo
    echo 'Please select a version of the redis:'

    for i in ${!redis_dir[@]};do echo
    echo $i ${redis_dir[i]}
    done

    # choice redis
    echo
    read -e -p "Please input a number :" redis_option

    if [[ ! ${redis_option} =~ ^[0-6]$|^6$ ]]; then
      echo "input error! Please only input number 0~6:"
    fi

    echo
    service redis-server stop
    echo
    rm -rf /usr/local/redis
    ln -s ${redis_dir[${redis_option}]} /usr/local/redis
    echo
    redis-server -v
    #echo
    echo
    service redis-server start
    service redis-server status
    echo
    echo 'switch redis-server success!'
}
