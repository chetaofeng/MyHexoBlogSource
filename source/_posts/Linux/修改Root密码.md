---
title: CentOS修改Root密码
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

1. 进入单用户模式
开机按ESC，选择内核后按e，后选择Kernerl再按e，在“<rhgb quiet”后输入空格1或s或S或Single回车，按b键重启进入命令行模式
2. 修改密码：passwd root
3. 重启：init 5