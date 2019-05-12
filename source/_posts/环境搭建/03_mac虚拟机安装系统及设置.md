---
title: mac虚拟机安装及设置
tags:
  - 工具
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: 环境搭建
password:
---

# 简介
Parallels Desktop是一款运行在 Mac 电脑上的极为优秀的虚拟机软件。用户可以在 Mac OS X 下非常方便运行 Windows、Linux 等操作系统及应用。

# 安装
PD为收费软件，链接: https://pan.baidu.com/s/1CBa7tIghlF7JIiJTtuqdYQ 提取码: es9m，有经济能力的希望支持正版

PD安装操作系统需准备一个系统ISO镜像,虚拟机系统安装过程和普通系统安装过程基本一致。
windows10镜像下载： https://www.microsoft.com/zh-cn/software-download/windows10ISO/

系统安装完成之后，需安装Parallels Tools，否则使用时鼠标使用等方面会有很多不便，注意安装Parallels Tools时注意PD版本，防止有和系统不兼容。
如下图：
![image](/pub-images/Parallels%20Tools.png)

# PD使用注意事项
1. 虚拟机系统安装完之后在虚拟机系统的【配置】中进行系统内存、硬盘相关参数设置
2. 虚拟机系统安装完之后在虚拟机系统的【配置】中进行系统共享文件夹设置，方便系统间数据共享
3. 虚拟机初试安装后，再进行系统其他重要软件安装前，请先保存快照，再进行操作，操作不成功还可回退
4. 虚拟机系统更新、相关开发环境设置完成之后，建议移动硬盘保存虚拟机，方便后期恢复和循环使用
5. 虚拟机系统文件在右键【显示包内容】后，如下
![image](/pub-images/虚拟机文件结构.png)
其中.hdd文件为硬盘文件，可在虚拟机系统故障时优先保存此文件，或者将此文件复制替换到备份的虚拟机系统即可恢复






 