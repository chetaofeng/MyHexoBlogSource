---
title: CentOS安装设置
tags:
  - CentOS
  - Linux
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: 环境搭建
password:
---

# 设置网络自动启动
* 安装系统的时候设置网络自动启动（最简单）
* 打开 vi /etc/sysconfig/network-scripts/ifcfg-eth0（每个机子都可能不一样，但格式会是“ifcfg-eth数字”），把ONBOOT=no，改为ONBOOT=yes，重启网络：service network restart


# 更新阿里云yum源
* 启用源下载wget
cd /etc/yum.repos.d/
sudo vi CentOS-Base.repo；修改文件内容中enable从0改为1
yum install wget
* 下载repo文件 
wget http://mirrors.aliyun.com/repo/Centos-7.repo
* 备份并替换系统的repo文件 
cp Centos-7.repo /etc/yum.repos.d/ 
cd /etc/yum.repos.d/ 
mv CentOS-Base.repo CentOS-Base.repo.bak 
mv Centos-7.repo CentOS-Base.repo （区分大小写）
* 执行yum源更新命令 
yum clean all 
yum makecache 
yum update

# 安装图形界面
* sudo  yum groupinstall "GNOME Desktop" "Graphical Administration Tools"
* 更新系统的运行级别，以便下次直接进入图形界面：udo ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target