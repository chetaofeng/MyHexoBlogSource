---
title: NW.js入门
tags:
  - nw
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

[toc]

# 简介
NW.js （原名 node-webkit）是一个基于 Chromium 和 node.js 的应用运行时，通过它可以用 HTML 和 JavaScript 编写原生应用程序。它还允许您从 DOM 调用 Node.js 的模块 ，实现了一个用所有 Web 技术来写原生应用程序的新的开发模式。

* 官网：https://nwjs.io/
* 中文文档：https://www.gitbook.com/book/wizardforcel/nwjs-doc/details
# 功能特性
* 用现代 HTML5,CSS3,JS 和 WebGL 来编写应用程序
* 完全支持 Node.js APIs 和所有其 第三方模块
* 良好的性能:Node 和 WebKit
* 运行在相同的线程:函数调用是更简洁;对象在同一堆可以互相引用
* 容易打包和分发应用程序
* 支持 Linux、Mac OS X 和 Windows

# 窗口外观常用属性
在package.json文件中设置
~~~
title : 字符串，设置默认 title。
width/height : 主窗口的大小。
toolbar : bool 值。是否显示导航栏。
icon : 窗口的 icon。
position :字符串。窗口打开时的位置，可以设置为“null”、“center”或者“mouse”。
min_width/min_height : 窗口的最小值。
max_width/max_height : 窗口显示的最大值。
resizable : bool 值。是否允许调整窗口大小。
always-on-top : bool 值。窗口置顶。
fullscreen : bool 值。是否全屏显示。
show_in_taskbar : 是否在任务栏显示图标。
frame : bool 值。如果设置为 false，程序将无边框显示。
~~~

# webstorm项目创建及调试
## 下载三个不同 OS 平台的 NW.js

## 创建项目并运行
1. 创建空项目
2. 创建package.json,编辑起内容，最简为:
~~~
{
  "name": "helloworld", 
  "version": "0.0.1",
  "main": "index.html" 
}
~~~
3. 在webstorm 中添加一个nw.js：run -- edit configurations -- + nw.js
~~~
NW.js app : 可以是当前项目目录，但要包含package.json文件. 或者是一个.nw的文件
NW.js interpreter 指定可执行的 nw(官网下的包中的) (mac下是nwjs),如：/MyDeveloper/nwjs-v0.22.1-osx-x64/nwjs.app
working direction ： 项目目录
~~~
4. 运行查看效果

## 调试
https://www.jetbrains.com/help/webstorm/2017.1/run-debug-configuration-node-webkit.html

# 打包到各个平台
https://github.com/nwjs/nw.js/wiki/how-to-package-and-distribute-your-apps

## mac下打包
1. 拷贝下载的nwjs-sdk-v0.22.1-osx-x64.zip中的nwjs.app文件到项目的根目录的同级目录
2. 修改nwjs.app目录名称为你想要的名称，如：MyNW.app
3. 在项目根目录执行如下命令：zip -r ../MyNW.app/Contents/Resources/app.nw *,将当前目录下所有文件打包到MyNW.app中
4. open MyNW.app可以打开项目
5. 制作成dmg文件
- - 在应用程序->实用工具下打开磁盘工具
- - 新建一个磁盘映像，放在桌面上(可随意)，名称设置为temp.dmg(可随意)，存储为mytemp
- - 拷贝4中的文件到mytemp中
- - 执行：ln -s /Applications /Volumes/temp.dmg/Applications
6. 成功

问题：4中制作的文件太大


## 代码加密保护
> 有些情况下，代码还是不能直接暴露给用户的；我们可以使用V8 Snapshot 的方式来达到代码加密保护的目的

具体的方式是:
1. 使用 /nwjs.exe 来运行 nwjc source.js core.bin命令
2. 在index.html里使用require('nw.gui').Window.get().evalNWBin(null, './app/v0.0.1/core.bin');(注意这里的路径，是相对于nw.exe的位置)将代码引入到项目中； 
3. 加密的代码里不要使用 let、const这些关键字，可能因为这个始终编译不通过

## 自动更新
### 项目代码需要更新
前面介绍项目接口就提到 /app/v0.0.1/ 就是放置V0.0.1的所有代码的位置； 
那么如果要更新到V0.0.2，那我们新建一个文件夹 /app/V0.0.2,然后把V0.0.2的代码都放到这个文件下，然后把/package.json替换成新版本的package.json；这样重启客户端之后，然会读取v0.0.2的代码了。具体的更新代码就不写了，可以把新版本的代码打包成zip包，然后客户端下载好，解压就行。

### nw.js本身需要更新
通常情况下，不会遇到需要更新nw.js 本身的情况，因为当选定一个版本的NW.js后，就认定它了，除非遇到了什么无法解决的BUG

## 系列教程
https://blog.csdn.net/zeping891103/column/info/19257

