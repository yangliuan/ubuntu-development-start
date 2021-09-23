#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:
clear
printf "
#######################################################################
#       OneinStack for CentOS/RedHat 6+ Debian 8+ and Ubuntu 14+      #
#       For more information please visit https://oneinstack.com
#       switch composer version
#######################################################################
"
# Check if user is root
[ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; }

# choice composer
composer_dir=(`find /opt/oneinstack/composer -maxdepth 1 -type f -name "composer*" | sort`)
echo
echo 'Please select a version of the composer:'

for i in ${!composer_dir[@]};do echo
echo $i ${composer_dir[i]}
done

echo
read -e -p "Please input a number :" composer_option

if [[ ! ${composer_option} =~ ^[0-1]$|^6$ ]]; then
  echo "input error! Please only input number 0~1:"
fi

cp ${composer_dir[${composer_option}]} /usr/local/bin/composer
chown yangliuan.root /usr/local/bin/composer
/usr/local/php/bin/php -v
echo
/usr/local/php/bin/php /usr/local/bin/composer -V
echo 'switch composer success!'