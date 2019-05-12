---
title: AndroidStudio代码注释及Javadoc生成
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

https://www.jetbrains.com/help/idea/meet-intellij-idea.html

# AS注释设置
## 新建的类自动生成的注释
File–>Settings–>Editor–>File and code Template

点击includes->File Header,修改内容为：
~~~
/**
 * @author ${USER}
 * @version ${VERSION}  
 * @description:   TODO (必填)
 * @date ${DATE}
 */
~~~

## 自定义注释模板
File–>Setting–>Editor–>LiveTemplate
1. 新建一个Live Group
2. 新建一个LIve Template
3. 添加你的注释
4. 点击Edit Variables，在Expression选择你需要方法，相当于给你的变量赋值
5. 选择你要运用的地方
6. 点击Apply



# Javadoc文档生成
Tools->Generate JavaDoc...

1. 设置输出路径
2. 设置Othere command line arguments参数： -encoding utf-8 -charset utf-8支持中文
3. 其他设置参看设置界面