---
title: DNS
tags:
  - DNS 
copyright: true
comments: true
toc: true
date: 2019-04-15 22:10:23
categories: 环境搭建
password:
--- 

# BIND服务
* 开源、稳定、应用广泛的DNS服务
* 提供服务：1、 域名解析服务；2、权威域名服务；3、DNS工具

![image](/pub-images/域名解析.png)

安装：
* yum install bind bind-chroot;rqm -qa|grep bind;/etc/init.d/named;ps -aux|grep named 
* apt-get install bind9;whereis bind;ls -al /etc/bind;

ps -aux |grep named

配置文件：named.conf
* options{}：bind使用的全局选项
* logging{}: 服务日志选项
* zone . {}: DNS域解析


# DNS解析记录分析
* A记录
* CNAME
* MX记录：针对邮件服务解析，配合A记录进行
* NS记录
![image](/pub-images/CNAME记录.png)
![image](/pub-images/NS记录.png)


