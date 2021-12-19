# ubuntu 开发环境安装脚本

集成Oneinstack Nvm Elasticsearch 和常用开发工具，快速搭建开发环境



## 脚本目录结构

```
├─ addons.sh oneinstack 
├─ backup_setup.sh oneinstack
├─ backup.sh oneinstack
├─ devtools.sh 常用开发工具
├─ elasticsearch.sh elasticsearch安装脚本
├─ install.sh oneinstack安装脚本
├─ nvm.sh nvm安装脚本
├─ pureftpd_vhost.sh oneinstack
├─ reset_db_root_password.sh oneinstack
├─ uninstall.sh oneinstack
├─ upgrade.sh oneinstack
├─ vhost.sh oneinstack
├─ start 启动服务
│  ├─ elasticsearch_start.sh 启动 elasticsearch
│  ├─ httpd_start.sh 启动 apache
│  ├─ lnmp_start.sh 启动 lnmp
│  ├─ mysql_start.sh 启动 mysql
│  ├─ nginx_start.sh 启动 nginx
│  ├─ php-fpm_start.sh 启动 php-fpm
│  ├─ redis_start.sh 启动 redis_start
├─ switch 切换版本
│  ├─ composer.sh 切换composer版本
│  ├─ php.sh 切换php版本
│  ├─ redis.sh 切换redis版本

```


## Thinks

[Oneinstack](https://github.com/oneinstack/oneinstack)

[Nvm](https://github.com/nvm-sh/nvm)

