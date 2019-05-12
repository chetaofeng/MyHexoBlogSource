---
title: hexo使用速记
tags:
  - node
  - hexo
copyright: true
comments: true
toc: true
date: 2018-10-04 22:10:23
categories: 环境搭建
password:
---

# 说明
Hexo 是一个快速、简洁且高效的博客框架。Hexo 使用 Markdown（或其他渲染引擎）解析文章，在几秒内，即可利用靓丽的主题生成静态网页。详细学习请参考：https://hexo.io/zh-cn/docs 。
本文章只是个人使用过程中重点内容记录。

# 安装
前置安装：node，git
安装：npm install -g hexo-cli

# 初始化项目
1. mkdir [项目名称, 如：test]
2. hexo init [项目名称, 如：test] //此处要求文件夹内为空
3. cd [项目名称, 如：test]
4. npm install

# 常用命令
* hexo new [layout] '【文章名称】'    //创建不通类型文章
~~~
laytou及路径如下：
post	source/_posts
page	source
draft	source/_drafts
~~~
* hexo clean    //清除hexo生成静态网站内容
* hexo g        //生成hexo静态网站
* hexo s        //启用hexo服务
* hexo d        //hexo网站部署，配合hexo-deployer-git插件使用
* hexo version  //hexo相关软件版本
* hexo list [type] //type:post,page等

# Front-matter和JSON Front-matter
用来设定文章的一些参数，如是否添加密码、版权、标签、分类等信息。
* Front-matter 是文件最上方以 --- 分隔的区域，用于指定个别文件的变量，基于YAML
~~~
title: Hello World
date: 2013/7/13 20:46:25
---
~~~
* JSON Front-matter 使用 JSON 来编写 Front-matter，只要将 --- 代换成 ;;; 即可
~~~
"title": "Hello World",
"date": "2013/7/13 20:46:25"
;;;
~~~
可配置参数如下：

参数|描述|默认值
--|--|--
layout	| 布局	
title	|标题	
date	|建立日期	|文件建立日期
updated	|更新日期	|文件更新日期
comments	|开启文章的评论功能|	true
tags	|标签（不适用于分页）	
categories	|分类（不适用于分页）	
permalink	|覆盖文章网址	 

可以通过直接修改scaffolds内的模版来设定统一的文章额外信息，如：
~~~
---
title: {{ title }}
date: {{ date }}
tags:
  - 
  - 
categories: 
password: 
copyright: true
comments: true
toc: true
---
~~~

# 部署
* 安装 hexo-deployer-git：npm install hexo-deployer-git --save
* 配置hexo的_config.yml文件
~~~
# Deployment
## Docs: https://hexo.io/docs/deployment.html
deploy:
  type: git
  repo: https://[XXX]@github.com/[XXX]/[XXX].github.io  //库（Repository）地址,如：https://epaypad@github.com/epaypad/epaypad.github.io
  branch: master    //分支名称
  message: https://github.com/chetaofeng/MyHexoBlogSource 内容部署 {{ now('YYYY-MM-DD HH:mm:ss') }} //自定义提交信息
~~~
* hexo d //命令执行后，稍等一会查看部署结果

# hexo主题
hexo默认主题为landscape，大家可以根据各自需要使用不通主题。
本人使用的是NexT主题，使用请参考：http://theme-next.iissnan.com ，NexT更多配置，请参考：
https://www.jianshu.com/p/1f8107a8778c