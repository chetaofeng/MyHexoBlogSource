---
title: Ubuntu系统安装后的设置
tags:
  - 环境搭建
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories:
password:
---
# 修改默认源为国内源
1. cd /etc/apt
2. cp /etc/apt/sources.list /etc/apt/sources.list.bak   备份/etc/apt/sources.list
3. 在/etc/apt/sources.list文件前面添加源条目,具体源条目可百度，如阿里源：
~~~
#添加阿里源
deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse
~~~
4. 更新源
~~~
sudo apt-get update
sudo apt-get upgrade
~~~

# 系统分辨率设置
安装Ubuntu系统后分辨率为800*600且无法修改，通过以下方式修改：
1. 首先打开终端Terminal，输入: sudo apt-get install xdiagnose 
2. sudo xdiagnose 启动【X 诊断工具设置】，点击【Apply】
3. sudo reboot 重启系统
4. 再次打开设置发现分辨率可以设置了,如设置为：1280*800

# chrome浏览器安装
* wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
* sudo dpkg -i google-chrome-stable_current_amd64.deb 


