---
title: CentOS 图形界面 命令行界面切换
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

> 一、修改/etc/inittab文件中的  id:3:initdefault ， 将3改为5则为图形界面 ，反之则为命令行界面，修改完后重新启动系统生效

> 二、如果用户已经启动了字符CentOS界面，想要进入图形CentOS界面可以使用如下命令 startx 

> 三、运行级别说明，用 init -x 切换级别，如想进入图形界面则输入 init -5 即可切换；  
~~~
* 0 所有进程将被终止，机器将有序的停止，关机时系统处于这个运行级别 
* 1 单用户模式。用于系统维护，只有少数进程运行，同时所有服务也不启动 
* 2 多用户模式。和运行级别3一样，只是网络文件系统（NFS）服务没被启动 
* 3 多用户模式。允许多用户登录系统，是系统默认的启动级别 
* 4 留给用户自定义的运行级别 
* 5 多用户模式，并且在系统启动后运行X-Window，给出一个图形化的登录窗口 
* 6 所有进程被终止，系统重新启动 
~~~

# 图形界面问题处理
Centos7解决图形界面卡死问题
~~~
killall -9 gnome-shell
~~~