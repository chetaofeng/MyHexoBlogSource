---
title: Linux防火墙管理
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-11-26 21:25:33
categories: Linux
password:
---

* 查看防火墙状态： firewall-cmd --state
* service firewall start|stop|restart
* 端口管理：
~~~
firewall-cmd --permanent --add-port=8080-8085/tcp
firewall-cmd --permanent --remove-port=8080-8085/tcp
~~~
* 启用防火墙设置：firewall-cmd reload
* firewall-cmd --permanent --list-ports
* firewall-cmd --permanent --list-services

https://www.cnblogs.com/moxiaoan/p/5683743.html