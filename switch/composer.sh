#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/local/php/bin:
clear
printf "
#######################################################################
                         switch composer version
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

if [[ ! ${composer_option} =~ ^[0-9]$|^6$ ]]; then
  echo "input error! Please only input number 0~${i}:"
fi

cp ${composer_dir[${composer_option}]} /usr/local/bin/composer
chown yangliuan.root /usr/local/bin/composer
chmod u+x /usr/local/bin/composer
php -v
echo
composer -V
echo 'switch composer success!'

#change composer mirrors
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
composer config -g -l