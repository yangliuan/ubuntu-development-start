#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
#       OneinStack for CentOS/RedHat 6+ Debian 8+ and Ubuntu 14+      #
#       For more information please visit https://oneinstack.com
#       switch php version
#######################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

# choice php
php_dir=(`find /usr/local -maxdepth 1 -type d -name "php*" | sort`)
echo
echo 'Please select a version of the PHP:'

for i in ${!php_dir[@]};do echo
echo $i ${php_dir[i]}
done

echo
read -e -p "Please input a number :" php_option

if [[ ! ${php_option} =~ ^[0-6]$|^6$ ]]; then
  echo "input error! Please only input number 0~6:"
fi

#echo ${php_dir[${php_option}]}
echo
rm -rf /usr/local/php
ln -s ${php_dir[${php_option}]} /usr/local/php
echo
/usr/local/php/bin/php -v
#echo
echo
service php-fpm restart
service php-fpm status
echo
echo 'switch php success!'