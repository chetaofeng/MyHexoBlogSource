---
title: CentOS时钟同步设置
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

# 简介
* 网络时间协议NTP（Network Time Protocol）是用于互联网中时间同步的标准互联网协议
* NTP的用途是把计算机的时间同步到某些时间标准。目前采用的时间标准是世界协调时UTC（Universal Time Coordinated）
* NTP的主要开发者是美国特拉华大学的David L. Mills教授

# NTP在linux下有两种时钟同步方式 
1. 直接同步:使用ntpdate命令进行同步，直接进行时间变更。如果服务器上存在一个12点运行的任务，当前服务器时间是13点，但标准时间时11点，使用此命令可能会造成任务重复执行。因此使用ntpdate同步可能会引发风险，因此该命令也多用于配置时钟同步服务时第一次同步时间时使用。 
2. 平滑同步:使用ntpd进行时钟同步，可以保证一个时间不经历两次，它每次同步时间的偏移量不会太陡，是慢慢来的，这正因为这样，ntpd平滑同步可能耗费的时间比较长。

# 标准时钟同步服务 
> http://www.pool.ntp.org/zone/cn 网站包含全球的标准时间同步服务，也包括对中国时间的同步，对应的URL为cn.pool.ntp.org

国内常用的时间服务器列表：
~~~
210.72.145.44  (国家授时中心服务器IP地址) 
ntp.sjtu.edu.cn 202.120.2.101 (上海交通大学网络中心NTP服务器地址）
s1a.time.edu.cn	北京邮电大学
s1b.time.edu.cn	清华大学
s1c.time.edu.cn	北京大学
s1d.time.edu.cn	东南大学
s1e.time.edu.cn	清华大学
s2a.time.edu.cn	清华大学
s2b.time.edu.cn	清华大学
s2c.time.edu.cn	北京邮电大学
s2d.time.edu.cn	西南地区网络中心
s2e.time.edu.cn	西北地区网络中心
s2f.time.edu.cn	东北地区网络中心
s2g.time.edu.cn	华东南地区网络中心
s2h.time.edu.cn	四川大学网络管理中心
s2j.time.edu.cn	大连理工大学网络中心
s2k.time.edu.cn CERNET桂林主节点
s2m.time.edu.cn 北京大学
~~~

## 具体设置步骤如下：
~~~
* rpm -q ntp    //使用rpm检查ntp包是否安装,有则显示如：ntp-4.2.6p5-19.el7.centos.3.x86_64
* 如果已经安装则略过此步，否则使用yum进行安装，并设置系统开机自动启动并启动服务
 1. yum -y install ntp
 2. systemctl enable ntpd
 3. systemctl start ntpd
* 设置ntp服务器: 192.168.11.212
  配置前先使用命令：ntpdate -u cn.pool.ntp.org，同步服务器
* 修改/etc/ntp.conf文件，修改内容如下：
 1. ntp服务器设置
 
 2. ntp客户端设置
 
* systemctl restart ntpd    //修改完成后重启ntpd服务
* 启动后，查看同步情况
 1. ntpq -p //查看网络中的NTP服务器，同时显示客户端和每个服务器的关系
 2. ntpstat //查看时间同步状态，这个一般需要5-10分钟后才能成功连接和同步
~~~

## 参数说明
> 用restrict控管权限 
~~~
nomodify - 用户端不能更改ntp服务器的时间参数 
noquery - 用户端不能使用ntpq，ntpc等命令来查询ntp服务器 
notrap - 不提供trap远端登陆 
~~~

> ntpq -p 查看网络中的NTP服务器,每项说明如下

~~~
* 响应的NTP服务器和最精确的服务器
+ 响应这个查询请求的NTP服务器
blank(空格) 没有响应的NTP服务器
remote  响应这个请求的NTP服务器的名称
refid   NTP服务器使用的更高一级服务器的名称
st  正在响应请求的NTP服务器的级别
when    上一次成功请求之后到现在的秒数
poll    本地和远程服务器多少时间进行一次同步，单位秒，在一开始运行NTP的时候这个poll值会比较小，服务器同步的频率大，可以尽快调整到正确的时间范围，之后poll值会逐渐增大，同步的频率也就会相应减小
reach   用来测试能否和服务器连接，是一个八进制值，每成功连接一次它的值就会增加
delay   从本地机发送同步要求到ntp服务器的往返时间
offset  主机通过NTP时钟同步与所同步时间源的时间偏移量，单位为毫秒，offset越接近于0，主机和ntp服务器的时间越接近
jitter  统计了在特定个连续的连接数里offset的分布情况。简单地说这个数值的绝对值越小，主机的时间就越精确
~~~