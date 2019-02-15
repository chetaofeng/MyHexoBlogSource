---
title: 禁用SELinux时配置错误导致系统不能够启动的解决方法
tags:
  - CentOS 
copyright: true
comments: true
toc: true
categories: Linux
password:
---

CentOS在安装某些软件的时候，需要关闭SELinux，在修改配置文件/etc/selinux/config过程中，设置方法为：
~~~
# SELINUX=enforcing
SELINUX=disabled
~~~
如果设置之后，没有设置回来，则启动的时候就会无法启动，解决办法为：

* 系统启动的时候，按下‘e’键进入grub编辑界面，
* 编辑grub菜单，选择“kernel /vmlinuz-2.6.23.1-42.fc8 ro root=/dev/vogroup00/logvol00 rhgb quiet” 一栏
* 按‘e’键进入编辑
* 在末尾增加enforcing=0，即：
kernel /vmlinuz-2.6.23.1-42.fc8 ro root=/dev/vogroup00/logvol00 rhgb quiet enforcing=0
* 按‘b’键继续引导，OK顺利前进。
