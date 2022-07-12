#!/bin/bash
Install_Webman() {
    pushd ${framework_dir} > /dev/null
    composer create-project workerman/webman
    pushd webman > /dev/null
    composer require webman/console -vvv
    composer require robmorgan/phinx -vvv
    composer require webman/cors -vvv
    composer require illuminate/events -vvv
    composer require illuminate/pagination -vvv
    composer require psr/container ^1.1.1 -vvv
    composer require illuminate/redis -vvv
    composer require symfony/cache -vvv
    composer require php-di/php-di -vvv
    composer require doctrine/annotations -vvv
    composer require hyperf/aop-integration:^1.1 -vvv
}