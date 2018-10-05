---
title: 使用Github Pages进行个人博客搭建
tags: 
  - git
  - github pages
copyright: true
comments: true
toc: true
date: 2018-10-02 22:10:23
categories: 搭建博客
password:
---

# Github Pages介绍

官网：https://pages.github.com/
GitHub Pages 是一个静态网站托管服务，使用github.io域名和HTTPS来提供服务。一个github账号只能有一个Github Pages网站。
GitHub Pages 网站是在网络上公开使用的，即使他们的库是私有的。如果你敏感的数据在你的Page库中，你可能需要在发布之前删除它。

# Github Pages创建
1. 申请邮箱
2. 申请github账号
~~~
前两步是为了准备没有进行Github Pages服务开通的github账号，如果已经有，可以跳过
~~~
3. 创建repository。和普通创建一样，但是名称要以".github.io"结尾，如：test.github.io，这样创建完之后才在这个项目的settings中有github pages选项
4. 访问：https://test.github.io/,即可以看见Github Pages网站

# Github Pages网站内容编辑
1. 创建源码repository，用来存放Github Pages网站源码
2. 此处选用Hexo作为网站模版，在本地初始化hexo项目，参考：
3. 在hexo中安装配置hexo-deployer-git进行github项目管理
4. 下载【1】中github代码到本地，本人是通过webstorm进行编辑操作的
5. 拷贝【2】中代码到【1】中的repository中，在本地运行查看hexo效果
6. 编辑.gitignore文件,忽略操作系统文件、编辑器临时文件、node临时文件等，提交
7. 提交repository到github
8. hexo部署本地代码到Github Pages，查看效果


