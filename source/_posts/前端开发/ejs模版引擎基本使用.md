---
title: ejs模版引擎基本使用
tags:
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

http://www.360doc.com/content/16/0115/10/597197_528136785.shtml

# express中使用ejs
~~~
var express = require('express');//需要安装 express
var app = express();

app.set("view engine","ejs");//模版引擎设置为 ejs
~~~

# 文件组织
在express中使用ejs，文件组织遵循express。
* views-------放置动态模版
* public------放置静态网页
* layouts-----放置布局文件

# EJS成员函数：
* Render(str,data,[option]):直接渲染字符串并生成html
~~~
str：需要解析的字符串模板
data：数据
option：配置选项
~~~
* Compile(str,[option]):编译字符串得到模板函数
~~~
str：需要解析的字符串模板
option：配置选项
~~~

# 基本语法
1. <% code %>:无缓冲的条件语句元素
2. <%= code %>:转义HTML，该code并且会打印出来
3. <%- code %>:非转义的buffering，该code并且会打印出来
4. <% include file %>:内嵌别的文件
5. <% layout(file) -%>:指定布局文件
6. <% script(file) -%>:包含js脚本文件
7. <% stylesheet(file) -%>:包含css文件
8. <% block(code, code) -%>:指定块内容 
9. <%# %>:注释标签

# 基本对象
1. scripts:包含的脚本
2. stylesheets:包含的css
3. blocks:包含的块