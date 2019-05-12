---
title: Linux下pid文件说明
tags:
  - Linux
copyright: true
comments: true
toc: true
date: 2019-03-06 08:25:33
categories: Linux
password:
--- 

Linux下的pid文件位于：/var/run/目录下
* 内容：内容只有一行，记录了该进程的ID
* 作用：防止启动多个进程副本
* 原理：进程运行后会给.pid文件加一个文件锁，只有获得pid文件(固定路径固定文件名)写入权限(F_WRLCK)的进程才能正常启动并把自身的PID写入该文件中。其它同一个程序的多余进程则自动退出



