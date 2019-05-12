---
title: android权限介绍
tags:
  - android 
copyright: true
comments: true
toc: true
date: 2018-10-06 12:13:04
categories: 移动开发
password:
---


[toc]

https://blog.csdn.net/u013553529/article/details/68948971

# 简介
Android 6.0 （API level 23）中，将权限分成了两类。一类是Install权限（称之为安装时权限），另一类是Runtime权限（称之为运行时权限）

Install权限
~~~
* 在安装app时，就赋予该app的权限，即安装后立即获取到的权限
* normal和signature级别的权限都是安装时权限
* 赋予app normal和signature权限时，不会给用户提示界面，系统自动决定权限的赋予
* 对于signature权限，如果使用权限的app与声明权限的app的签名不一致，则系统拒绝赋予该signature权限
~~~

Runtime权限
~~~
* 指在app运行过程中，赋予app的权限,会显示明显的权限授予界面，让用户决定是否授予权限
* 如果一个app的targetSdkVersion是23及以上，那么该app所申请的所有dangerous权限都是运行时权限
* Android 6及以上的环境中，该app在运行时必须主动申请这些dangerous权限（调用requestPermissions()），否则该app没有获取到dangerous权限
~~~

RxPermissions是帮助开发者简化requestPermissions()相关的处理

官网：https://github.com/tbruyelle/RxPermissions

1. 如果系统是Android 6之前的版本，RxPermissions返回的结果是，app请求的每个权限都被允许（granted）
2. 使用RxPermissions申请权限，必须在Activity.onCreate()或者View.onFinishInflate()中处理

 