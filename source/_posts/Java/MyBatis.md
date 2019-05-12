---
title: MyBatis
tags:
  - MyBatis
copyright: true
comments: true
toc: true
date: 2018-12-10 13:43:24
categories: Java
password:
---

Java持久化框架 瞬态+持久态

iBatis-MyBatis
apache-google-github

SQL语句与代码分离；面向配置编程；良好支持复杂数据映射；动态SQL

https://github.com/mybatis/mybatis-3
http://www.mybatis.org/mybatis-3/zh/index.html

日志配置
https://www.cnblogs.com/zhaozihan/p/6371133.html

MyBatisg工作流程
1. 读取配置文件
2. 生成SqlSessionFactory,表示和数据库的连接，一般是程序级的生命周期
3. 简历SqlSession
4. 调用MyBatist提供的API
5. 查询Map配置
6. 返回结果
7. 关闭SqlSession
~~~
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
  PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
  "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
  <environments default="development">
    <environment id="development">
      <transactionManager type="JDBC"/>
      <dataSource type="POOLED">
        <property name="driver" value="${driver}"/>
        <property name="url" value="${url}"/>
        <property name="username" value="${username}"/>
        <property name="password" value="${password}"/>
      </dataSource>
    </environment>
  </environments>
  <mappers>
    <mapper resource="org/mybatis/example/BlogMapper.xml"/>
  </mappers>
</configuration>
~~~

map文件引用
1.相对路径 2.绝对路径 3.包路径 

MyBatis配置文件：基本配置文件+映射配置文件

typeAliases标记定义别名，需要environments标记之前

map文件方式+注解方式（接口方式）

mappers里面3种写法：resource／class／package 

Select配置属性说明
两者只能有一个成立
resultType
resultMap解决复杂查询时的映射问题，如属性为对象 

parameterType封装hashmap，key既是key也是sql形参
parameterType封装对象如User，对象参数自动匹配属性，如果对象属性和列名不一样用别名

返回多上记录时MyBatis自动封装成List

事务处理：
MyBatis事务处理由两种方式处理：JDBC+MANAGED

每张表单独的一个配置文件，方便管理


MyBatis自动id返回，
~~~
one.setUserName("123");
session.insert("insertOne",one);
System.out.println(one.id);  //可以正常获取id
~~~


高级查询
关联查询
    联合查询：association
    构造查询：POJO添加构造函数，同时确保要有默认构造函数，防止构造函数重新后找不到默认构造函数
    子查询：所有联合查询，都可以通过子查询替换，但是他让查询成了N+1次的查询
    
    子查询和联合查询的区别：
    联合查询一次查询占用资源大，子查询N+1次查询占用资源可大可小，MyBatis中子查询可能速度比联合查询速度高如果开启了懒加载的话
    懒加载的使用：配置要在配置别名之前
集合查询：Collection标记，适用于查询的对象还有一个集合引用的事后 
鉴别器：discriminator标记
    javaType属性：
    Column属性：
    Case子标记：
    
 MyBatis动态SQL：动态生成SQL
 
 
 
 
 https://www.aliyun.com/jiaocheng/811373.html
 
 https://www.jikexueyuan.com/course/oracledb/1-0-0-0/
 