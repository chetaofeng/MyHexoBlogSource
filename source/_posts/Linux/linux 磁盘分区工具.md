---
title: linux 磁盘分区工具
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---


GParted是一款linux下的功能非常强大的分区工具，和windows下的‘分区魔术师’类似，操作和显示上也很相似。GParted可以方便的创建、删除分区，也可以调整分区的大小和移动分区的位置。GParted支持多种linux下常见的分区格式，包括ext2、ext4、fat、hfs、jfs、reiser4、reiserfs、xfs，甚至ntfs。另外官方还提供了 LiveCD 和 LiveUSB 版本的 GParted，方便在没有主系统的情况下对硬盘进行分区！
GParted可以用于创建、删除、移动分区，调整分区大小，检查、复制分区等操作。可以用于调整分区已安装新操作系统、备份特定分区到另一块硬盘等。 　　
GParted使用libparted来识别、调整分区表，并有各个文件系统工具来处理分区上的文件系统。这些文件系统工具并不是必须的，但要处理一中文件系统就必须先安装相应的工具。 　　
GParted使用C++写成，使用gtkmm提供GTK+界面。 　　
GParted项目还提供了一个包含GParted和全部文件系统工具的Live CD，也可以制作成Live USB或使用其他介质。这个Live CD系统基于Debian GNU/Linux。其它Linux Live CD版本也大多包含GParted，如Knoppix等。

运行环境：Win2003,WinXP,Win2000,Win9X软件大小：140.3 MB

下载地址：
http://centoscn.com/plus/download.php?open=2&id=139&uhash=b720444ddecfffb41999608b