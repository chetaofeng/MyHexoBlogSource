---
title: Jenkins
tags:
  - 持续集成 
copyright: true
comments: true
toc: true
date: 2018-10-05 10:04:03
categories: 工具
password:
---
  
# Jenkins
* 官网下载：https://jenkins.io/download/ ,注意下载的版本要与jdk的版本对应
* 中文网站：http://www.jenkins.org.cn/
> Jenkins是基于Java开发的一种持续集成工具，用于监控持续重复的工作，功能包括：持续的软件版本发布/测试项目；监控外部调用执行的工作
* 持续集成：指开发者在代码的开发过程中，可以频繁的将代码部署集成到主干，并进程自动化测试 
* 持续交付：指的是在持续集成的环境基础之上，将代码部署到预生产环境
* 持续部署：在持续交付的基础上，把部署到生产环境的过程自动化，持续部署和持续交付的区别就是最终部署到生产环境是自动化的

![image](/pub-images/jenkins.png)

# 启动
1. 前提：安装配置好java和maven环境，下载jenkins.war文件
2. 启动：java -jar /media/psf/LinuxShare/soft/jenkins.war &
3. 在启动时，会有临时密码生成，也可通过~/.jenkins/secrets/initialAdminPassword查看


* 报错：Upgrading Jenkins. Failed to update the default Update Site 'default'. Plugin upgrades may fail.
* 解决: sudo vim ~/.jenkins/hudson.model.UpdateCenter.xml, 修改https为http重启即可 