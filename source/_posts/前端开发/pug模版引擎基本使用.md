---
title: pug模版引擎基本使用
tags:
  - Angular 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

[toc]

# 安装
1. npm install -g pug
2. npm install -g pug-cli
3. pug index.pug
 
# webstorm添加pug文件自动编译
1. WebStorm下，File->settings，在左上角搜索watcher，选择Tools->fileWatcher
2. 添加一个watcher，选择类型为Jade（pug支持安装了，但是不知道怎样使用，发现全部用Jade也能使用）
3. 在Program下，选择pug的安装路径，如我的为：/usr/local/bin/pug,在Arguments的默认值前面添加-P可以让编译后的文件格式化显示 
4. 编写pug文件，编写后，会自动生成相应的编译后文件

# 在 Express 中调用 jade 模板引擎
~~~
app.set('view engine', 'jade'); // 设置模板引擎
app.set('views', __dirname);  // 设置模板相对路径(相对当前目录)

app.get('/', function(req, res) {
    res.render('test'); // 调用当前路径下的 test.jade 模板
})
~~~

# 基本语法及支持
## 类名和ID名
* a.class名称,如：a.button,翻译为：<a class="button"></a>
* a#id名称，如：a#button，翻译为：<a class="button"></a>
## 属性
属性可以使用()包裹起来,属性值之间用逗号隔开，如：a(href="google.com",title="google")
## 文本内容
在html标签后空格直接书写
## 多行文本内容
~~~
p.
    asdfasdfa
    asdfasd 
~~~
或者
~~~
p
    | dfas <strong>hey</strong>
        strong hey man
    | dfas
~~~
## 注释
1. 单行注释
* 普通方式：// just some paragraphs，翻译为：<!-- just some paragraphs-->
* 非缓冲注释，不会被编译到HTML：//- will not output within markup
2. 多行注释
~~~
//
    As much text as you want
    can go here.
~~~
## 变量
jade 的变量调用有 3 种方式:
1. #{表达式}  //此方式可以自由的嵌入各个地方
2. =表达式    //返回的是表达式的值,会编码字符串
3. !=表达式   //返回的是表达式的值,不会编码字符串

注意：符号 - 开头在 jade 中属于服务端执行的代码
~~~
- console.log('hello'); // 这段代码在服务端执行
- var s = 'hello world' // 在服务端空间中定义变量
p #{s}          //<p>hello world</p>
p= s            //<p>hello world</p>
~~~

使用：
1. 直接在 jade 模板中定义变量
2. 在 express 中调用 res.render 方法的时候将变量一起传递进模板的空间中,调用模板的时候，在 jade 模板中也可以如上方那样直接调用 s 这个变量
~~~
res.render(test, {
    s: 'hello world'
});
~~~

## 流程代码
### if判断
方式1:
~~~
- var user = { description: '我喜欢猫' }
- if (user.description)
    h2 描述
    p.description= user.description
- else
    h1 描述
    p.description 用户无描述
~~~
方式2:
~~~
- var user = { description: '我喜欢猫' }
#user
  if user.description
    h2 描述
    p.description= user.description
  else
    h1 描述
    p.description 用户无描述
~~~
方式1、方式2执行结果：
~~~
<div id="user">
  <h2>描述</h2>
  <p class="description">我喜欢猫</p>
</div
~~~
方式3:
使用 Unless 类似于 if 后的表达式加上了 ! 取反;这个 unless 是 jade 提供的关键字，不是运行的 js 代码
~~~
- var user = { name: 'Alan', isVip: false }
unless user.isVip
  p 亲爱的 #{user.name} 您并不是 VIP
~~~

### 循环
1. for 循环
~~~
- var array = [1,2,3]
ul
  - for (var i = 0; i < array.length; ++i) {
    li hello #{array[i]}
  - }
~~~
2. each:in后的循环目标支持数组、json
~~~
ul
  each val, index in ['西瓜', '苹果', '梨子']
    li= index + ': ' + val
~~~

### Case选择
case 不支持case 穿透，如果 case 穿透的话会报错
~~~
- var friends = 1
case friends
  when 0: p you have no friends
  when 1: p you have a friend
  default: p you have #{friends} friends
~~~
或
~~~
- var friends = 10
case friends
  when 0
    p you have no friends
  when 1
    p you have a friend
  default
    p you have #{friends} friends

~~~

## 模板中调用Markdown语言
~~~
:markdown
  # Markdown 标题
  
//翻译后：
<h1>Markdown 标题</h1>
~~~

## 可重用的 jade 块 (Mixins)
~~~
mixin article(title)
  .article
    .article-wrapper
      h1= title
      //- block 为 jade 关键字代表外部传入的块
      if block
        block
      else
        p 该文章没有内容
        
+article('Hello world')
+article('Hello Jade') 
~~~
结果：
~~~
<div class="article">
  <div class="article-wrapper">
    <h1>Hello world</h1>
    <p>该文章没有内容</p>
  </div>
</div>
<div class="article">
  <div class="article-wrapper">
    <h1>Hello Jade</h1> 
  </div>
</div>
~~~

Mixins 同时也可以从外部获取属性:
~~~
mixin link(href, name)
  a(class!=attributes.class, href=href)= name
   
+link('/foo', 'foo')(class="btn")

//编译后
<a href="/foo" class="btn">foo</a>
~~~

## 模板包含 (Includes)
可以使用 Includes 在模板中包含其他模板的内容

## 模板继承 (Extends)
layout.jade
~~~
doctype html
html
  head
    title 我的网站
    meta(http-equiv="Content-Type",content="text/html; charset=utf-8")
    link(type="text/css",rel="stylesheet",href="/css/style.css")
    script(src="/js/lib/jquery-1.8.0.min.js",type="text/javascript")
  body
    block content
~~~
article.jade
~~~
//- extends 拓展调用 layout.jade
extends ../layout
block content
  h1 文章列表
  p 习近平忆贾大山 李克强:将启动新核电项目 
~~~
res.render(‘article’) 的结果：
~~~
<html>
  <head>
    <title>我的网站</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"></head>
    <link type="text/css" rel="stylesheet" href="/css/style.css"></head>
    <script src="/js/lib/jquery-1.8.0.min.js" type="text/javascript"></script>
  </head>
  <body>
    <h1>文章列表</h1>
    <p>习近平忆贾大山 李克强:将启动新核电项目</p> 
  </body>
</html>
~~~