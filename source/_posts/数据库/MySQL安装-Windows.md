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

[toc]

# 软件准备
mysql从官网下载，包括workbench。
地址：
http://dev.mysql.com/downloads/mysql/

http://dev.mysql.com/downloads/workbench/

# 安装mysql
dmg下载后直接打开，安装过程中，会弹窗里边有随机生成的密码。记好了！不然还得卸载重装。

# 修改密码(方法一)
进入终端
1. 输入：cd /usr/local/mysql/bin/
2. su root
3.  ./mysqld_safe --skip-grant-tables &   //禁止mysql验证功能
4.  在root 模式下
~~~
sh-3.2# alias mysql=/usr/local/mysql/bin/mysql
sh-3.2# alias mysqladmin=/usr/local/mysql/bin/mysqladmin
sh-3.2# mysqladmin -u root -p password
~~~
5. 然后输入临时密码
6. 然后提示输入新密码


# 修改密码（方法二）
1. 按账号mysql并启动服务
2. 进入终端输入命令行
3. 由于刚刚安装好的mysql密码为空，输入命令：mysql -u root -p  按回车即可登录mysql命令行
4. 显示所有数据库,输入命令：show databases; 
5. 进入到名为mysql的数据库
6. 显示出mysql数据库里面的表, 有一个user表，里面就存储的是mysql用户名，密码
7. 打印user表结构
8. 更新authentication_string（相当于windows里面的password字段）字段，此处要用PASSWORD（）函数修改：update user set authentication_string=PASSWORD('root') where user='root';


# 添加用户
~~~
mysql -uroot -punistolllink;
GRANT USAGE ON  *.* TO 	'ITS_GANSU'@'localhost' IDENTIFIED BY 'ITS_GANSU_STI' WITH GRANT OPTION;

use mysql;
update user set host='%' where user='ITS_GANSU' and host='localhost'; 

grant all privileges on *.* to ITS_GANSU@"%" identified by 'ITS_GANSU_STI';
flush privileges;
exit
~~~