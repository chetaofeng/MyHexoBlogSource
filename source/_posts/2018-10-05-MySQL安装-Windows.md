---
title: MySQL安装_Windows
tags:
  - MySQL
  - 数据库
copyright: true
comments: true
toc: true
date: 2018-10-05 10:04:03
categories: 数据库
password:
---


下载页面：https://dev.mysql.com/downloads/mysql/

* 选择"Microsoft Windows",下载免安装版的zip文件;
* 将zip文件解压到本地
* 新建一个配置文件（my.ini）用于配置字符集、端口等信息，用以覆盖原始的配置文件（my-default.ini），当然也可以修改这个默认的配置文件

~~~
[mysql]
 # 设置mysql客户端默认字符集
 default-character-set=utf8 
 [mysqld]
 #设置3306端口
 port = 3306 
 # 设置mysql的安装目录

 basedir=D:\\softwares\\mysql-5.7.14-winx64
 # 设置mysql数据库的数据的存放目录
 datadir=D:\\softwares\\mysql-5.7.14-winx64\\data

 # 允许最大连接数
 max_connections=200
 # 服务端使用的字符集默认为UTF8
 character-set-server=utf8
 # 创建新表时将使用的默认存储引擎
 default-storage-engine=INNODB
~~~


输入cmd，以管理员身份运行控制台



S C:\Windows\system32> cd
S C:\Windows\system32> cd ..
S C:\Windows> cd ..
S C:\> cd .\mysql-8.0.12-winx64\
S C:\mysql-8.0.12-winx64> cd .\bin\



S C:\mysql-8.0.12-winx64\bin> .\mysqld.exe -install
ervice successfully installed.
S C:\mysql-8.0.12-winx64\bin> net start mysql
ySQL 服务正在启动 .
ySQL 服务无法启动。

服务没有报告任何错误。

请键入 NET HELPMSG 3534 以获得更多的帮助。

S C:\mysql-8.0.12-winx64\bin> .\mysqld.exe -remove
ervice successfully removed.
S C:\mysql-8.0.12-winx64\bin> .\mysqld.exe --initialize
S C:\mysql-8.0.12-winx64\bin> .\mysqld.exe -install
ervice successfully installed.
S C:\mysql-8.0.12-winx64\bin> net start mysql
ySQL 服务正在启动 .
ySQL 服务已经启动成功。


S C:\mysql-8.0.12-winx64\bin> .\mysqladmin.exe -u root password "axn7Og=ve;+2"
ysqladmin: connect to server at 'localhost' failed

alter user user() identified by "root";
alter user user() identified by "新密码";

mysql -u root -p 

ysql> use mysql
atabase changed
ysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
uery OK, 0 rows affected (0.04 sec)

ysql> flush privileges;
uery OK, 0 rows affected (0.00 sec)

 
use mysql

4.ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

5.flush privileges;

6.可以用navicat登陆了


https://www.cnblogs.com/anstoner/p/6414440.html

net stop mysql

https://blog.csdn.net/czhilovely/article/details/80360146

https://blog.csdn.net/qq_42923798/article/details/81540122

https://blog.csdn.net/u012561176/article/details/78557320