---
title: MySQL安装配置
tags:
  - MySQL
  - 数据库
copyright: true
comments: true
toc: true
date: 2018-10-04 22:10:23
categories: 环境搭建
password:
---
 
# 简介
下载地址：https://dev.mysql.com/downloads/mysql/
官方数据客户端工具： https://dev.mysql.com/downloads/workbench/
推荐客户端工具：Navicat Premium- https://www.navicat.com/en/download/navicat-premium

# 安装
## mac系统
1. 安装dmg安装包，如：mysql-5.7.8-rc-osx10.9-x86_64.dmg，安装过程中会弹出临时的密码，务必截图保存方便后面更改密码，安装过程有时会卡顿，时间会比较长，需耐心等待一会。
2. 在【系统偏好设置】中启动MySQL服务，如果启动不起来，可选择开机启动，然后重启macOS
3. 在MySQLWorkBench中，创建连接信息,hostname-127.0.0.1或localhost，端口3307
4. 点击"Store in Keychain..."输入安装时提示的临时密码后确定
5. 如果临时密码输入正确，则会弹出修改密码界面，修改密码后重新登陆即可

## Linux系统
Linux下安装有多种方式：
1. 直接用软件仓库自动安装（如：ubuntu下，sudo apt-get install mysql-server）
2. 通过下载deb或rmp安装包，直接双击安装
3. 下载tar安装包，解压到硬盘，然后自己配置mysql
4. 通过源码编译安装

### CentOS系统
在 centos7 自带的是 mariaDb 数据库，所以第一步是卸载数据库，所以先检查卸载：
~~~
#查看mariadb数据库：rpm -qa | grep mariadb
#卸载mariadb数据库：sudo rpm -e --nodeps  mariadb文件名
#查看 mysql 数据库：rpm -qa | grep -i mysql
#卸载 mysql 数据库：rpm -e mysql文件名 # 如果有关联文件，不能直接卸载。可以用一下命令强制卸载：rpm -e --nodeps mysql文件名） 
#删除etc目录下的my.cnf文件：rm /etc/my.cnf
~~~
下载、解压：
~~~
解压命令：sudo tar -xvf mysql-8.0.13-linux-glibc2.12-x86_64.tar.xz -C /usr/local/
重命名命令：sudo mv mysql-8.0.13-linux-glibc2.12-x86_64/ mysql
~~~
添加mysql用户组和用户
~~~ 
cat /etc/group | grep mysql     
cat /etc/group | grep mysql     
//如果没有则添加mysql用户和组  
sudo groupadd mysql          
sudo useradd -r -g mysql mysql
~~~
初始化mysql配置表,注意中initialize成功会生成一个临时密码，一定要保存好，后面修改密码需要用到
~~~
cd /usr/local/mysql
sudo chown -R mysql:mysql ./  修改当前目录为mysql用户
sudo yum -y install numactl
sudo ./bin/mysqld --initialize --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data  //执行会自动创建data目录
sudo chown -R root:root ./   #修改当前目录用户为root用户 
sudo chown -R mysql:mysql data/  #修改当前的data目录为mysql用户   
~~~
配置mysql
~~~
sudo mkdir tmp
sudo chmod 777 ./tmp/
cd support-files/
sudo vim my-defalut.cnf 
~~~
//编辑其内容如下：
~~~
[mysqld]
basedir=/usr/local/mysql
datadir=/usr/local/mysql/data
port=3306
socket=/usr/local/mysql/tmp/mysql.sock
# 必填项
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
~~~
~~~
sudo cp my-defalut.cnf /etc/my.cnf  //复制配置文件到系统配置目录
~~~
加入开机启动项：
~~~
sudo cp ./mysql.server /etc/init.d/mysqld
sudo chmod 755 /etc/init.d/mysqld
sudo chkconfig --add mysqld
sudo chkconfig --list mysqld
sudo ./mysql.server start --user=mysql      //启动服务，看见success字样说明启动成功
~~~
配置环境变量：
~~~
sudo vim /etc/profile   //添加如下内容
export PATH=$PATH:/usr/local/mysql/bin:/usr/local/mysql/lib
source /etc/profile 
~~~
登录并初始化密码：
~~~
ln -s /usr/local/mysql/tmp/mysql.sock /tmp/mysql.sock
mysql -uroot -p     //输入默认生成的随机密码
~~~
更改root密码为root：
~~~
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root' PASSWORD EXPIRE NEVER;   //修改root的密码与加密方式
use mysql; #切换到mysql库 
update user set host='%' where user='root'; //更改可以登录的IP为任意IP
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root'; #再次更改root用户密码，使其可以在任意IP访问
flush privileges; #刷新权限
~~~
安装客户端测试即可

### ubuntu系统安装
ubutnu系统安装和CentOS系统安装类似，不同点在于：
1. 安装依赖库：sudo apt-get install libaio1 libaio-dev
2. 初始化数据库: sudo ./bin/mysqld --initialize --user mysql ;执行过程中会生成一个临时密码，一定要保存好，后面修改密码需要用到，此处再次强调如图：
   ![image](/pub-images/mysql.png)
3. 设置服务开机自启动：sudo systemctl enable mysqld.service
4. 安装客户端mysql-workbench测试
~~~
sudo apt-get install mysql-workbench mysql-client
~~~

https://dev.mysql.com/downloads/file/?id=412155

# Navicat安装
## Linux
1. 进入安装包所在目录下，如：navicat_premium12_cs_x64_for_linux.zip
2. sudo cp navicat_premium12_cs_x64_for_linux.zip /usr/
4. cd /usr/
5. sudo unzip navicat_premium12_cs_x64_for_linux.zip 
6. cd navicat120_premium_cs_x64
7. 命令行启动：sudo ./start_navicat，正常的话应该会出现一个Win Mono下载界面，可不下载，跳过即可 

## Windows & macOS
直接下载安装就行，破解请自行查找