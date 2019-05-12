---
title: Android应用坐标系及栏目
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

http://www.jb51.net/article/96226.htm

# Android应用坐标系
Android坐标系其实就是一个三维坐标，Z轴向上，X轴向右，Y轴向下。这三维坐标的点处理就能构成Android丰富的界面或者动画等效果，所以Android坐标系在整个Android界面中算是盖楼房的尺寸草图

# 屏幕区域划分
* 状态栏：是指手机左上最顶上，显示中国移动、安全卫士、电量、网速等等，在手机的顶部
* 通知栏：下拉就会出现通知栏，4G、蓝牙等设置界面
* 标题栏：是指一个APP程序最上部的titleBar，从名字就知道它显然就是一个应用程序一个页面的标题了，例如打开QQ消息主页，最上面显示消息那一栏就是标题栏。
* 导航栏：是手机最下面的返回，HOME，主页三个键，有些是一个按钮。

![image](https://note.youdao.com/yws/api/personal/file/WEBa36cd0e5d359381bcdd1f8624252f98a?method=download&shareKey=f445f246913291c3d0bba4be4f64ee40)

~~~
//获取屏幕区域的宽高等尺寸获取
DisplayMetrics metrics = new DisplayMetrics();
getWindowManager().getDefaultDisplay().getMetrics(metrics);
int widthPixels = metrics.widthPixels;
int heightPixels = metrics.heightPixels;
//应用程序App区域宽高等尺寸获取
Rect rect = new Rect();
getWindow().getDecorView().getWindowVisibleDisplayFrame(rect);
//获取状态栏高度
Rect rect= new Rect();
getWindow().getDecorView().getWindowVisibleDisplayFrame(rect);
int statusBarHeight = rectangle.top;
//View布局区域宽高等尺寸获取
Rect rect = new Rect(); 
getWindow().findViewById(Window.ID_ANDROID_CONTENT).getDrawingRect(rect); 
~~~

# ActionBar／ToolBar
* ActionBar：Action Bar取代了传统的tittle bar和menu
* ToolBar是替代ActionBar的控件
* 由于ActionBar在各个安卓版本和定制Rom中的效果表现不一，导致严重的碎片化问题，ToolBar应运而生
* ToolBar与ActionBar区别显示效果并没有区别
* ToolBar优点：自定义视图的操作更加简单，状态栏的颜色可以调（Android 4.4以上）
* ToolBar在 material design 也对之做了名称的定义：App bar

https://blog.csdn.net/guolin_blog/article/details/18234477
http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2014/1118/2006.html

# TitleBar
https://www.jianshu.com/p/3474a4cc7108

# StatusBar
https://blog.csdn.net/qq_33689414/article/details/73330643
https://blog.csdn.net/u012102504/article/details/53406646

# Navigation Bar
https://blog.csdn.net/weixin_37077539/article/details/59110273

Android手机可分为有导航栏以及没导航栏两种，一般有物理按键的机器不会带有导航栏，而没有物理按键的机器则基本会带，比如华为的手机基本都是带导航栏的
 