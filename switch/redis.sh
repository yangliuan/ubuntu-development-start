#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
#       OneinStack for CentOS/RedHat 6+ Debian 8+ and Ubuntu 14+      #
#       For more information please visit https://oneinstack.com
#       switch redis version
#######################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

# choice redis
redis_dir=(`find /usr/local -maxdepth 1 -type d -name "redis*" | sort`)
echo
echo 'Please select a version of the redis:'

for i in ${!redis_dir[@]};do echo
echo $i ${redis_dir[i]}
done

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