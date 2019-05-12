---
title: Mockito入门
tags:
  - java 
copyright: true
comments: true
toc: true
date: 2019-02-20 21:25:33
categories: Java
password:
--- 

# Mockito简介
* 官网：https://site.mockito.org/
* 中文文档：https://github.com/hehonghui/mockito-doc-zh/blob/master/README.md#0
* 英文文档：https://www.vogella.com/tutorials/Mockito/article.html
* Mock：（mock object，也译作模仿对象）是以可控的方式模拟真实对象行为的假的对象
* Mockito是mocking框架，它让你用简洁的API做测试，是GitHub上使用最广泛的Mock框架,并与JUnit结合使用
* Mockito框架可以创建和配置mock对象.使用Mockito简化了具有外部依赖的类的测试开发

# maven依赖
~~~
<!-- https://mvnrepository.com/artifact/org.mockito/mockito-all -->
<dependency>
    <groupId>org.mockito</groupId>
    <artifactId>mockito-all</artifactId>
    <version>2.0.2-beta</version>
    <scope>test</scope>
</dependency>
<!-- https://mvnrepository.com/artifact/junit/junit -->
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
</dependency>
~~~

# 参考文章
* https://www.jianshu.com/p/7d602a9f85e3
* https://blog.csdn.net/xiang__liu/article/details/81147933