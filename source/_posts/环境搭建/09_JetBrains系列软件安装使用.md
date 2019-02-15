---
title: JetBrains系列软件安装配置
tags:
  - Java
  - 工具
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: 环境搭建
password:
---

# 软件破解
软件破解请参考： http://idea.lanyus.com/
1. 使用前请将“0.0.0.0 account.jetbrains.com”添加到hosts文件中
2. 在网页获取注册码，在注册页面填入注册码即可

# Android Studio安装
以下为相关软件下载，2／3中软件为采用第三方模拟器的时候需要下载，利用自带模拟器则可跳过下载
1. 下载Android Studio安装软件： https://developer.android.google.cn/studio/#downloads
2. 下载virtualbox： https://www.virtualbox.org/wiki/Linux_Downloads
3. 下载Genymotion： https://www.genymotion.com/download

安装前请确保网络状态良好，现在安装Android Studio，所需Android SDK、自带模拟器镜像、gradle等都可以在线直接通过开发工具下载安装

## mac系统
直接安装dmg安装包即可

## Linux系统
1. 进入安装包所在目录下，如：android-studio-ide-181.5056338-linux.zip
2. sudo mkdir /usr/JetBrains
3. sudo cp android-studio-ide-181.5056338-linux.zip /usr/JetBrains
4. cd /usr/JetBrains
5. sudo unzip  android-studio-ide-181.5056338-linux.zip
6. cd android-studio/bin  
7. 命令行启动AndroidStuido： ./studio.sh，正常的话应该会出现软件的配置设置
8. 软件启动，因为没有Android SDK，会弹出提示界面，点击cancle之后会自动下载Android SDK，然后创建测试项目，过程中运行所需资源都会自动下载，耐心等待即可

设置启动图标启动Android Studio
1. sudo vim /usr/share/applications/android-studio.desktop 
2. 编辑文件内容：
~~~
[Desktop Entry]
Type=Application
Name=Android Studio
Comment=Android Studio Integrated Development Environment
Icon=/usr/JetBrains/android-studio/bin/studio.png
Exec=/usr/JetBrains/android-studio/bin/studio.sh  
~~~
3. 在启动器别表即可找到Android Studio启动图标，点击启动即可

# 模拟器
Android程序调试可通过真机、自带模拟器、第三方模拟器调试

第三方模拟器大多使用Genymotion，官网下载：https://www.genymotion.com/download/
android Studio安装Genymotion插件使用


## 安装过程遇到的问题
1. linux中启动模拟器出现grant current user access to /dev/kvm错误
解决方法：打开terminal,输入代码who／whoami查找当前用户名；sudo chown username -R /dev/kvm 注意username是你用的用户名

2. 无法修改模拟器创建时的选项 emulated performance
解决方法： Nexus 5X和Nexus 5镜像不支持，换成其他镜像即可

https://blog.csdn.net/wshish920907/article/details/78249528

# InteliJ IDEA安装
下载地址：http://www.jetbrains.com/idea/?fromMenu
## Linux系统
1. 进入安装包所在目录下，如：ideaIU-2016.1.2.tar.gz
2. sudo cp android-studio-ide-181.5056338-linux.zip /usr/JetBrains，如果没有JetBrains则自己创建
4. cd /usr/JetBrains
5. sudo tar -zxvf ideaIU-2016.1.2.tar.gz
6. sudo mv idea-IU-145.971.21 idea
7. cd idea/bin
8. 命令行启动Idea： ./idea.sh，正常的话应该会出现软件的配置设置
9. 软件启动，创建任意Java程序，配置JDK路径，然后创建测试项目，过程中运行所需资源都会自动下载，耐心等待即可

设置启动图标启动Idea
1. sudo vim /usr/share/applications/idea.desktop，当然软件启动后也会提示是否创建快捷访问链接，可通过IDEA创建启动图标
2. 编辑文件内容：
~~~
[Desktop Entry]
Type=Application
Name=InteliJ IDEA
Comment=InteliJ IDEA Integrated Development Environment
Icon=/usr/JetBrains/idea/bin/idea.png
Exec=/usr/JetBrains/idea/bin/idea.sh  
~~~
3. 在启动器别表即可找到InteliJ IDEA启动图标，点击启动即可

# WebStorm安装
下载地址：http://www.jetbrains.com/webstorm/download/#section=linux

webstorm安装请参考AndroidStudio和IDEA

设置启动图标启动Idea
1. sudo vim /usr/share/applications/idea.desktop，当然软件启动后也会提示是否创建快捷访问链接，可通过IDEA创建启动图标
2. 编辑文件内容：
~~~
[Desktop Entry]
Type=Application
Name=WebStorm
Comment=WebStorm Integrated Development Environment
Icon=/usr/JetBrains/WebStorm/bin/webstorm.png
Exec=/usr/JetBrains/WebStorm/bin/webstorm.sh  
~~~