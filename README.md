# ubuntu 开发环境安装脚本

集成Oneinstack Nvm Elasticsearch 和常用开发工具，快速搭建开发环境



### 脚本目录结构

```
├─ include
|  |─ devtools 开发工具
|  |  |─ filezilla.sh ftp客户端
|  |  |─ jmeter.sh 测试工具
|  |  |─ navicat_preminu.sh 数据库管理工具
|  |  |─ ossbrowser.sh 阿里云oss客户端工具
|  |  |─ postman.sh api测试工具
|  |  |─ redis_desktop_manager.sh redis客户端工具
|  |  |─ remmina.sh 远程终端工具
|  |  |─ runapi.sh 远程终端工具
|  |  |─ service_desktop.sh 发布服务快捷方式
|  |  |─ virtualbox.sh 虚拟机
|  |  |─ vscode.sh IDE
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
├─ addons.sh oneinstack 
├─ backup_setup.sh oneinstack
├─ backup.sh oneinstack
├─ install_devtools.sh 安装常用开发工具
├─ install_other.sh 安装elasticsearch,ffmpge
├─ install.sh 安装oneinstack包含的软件
├─ nvm.sh nvm安装脚本
├─ pureftpd_vhost.sh oneinstack
├─ reset_db_root_password.sh oneinstack
├─ uninstall.sh oneinstack
├─ upgrade.sh oneinstack
├─ vhost.sh oneinstack
```

### 使用方法
首先运行 sudo ./install.sh 安装开发环境服务 然后再运行其它脚本


### Thinks

[Oneinstack](https://github.com/oneinstack/oneinstack)

[Nvm](https://github.com/nvm-sh/nvm)

