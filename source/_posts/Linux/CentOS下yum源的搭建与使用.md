---
title: CentOS下yum源的搭建与使用
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

[toc]

# yum简介
* yum就是为了解决依赖关系而存在的
* yum源就相当是一个目录项，当我们使用yum机制安装软件时，若需要安装依赖软件，则yum机制就会根据在yum源中定义好的路径查找依赖软件，并将依赖软件安装好
* YUM是“Yellow dog Updater, Modified”的缩写，是一个软件包管理器，YUM从指定的地方（相关网站的rpm包地址或本地的rpm路径）自动下载RPM包并且安装，能够很好的解决依赖关系问题
* yum两种源：本地yum源和网络yum源

# yum工作机制
1. 服务器端
* 在服务器上面存放了所有的RPM软件包，然后以相关的功能去分析每个RPM文件的依赖性关系，将这些数据记录成文件存放在服务器的某特定目录内
2. 客户端
* 如果需要安装某个软件时，先下载服务器上面记录的依赖性关系文件(可通过WWW或FTP方式)，通过对服务器端下载的纪录数据进行分析，然后取得所有相关的软件，一次全部下载下来进行安装

# yum文件
> 在/etc/yum.repos.d 目录下存放的就是yum源的设定文件

> yum repolist all   //此命令可查看启用的源配置文件

*.repo各配置项说明
~~~
* [base]：代表容器的名字，里面的名称则可以随意取，但是不能有两个相同的容器名称， 否则 yum 会不晓得该到哪里去找容器相关软体清单档案
* name：只是说明一下这个容器的意义而已，重要性不高
* mirrorlist=：列出这个容器可以使用的映射站台，如果不想使用，可以注解到这行
* baseurl=：这个最重要，因为后面接的就是容器的实际网址！ mirrorlist 是由 yum 程式自行去捉映射站台， baseurl 则是指定固定的一个容器网址
* enable=1：就是让这个容器被启动  
* gpgcheck=1：指定是否需要查阅RPM档案内的数位签章！0表示不检测
* gpgkey=：就是数位签章的公钥档所在位置！使用预设值即可
~~~

# 更改yum源与更新系统
* 备份/etc/yum.repos.d/CentOS-Base.repo:
~~~
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
~~~
* 进入yum源配置文件所在文件夹
~~~
cd /etc/yum.repos.d/
~~~
* 下载163或其他的yum源配置文件，放入/etc/yum.repos.d/(操作前请做好相应备份)
~~~
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
~~~
* 运行yum makecache生成缓存:yum makecache
* 更新系统:yum -y update
# yum基本使用
参数说明:
~~~
-y : 如果在工作过程中如要使用者响应,这个参数可以直接回答yes
list : 列出在yum server 上面有的RPM套件
install: 安装某个套件
update : 升级某个套件,如果update后面没有接套件名称,即更新目前主机所有已安装的套件.
info   : 列出某个套件的详细信息,相当于rpm -qi package内容
clean : 将已下载到本机的packages或headers移除
remove : 移除已经安装在系统中的某个套件
yum localinstall package 本地安装软件包
yum update 全部更新
yum update package 更新指定程序包package
yum check-update 检查可更新的程序
yum info 显示安装包信息
yum list 显示所有已经安装和可以安装的程序包 
yum search 查找软件包
yum remove | erase package1 删除程序包
yum clean headers 清除header
yum clean packages 清除下载的rpm包
yum clean all 清除header与rpm包
~~~

# yum源服务器的搭建
yum源的搭建可分为三步：①搭建Apache服务器②挂载ISO镜像，将镜像中的包放至Apache服务器目录下③ISO镜像的包比较老旧，可以定时同步其他源中的包到本地

# 客户端访问yum源服务器