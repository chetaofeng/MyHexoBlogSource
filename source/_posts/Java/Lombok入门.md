---
title: Lombok入门
tags:
  - java 
copyright: true
comments: true
toc: true
date: 2019-03-04 14:25:33
categories: Java
password:
--- 

https://blog.csdn.net/qq_20989105/article/details/79869963

# 简介
在项目中使用Lombok可以减少很多重复代码的书写，比如说getter/setter/toString等方法的编写
* 官网：https://projectlombok.org/
* 插件安装：https://github.com/mplushnikov/lombok-intellij-plugin

# 项目使用
1. 安装插件lombok
2. 引入maven依赖

# Lombok注解列表
~~~
@Setter
@Getter
@Data
@Log(这是一个泛型注解，具体有很多种形式：https://projectlombok.org/features/log)
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@NonNull
@Cleanup
@ToString
@RequiredArgsConstructor
@Value
@SneakyThrows
@Synchronized
~~~
* 具体使用参考官网示例： https://projectlombok.org/features/all
* 参考网页：https://blog.csdn.net/motui/article/details/79012846

