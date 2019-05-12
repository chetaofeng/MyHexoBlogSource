---
title: RHEL 7 中 systemctl 的用法（替代service 和 chkconfig）
tags:
  - CentOS 
copyright: true
comments: true
toc: true
categories: Linux
password:
---

> systemctl是RHEL 7 的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。可以使用它永久性或只在当前会话中启用/禁用服务。

> Systemctl是一个systemd工具，主要负责控制systemd系统和服务管理器。

> Systemd是一个系统管理守护进程、工具和库的集合，用于取代System V初始进程。Systemd的功能是用于集中管理和配置类UNIX系统

> 启用服务就是在当前“runlevel”的配置文件目录/etc/systemd/system/multi-user.target.wants/里，建立/usr/lib/systemd/system里面对应服务配置文件的软链接；禁用服务就是删除此软链接，添加服务就是添加软连接

> Systemctl接受服务（.service），挂载点（.mount），套接口（.socket）和设备（.device）作为单元。

* 启动一个服务：systemctl start postfix.service
* 关闭一个服务：systemctl stop postfix.service
* 重启一个服务：systemctl restart postfix.service
* 显示一个服务的状态：systemctl status postfix.service
* 在开机时启用一个服务：systemctl enable postfix.service
* 在开机时禁用一个服务：systemctl disable postfix.service
* 查看服务是否开机启动：systemctl is-enabled postfix.service
* 查看已启动的服务列表：systemctl list-unit-files|grep enabled
* 查看启动失败的服务列表：systemctl --failed
>使用命令 systemctl is-enabled postfix.service 得到的值可以是enable、disable或static，这里的 static 它是指对应的 Unit 文件中没有定义[Install]区域，因此无法配置为开机启动服务。 


![image](/pub-images/systemctl.png)

更多：https://linux.cn/article-5926-1.html

chkconfig： https://www.cnblogs.com/gotodsp/p/6405106.html
