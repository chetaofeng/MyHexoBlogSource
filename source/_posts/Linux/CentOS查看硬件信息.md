---
title: CentOS查看硬件信息
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-11-26 21:25:33
categories: Linux
password:
---

* 操作系统信息：lsb_release -a ；uname -a
* 查看网卡型号：lspci | grep  Ethernet controller 
* 查看硬盘信息：df -ah
* 查看内存信息：cat /proc/meminfo 
* 查看CPU信息：more /proc/cpuinfo | grep "model name"