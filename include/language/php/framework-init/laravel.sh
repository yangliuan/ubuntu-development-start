#!/bin/bash
Install_Laravel() {
    pushd $framework_dir
    composer create-project laravel/laravel
    pushd laravel
    composer require yangliuan/laravel-devstart --dev -vvv
}