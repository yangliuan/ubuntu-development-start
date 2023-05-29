# Ubuntu Desktop 22.04 Development Environment Script
[简体中文](README.md) | English

This project is a fork based on [Oneinstack](https://github.com/oneinstack/oneinstack), integrating many software and development environments, suitable for users who prefer Ubuntu Desktop system for development.

### Usage

```shell
cd /opt

git clone git@github.com:yangliuan/ubuntu-development-start.git oneinstack

修改 options.conf 配置文件，将run_user和run_group改成自己的用户，自定义目录和常用软件

versions.txt 软件版本配置文件

sudo ./install_ubsoft.sh 安装ubuntu常用软件

sudo ./install_base.sh 安装开发环境

sudo ./install_devtools.sh 安装开发工具

sudo ./devaddons.sh 安装开发组件

sudo ./switch_env.sh 切换环境，可以切换php版本，php扩展，composer版本，composer镜像，nginx发行版
```

### Interactive Installation Example
```shell
sudo ./install_ubsoft.sh

```


### Custom Parameter Installation Example
```shell
sudo ./install_ubsoft.sh --input_method_option 2 --baidunetdisk --chrome --deepinwine --dingtalk --linuxqq --feishu --flameshot --indicator_sysmonitor --lantern --neteasy_cloudmusic --qqmusic --peek --qv2ray --sunlogin --theme_tools --bilibili_video_downloader --wps --conky --custome
```

### Switching development environment Example
```shell
#switch php extension

sudo /opt/oneinstack/switch_env.sh --php_extension

#######################################################################
                      Switch Develop Environment
#######################################################################

0 /usr/local/php/etc/php.d/event.ini

1 /usr/local/php/etc/php.d/fileinfo.ini

2 /usr/local/php/etc/php.d/imagick.ini

3 /usr/local/php/etc/php.d/redis.ini

4 /usr/local/php/etc/php.d/swoole.ini

5 /usr/local/php/etc/php.d/disable/opcache.ini

6 /usr/local/php/etc/php.d/disable/pgsql.ini

7 /usr/local/php/etc/php.d/disable/xdebug.ini

8 /usr/local/php/etc/php.d/disable/yasd.ini

Please input a number to enable or disable php extension:(input example '0 1 2')0 4
event.ini disable success
swoole.ini disable success

```

### Development Integration
[Oneinstack](https://github.com/oneinstack/oneinstack)
- LEMP/LAMP/LNMP/LNMPA/LTMP(Linux, Nginx/Tengine/OpenResty, Apache Httpd, MySQL/MariaDB/Percona, PHP, JAVA)
- Providing a plurality of database versions (MySQL-8.0, MySQL-5.7, MySQL-5.6, MySQL-5.5, MariaDB-10.5, MariaDB-10.4, MariaDB-10.3, MariaDB-5.5, Percona-8.0, Percona-5.7, Percona-5.6, Percona-5.5, PostgreSQL, MongoDB Sqlite)
- Providing multiple PHP versions (PHP-8.2, PHP-8.1, PHP-8.0, PHP-7.4, PHP-7.3, PHP-7.2, PHP-7.1, PHP-7.0, PHP-5.6, PHP-5.5, PHP-5.4, PHP-5.3)
- Provide Nginx, Tengine, OpenResty, Apache and ngx_lua_waf
- Providing a plurality of Tomcat version (Tomcat-10, Tomcat-9, Tomcat-8, Tomcat-7)
- Providing a plurality of JDK version (OpenJDK-8, OpenJDK-11)
- According to their needs to install PHP Cache Accelerator provides ZendOPcache, xcache, apcu, eAccelerator. And php extensions,include ZendGuardLoader,ionCube,SourceGuardian,imagick,gmagick,fileinfo,imap,ldap,calendar,phalcon,yaf,yar,redis,memcached,memcache,mongodb,swoole,xdebug,yasd_debug,event,parallel,ssh2,grpc,protobuf,rdkafka
- Installation Nodejs, Pureftpd, phpMyAdmin according to their needs
- Install memcached, redis according to their needs
- Jemalloc optimize MySQL, Nginx
- Providing add a virtual host script, include Let's Encrypt SSL certificate
- Provide Nginx/Tengine/OpenResty/Apache/Tomcat, MySQL/MariaDB/Percona, PHP, Redis, Memcached, phpMyAdmin upgrade scriptoDB


[Go](https://github.com/golang/go)

[Nvm](https://github.com/nvm-sh/nvm)

[Conda](https://github.com/conda/conda)

[Docker Desktop](https://docs.docker.com/get-docker/)

[ElasticStack](https://www.elastic.co/cn/downloads/)

[Kafka](https://github.com/apache/kafka)

[Rocketmq](https://github.com/apache/rocketmq)

[Rabbitmq](https://github.com/rabbitmq/rabbitmq-server)

[Supervisor](https://github.com/Supervisor/supervisor)

[FFmpeg](https://github.com/FFmpeg/FFmpeg)

[Wireshark](https://www.wireshark.org/download.html)

[Switchhost](https://github.com/FFmpeg/FFmpeg)

[another-redis-desktop-manager](https://github.com/qishibo/AnotherRedisDesktopManager/blob/master/README.zh-CN.md)

[NavicatPremium](http://navicat.com/en/download)

[Postman](https://www.postman.com/)

[Apifox](https://apifox.com/)

[Runapi](https://www.showdoc.com.cn/runapi/4758520094221537) client for [showdoc](https://github.com/star7th/showdoc)

[OssBrowser](https://help.aliyun.com/document_detail/61872.htm)

[Virtualbox](https://www.virtualbox.org/)

[Filezilla](https://filezilla-project.org/)

[Jmeter](https://jmeter.apache.org/)

[Vscode](https://code.visualstudio.com/)

[Cursor](https://www.cursor.so/)

[ObsStudio](https://obsproject.com/)

[RabbitvcsNautilus](http://rabbitvcs.org/)


### Special Thanks
[Oneinstack](https://github.com/oneinstack/oneinstack)



