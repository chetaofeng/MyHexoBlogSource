---
title: gitbook使用
tags:
  - gitbook
  - git
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: 工具
password:
---

https://my.oschina.net/huangyong/blog/372491

http://www.widuu.com/chinese_docker/userguide/dockerhub.html     gitbook教程

# 简介及安装
Gitbook是一个开源的跨平台电子书解决方案。通过Gitbook，可以使用Markdown或者AsciiDoc来编写电子书，然后生成静态网页电子书，pdf，mobi，epub格式

在使用GitBook 之前, 我们需要先安装一些必须的工具，Node.js、GitBook、GitBook Editor、Git版本控制器

* 静态站点：GitBook默认输出该种格式
* PDF：需要安装gitbook-pdf依赖
* eBook：需要安装ebook-convert

itBook官方客户端编辑器，支持Win、Linux、Mac系统

https://www.gitbook.com/
> 在线网站，提供在线编写工具，有客户端，免费版本文章默认公开

安装：
* npm install -g gitbook-cli  //想在系统上的任何地方的gitbook命令，需要安装“gitbook CLI”
* npm install gitbook -g
* gitbook -V

# 使用gitbook
## 创建项目
> 本地命令创建
* mkdir MyFirstBook
* cd MyFirstBook
* gitbook init
> https://www.gitbook.com/ 创建在线版本，即托管到 GitBook.com 
账号：github登陆（chetaofeng@163.com）

# 生成图书
## 输出为静态网站
在自己的电脑上编辑好图书之后，可以使用Gitbook
的命令行进行本地预览：
* gitbook build //生成网站，此命令会生成_book目录，而这个目录中的文件，即是生成的静态网站内容
* gitbook serve  //启动服务
* http://localhost:4000
* gitbook build --output=/tmp/gitbook  //需自己创建好目标目录

## 输出PDF
* npm install gitbook-pdf -g //依赖
* gitbook pdf【路径/文件名.pdf】

## 输出电子书mobi
> 由于 GitBook 生成 mobi 格式电子书依赖 Calibre 的 ebook-convert，所以需下载安装 Calibre

> Calibre 安装完毕后，对于 Mac OS X 系统，还需要先设置一下软链接：
~~~
ln -s /Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
~~~

* gitbook mobi【路径/文件名.mobi】

# 编辑内容
## README.md
此文件是简单的电子书介绍，可以把所制作的电子书做一下简单的描述

## SUMMARY.md
此为电子书的导航目录文件，每当新增一个章节文件就需要向此文件中添加一条记录。对于 Kindle 电子书来说，此文件所呈现的目录结构就是开头的目录内容和“前往”的目录导航

如果需要“子章节”可以使用 Tab 缩进来实现（最多支持三级标题），如下所示：
~~~
# Summary

* [第一章](section1/README.md)
    * [第一节](section1/example1.md)
    * [第二节](section1/example2.md)
* [第二章](section2/README.md)
    * [第一节](section2/example1.md)
~~~

## Glossary.md
对于电子书内容中需要解释的词汇可在此文件中定义。词汇表会被放在电子书末尾。其格式如下所示：
~~~
# 电子书
电子书是指将文字、图片、声音、影像等讯息内容数字化的出版物和植入或下载数字化文字、图片、声音、影像等讯息内容的集存储和显示终端于一体的手持阅读器。
~~~

## book.json
“book.json”是电子书的配置文件，可以看作是电子书的“原数据”，比如 title、description、isbn、language、direction、styles 等，更多:https://toolchain.gitbook.com/

## 普通章节.md 文件
每编写一个 .md 文件，不要忘了在“SUMMARY.md”文件中添加一条记录

## 电子书封面图片
GitBook 帮助文档建议封面图片的尺寸为 1800*2360 像素并且遵循建议：
* 没有边框
* 清晰可见的书本标题
* 任何重要的文字在小版本中应该可见
* 图片的格式为 jpg 格式

把图片重命名为“cover.jpg”放到电子书项目文件夹即可

# 高级功能
想要gitBook更美观，或者更符合我们自己的需求，则通过book.json配置进行自定义、以及安装一些常用的插件等

## Book.json配置
GitBook 在编译书籍的时候会读取书籍源码顶层目录中的 book.js 或者 book.json。参考：
~~~
{

    //样式风格配置格式
    "styles": {
        "website": "styles/website.css",
        "ebook": "styles/ebook.css",
        "pdf": "styles/pdf.css",
        "mobi": "styles/mobi.css",
        "epub": "styles/epub.css"
     },

    //插件安装配置格式

    "plugins": ["myplugin"],
    "pluginsConfig": {
        "myPlugin": {
            "message": "Hello World"
        }
     }    
}
~~~

## 自定义插件扩展
插件是扩展GitBook功能最好的方法。使得GitBook功能更加强大
* 插件搜索：https://plugins.gitbook.com/
* 插件安装：npm install 【gitbook-plugin-toggle-chapters】 --save-dev
* 通过Book.json配置插件
~~~
"plugins": ["toggle-chapters"],
    "pluginsConfig": {
        "myPlugin": {
            "message": "Hello World"
        }
     }
~~~
* 常用插件：http://zhaoda.net/2015/11/09/gitbook-plugins/


# Android的离线打包
通过Gitbook，将电子书打包成静态网站。再将静态网站放到Android APP的assets目录下，作为离线网站，打包成一个离线电子书应用（Android APP）

1. 按照Gitbook规范，编写gitbook电子书
2. 通过Gitbook，将电子书打包成静态网站
3. 使用git将工程gitbook-android克隆下来，https://github.com/snowdream/gitbook-android?spm=5176.100239.blogcont31432.7.rKGSpR
4. 将静态网站放在gitbook-android工程的assets/book目录下
5. 在“gitbook-android\app\src\main\res\values\strings.xml”中修改app_name
6. 在“gitbook-android\app\build.gradle”中修改包名 applicationId "com.github.snowdream.apps.gitbook"
7. 新增以下四个keystore相关的环境变量，用于APK签名. KEYSTORE KEYSTORE_PASSWORD KEY_ALIAS KEY_PASSWORD 
8. 在gitbook-android工程目录下，运行gradle assembleRelease --info即可。



  