---
title: Redis入门
tags:
  - Redis
  - 数据库
copyright: true
comments: true
toc: true
date: 2019-04-05 10:04:03
categories: 数据库
password:
---

# 简介
* https://redis.io/
* Lettuce和Jedis的都是连接Redis Server的客户端程序
* Jedis在实现上是直连redis server，多线程环境下非线程安全，除非使用连接池，为每个Jedis实例增加物理连接
* Lettuce基于Netty的连接实例（StatefulRedisConnection），可以在多个线程间并发访问，且线程安全，满足多线程环境下的并发访问，同时它是可伸缩的设计，一个连接实例不够的情况也可以按需增加连接实例。

# 安装配置
## macOS
~~~
brew install redis
brew services start redis       //后台服务方式
redis-server /usr/local/etc/redis.conf  //控制台方式
brew services stop redis    //关闭redis
redis-cli
redis-cli -h 127.0.0.1 -p 
~~~

## Linux
~~~
解压：tar zxvf redis-4.0.9.tar.gz
移动到： mv redis-4.0.9 /usr/local/
切换到：cd /usr/local/redis-4.0.9/
编译测试 sudo make test
编译安装 sudo make install
~~~

## 配置
配置详解： https://www.cnblogs.com/joshua317/p/5635297.html


# 插件及破解
https://blog.csdn.net/qq_15071263/article/details/79759973
https://www.cnblogs.com/happyday56/p/3916388.html


https://www.cnblogs.com/it-cen/p/4295984.html
