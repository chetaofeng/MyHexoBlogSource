---
title: JDBC链接MySQL8的注意事项
tags:
  - Java
  - MySQL
copyright: true
comments: true
toc: true
date: 2019-02-26 21:25:33
categories: Java
password:
---

* 需要使用高版本的JDBC驱动，“mysql-connector-java 8”以上版本,具体可通过数据库版本取maven库中查看驱动版本
* JDBC driver 由“com.mysql.jdbc.Driver”改为“com.mysql.cj.jdbc.Driver