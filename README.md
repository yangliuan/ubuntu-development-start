# ubuntu desktop 22.04 开发环境脚本
简体中文 | [English](README_EN.md)

本项目是基于[Oneinstack](https://github.com/oneinstack/oneinstack)的fork，集成了许多软件和开发环境，适合喜欢使用ubuntu desktop系统开发的用户

### 使用方法

```shell
cd /opt

git clone git@github.com:yangliuan/ubuntu-development-start.git ubdevenv

修改 options.conf 配置文件，将run_user和run_group改成自己的用户，自定义目录和常用软件

versions.txt 软件版本配置文件

sudo ./install.sh 自定义参数安装

sudo ./uninstall.sh 自定义参数卸载

cd ./setup

sudo ./install_ubsoft.sh 安装ubuntu常用软件

sudo ./install_devbase.sh 安装开发环境

sudo ./install_devtools.sh 安装开发工具

sudo ./devaddons.sh 安装开发组件

sudo ./switch_env.sh 切换环境，可以切换php版本，php扩展，composer版本，composer镜像，nginx发行版

```

### 交互安装示例
```shell

sudo ./install_ubsoft.sh
################################################################################
#             Development environment for Ubuntu 22.04 desktop                 #
#                                Install Software                              #
################################################################################

Do you want to remove default installed software? [y/n](n): 

Do you want to install input method? [y/n](y): 

Please select input method:
	1. Install googlepinyin
	2. Install sougoupinyin
	3. Install baidupinyin
Please input a number:(Default 1 press Enter) 

Do you want to install baidunetdisk? [y/n](y): 
baidunetdisk already installed! 

Do you want to install chrome? [y/n](y): 
chrome already installed! 

Do you want to install deepinwine? [y/n](y): 
deepinwine_flag already installed! 
...

```

### 切换开发环境示例
```shell
#切换php扩展
cd ./utils

sudo switch_env.sh --php_extension

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

### 自定义软件
```shell

修改 options.conf 配置文件 snap_custom_packages 和 apt_custom_packages 变量值

sudo ./install_ubsoft.sh --custom

```

### 开发集成
[Oneinstack](https://github.com/oneinstack/oneinstack)
- LEMP/LAMP/LNMP/LNMPA/LTMP(Linux, Nginx/Tengine/OpenResty, Apache Httpd, MySQL/MariaDB/Percona, PHP, JAVA)
- Providing a plurality of devbase/database versions (MySQL-8.0, MySQL-5.7, MySQL-5.6, MySQL-5.5, MariaDB-10.5, MariaDB-10.4, MariaDB-10.3, MariaDB-5.5, Percona-8.0, Percona-5.7, Percona-5.6, Percona-5.5, PostgreSQL, MongoDB Sqlite)
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

### 常用ubuntu软件

[Baidunetdisk](https://pan.baidu.com/disk/home)

[Chrome](https://www.google.com/chrome/)

[Deepinwine](https://github.com/zq1997/deepin-wine) 

[Dingtalk](https://www.dingtalk.com/en)

[Feishu](https://www.feishu.cn/en)

[Flameshot](https://github.com/flameshot-org/flameshot)

[Indicator sysmonitor](https://github.com/fossfreedom/indicator-sysmonitor)

[Lantern](https://getlantern.org/)

[Neteasy cloud music](https://music.163.com/)

[Peek](https://github.com/phw/peek)

[QQmusic](https://y.qq.com/)

[Qv2ray](https://github.com/Qv2ray/Qv2ray)

[Sougoupinyin](https://pinyin.sogou.com/)

[Sunlogin](https://sunlogin.oray.com/)

[Gnome Tweaks](https://wiki.gnome.org/Apps/Tweaks)

[Wps](https://www.wps.cn/product/wpslinux)
### 特别感谢
[Oneinstack](https://github.com/oneinstack/oneinstack)



