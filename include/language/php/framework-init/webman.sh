#!/bin/bash
Install_Webman() {
    pushd ${framework_dir} > /dev/null
    composer create-project workerman/webman
    pushd webman > /dev/null
    composer require friendsofphp/php-cs-fixer --dev -vvv
    cp -r ${oneinstack_dir}/include/language/php/framework-init/config/webman.php-cs-fixer.php ./.php-cs-fixer.php
    composer require webman/console -vvv
    composer require robmorgan/phinx -vvv
    cp -r ${oneinstack_dir}/include/language/php/framework-init/config/phinx.php ./
    composer require webman/cors -vvv
    composer require illuminate/events -vvv
    composer require illuminate/pagination -vvv
    composer require illuminate/collections -vvv
    composer require illuminate/redis -vvv
    composer require psr/container ^1.1.1 -vvv
    composer require symfony/cache -vvv
    composer require php-di/php-di -vvv
    composer require doctrine/annotations -vvv
}