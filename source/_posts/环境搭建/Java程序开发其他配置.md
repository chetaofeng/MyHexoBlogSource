---
title: Java开发其他配置
tags:
  - Java 
copyright: true
comments: true
toc: true
date: 2019-02-21 22:10:23
categories: 环境搭建
password:
---

# maven配置
官网：http://maven.apache.org/
下载：http://maven.apache.org/download.cgi

1. 下载解压安装包:tar zvxf apache-maven-3.5.0-bin.tar.gz 
2. 配置maven环境变量:sudo vim /etc/profile,编辑系统配置文件
~~~
#set Maven environment
export MAVEN_HOME=/usr/local/software/dir-maven/apache-maven-3.5.0
export PATH=$MAVEN_HOME/bin:$PATH
~~~
source /etc/profile
3. 执行mvn -v查看是否安装完成

配置maven的镜像仓库
* 在conf目录中找到settings.xml 文件，配置mirrors的子节点，添加如下mirror
~~~
//阿里云Maven镜像：
<mirror>  
    <id>nexus-aliyun</id>  
    <mirrorOf>central</mirrorOf>    
    <name>Nexus aliyun</name>  
    <url>http://maven.aliyun.com/nexus/content/groups/public</url>  
</mirror>
或开源中国maven镜像
<mirror>  
  <id>nexus-osc</id>  
  <mirrorOf>*</mirrorOf>  
  <name>Nexus osc</name>  
  <url>http://maven.oschina.net/content/groups/public/</url>  
</mirror>
~~~