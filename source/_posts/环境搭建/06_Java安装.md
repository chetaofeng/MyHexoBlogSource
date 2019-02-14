---
title: java JDK安装配置
tags:
  - 环境搭建
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories:
password: oracle官网账号：  chetaofeng@163.com / Chetaofeng123./
---
                                           
# JDK下载
http://www.oracle.com/technetwork/java/javase/downloads/index.html
https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

# 环境变量设置说明
（jdk 需要配置三个环境变量； 1.5之后可以不再设置classpath，但建议保留classpath设置）
* CLASS_PATH 保证class文件能够在任意目录下运行
* PATH 保证javac可以在任意目录下运行
 
# mac系统
环境变量配置文件执行的顺序：
/etc/profile /etc/paths ~/.bash_profile ~/.bash_login ~/.profile ~/.bashrc
/etc/profile和/etc/paths是系统级别的，系统启动就会加载，剩下的是用户级别的。 

下载dmg安装包后直接安装后，通过java -version；java；javac验证，个人发现最新版本中不用系统环境变量配置，重启电脑验证过，

配置环境变量的方式：
1. 找到JDK安装目录，如：
~~~
/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
~~~
2. 编辑文件~/.bash_profile 文件
~~~
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_40.jdk/Contents/Home
PATH=$JAVA_HOME/bin:$PATH:.

export JAVA_HOME
export PATH
~~~
3. 使配置生效：source .bash_profile
4. 输入 echo $JAVA_HOME 显示刚才配置的路径
5. 验证安装
 

# Linux系统
安装前，请在终端中通过java命令查看是否系统已默认安装OpenJDK，如果有，则先卸载
1. 下载安装包后解压，如：sudo tar -zxvf jdk-8u77-linux-x64.tar.gz,得到jdk1.8.0_77文件夹
2. sudo mkdir /usr/java
3. sudo cp -r jdk1.8.0_77/ /usr/java/
4. 配置环境变量,sudo vim /etc/profile,在前面添加
~~~
export JAVA_HOME=/usr/java/jdk1.8.0_77
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH
~~~
5. source /etc/profile 使配置立即生效
6. 检查新安装的jdk:java -version;java;javac
 