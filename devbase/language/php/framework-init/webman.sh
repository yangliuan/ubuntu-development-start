#!/bin/bash
Install_Webman() {

    pushd ${framework_dir} > /dev/null
    composer create-project workerman/webman
    pushd webman > /dev/null
    sed -i "s@'controller_suffix' => ''@'controller_suffix' => 'Controller'@" ./config/app.php
    cp -rfv ${ubdevenv_dir}/include/language/php/framework-init/webman-config/database.php ./config/database.php
    composer require psr/container ^1.1.1 php-di/php-di doctrine/annotations -vvv
    composer require friendsofphp/php-cs-fixer --dev -vvv
    cp -rfv ${ubdevenv_dir}/include/language/php/framework-init/webman-config/webman.php-cs-fixer.php ./.php-cs-fixer.php
    composer require kriss/webman-eloquent-ide-helper --dev -vvv
    composer require robmorgan/phinx -W -vvv
    composer require fakerphp/faker --dev -vvv

    if [[ ! -d "${framework_dir}/webman/database" ]]; then
        mkdir ${framework_dir}/webman/database
        mkdir ${framework_dir}/webman/database/migrations
        mkdir ${framework_dir}/webman/database/seeds
    fi

    composer require vlucas/phpdotenv -vvv
    cp -rfv ${ubdevenv_dir}/include/language/php/framework-init/webman-config/env.webman ./.env
    composer require webman/console -vvv
    cp -rfv ${ubdevenv_dir}/include/language/php/framework-init/webman-config/phinx.php ./
    composer require webman/cors -vvv
    composer require illuminate/database -vvv
    composer require illuminate/pagination -vvv
    composer require illuminate/collections -vvv
    composer require illuminate/events -vvv
    composer require symfony/var-dumper -vvv
    composer require illuminate/redis -vvv
    composer require symfony/cache -vvv

    cat >> ./.gitignore <<EOF
public/uploads
.php-cs-fixer.cache
EOF

    php webman ide-helper:models

}