---
title: SVN迁移
tags:
  - SVN 
copyright: true
comments: true
toc: true
categories: 工具
password:
---

SVN_Root为所有SVN操作根目录，包括所有的软件、资源库等
* Soft：为搭建SVN环境相关的软件
* Subversion：为SVN服务端软件安装目录
* SVN_BAK：为SVN备份文件
* repos:SVN仓库的根目录
* ReadMe：当前目录说明文件

所有命令行操作需要管理员权限

服务启动：
svnserve.exe -d -r D:\SVN_Root\repos

SVN还原
svnadmin load D:\SVN_Root\repos\repos < D:\repos.dump

注册为系统服务
sc create svn binpath= "\"D:\SVN_Root\Subversion\bin\svnserve.exe\" --service -r D:\SVN_Root\repos" displayname= "Subversion Server" depend= Tcpip start= auto


项目更换服务器，需迁移SVN，现记录过程。

 Subversion简介
1. Subversion（简称SVN）是一款功能强大的开源版本控制工具，支持Linux和Windows平台。
2. SVN可以有两个访问方式，一种是独立服务器直接访问，即利用svnserve命令启动服务，通过svn://yourdomain.com/project进行访问和操作。另一种结合apache，利用HTTP协议，通过http://yourdomain.com/svn/project进行访问及各类操作。如果服务器需要在互联网上共享，一般选择后一种方式。
3. 通常情况下，如果选择SVN Server和Apache HTTP Server各自独立安装，配置起来会比较繁琐。

软件下载
服务器：Subversion v1.7 http://sourceforge.net/projects/win32svn/
客户端：Tortoisesvn V1.7 http://tortoisesvn.net/downloads.html

结构说明
D:/svnroot
├─project1
│     ├─conf
│     ├─dav
│     ├─db
│     │     ├─revprops
│     │     ├─revs
│     │     └─transactions
│     ├─hooks
│     └─locks
└─project2
       ├─conf
       ├─dav
       ├─db
       │     ├─revprops
       │     ├─revs
       │     └─transactions
       ├─hooks
└─locks
其中：svnroot文件夹为存放所有仓库，也是服务启动的时候需指定的目录，下面的各项为项目目录

启动服务
启动独立服务方式
svnserve –d –r e:/svn_repository/
访问方法：svn://localhost/dev，或file:///3:/svn_repository/dev
启动apache方式
cd D:/Program Files/CollabNet Subversion Server/httpd/bin
httpd.exe
访问方法：http://localhost/svn/dev/

本项目所使用过程
所有命令行操作需要管理员权限
1.服务启动：
svnserve.exe -d -r D:\SVN_Root\repos
2.SVN备份（从源服务器备份，如：192.168.11.121）：
A：svnadmin dump d:\svn\repos\project1> dump.dump >D:\repos.dump      .dump后缀不能丢
B：备份d:\svn\repos\project1下conf目录
3.SVN还原（拷贝.dump文件到目的服务器，如：192.168.7.116）：
        A：svnadmin create D:\SVN_Root\repos\project1
B：svnadmin load D:\SVN_Root\repos\project1 < D:\repos.dump
C：拷贝2.B中备份的conf文件夹覆盖D:\SVN_Root\repos\project1下conf文件
4.注册为系统服务
sc create svn binpath= "\"D:\SVN_Root\Subversion\bin\svnserve.exe\" --service -r D:\SVN_Root\repos" displayname= "Subversion Server" depend= Tcpip start= auto

荐读：
svnadmin命令：
http://blog.csdn.net/wzq9706/article/details/7319728
http://www.ityen.com/archives/529
svn命令：http://blog.sina.com.cn/s/blog_963453200101eiuq.html，svn命令也可通过Tortoisesvn客户端操作代替
  