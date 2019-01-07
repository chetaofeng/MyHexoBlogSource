---
title: SpringBoot
tags:
  - Spring
  - Spring Boot
  - JavaWeb
copyright: true
comments: true
toc: true
date: 2018-11-26 14:41:51
categories: Spring
password:
---

http://spring.io/

https://www.imooc.com/video/16358

英文文档：https://docs.spring.io/spring-boot/docs/current/reference/

Spring Framework是一种JavaEE的框架
Spring Boot是一种快速构建的Spring应用
Spring Cloud是构建SpringBoot的分布式应用

SpringBoot2.0
编程语言：Java 8+，Kotlin，底层框架：SpringFramework 5.0.X,支持Web Flux

Web Flux  
1. 支持函数编程，Java 8 Lambda
2. 响应式编程,Reactive Streams
3. 异步编程，Servlet3.1和Asyc NIO

InteliJ中配置Java和Maven

构建项目：
图形化方式
1 http://start.spring.io/ ，输入选择Reactive Web
2 导入项目
命令行方式（Maven）
mvn archetype:generate -DinteractiveMode=false -DgroupId=com.test -DartifactId=first-app-by-maven -Dversion=1.0.0-SNAPSHOT
添加
 <parent>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-parent</artifactId>
    <version>1.5.9.RELEASE</version>
    <relativePath/>
</parent>
    
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
</dependencies>

取消Junit的版本，需要4.1.2以上，取掉之后spring-boot-starter-parent继承版本



----
父Module的packaging设置为pom 


打包方式
Jar包方式 
War包方式
指定Main-class方式

<plugin>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-maven-plugin</artifactId>
  <version>1.5.4.RELEASE</version>
  <configuration>
    <mainClass>${start-class}</mainClass>
    <layout>ZIP</layout>
  </configuration>
  <executions>
    <execution>
      <goals>
        <goal>repackage</goal>
      </goals>
    </execution>
  </executions>
</plugin> 

https://docs.spring.io/spring-boot/docs/current/reference/html/build-tool-plugins-maven-plugin.html

jar包形式
mvn -Dmaven.test.skip -U clean package
java -jar [jar名称.jar]


war包形式，需要有webapp->WEB-INF->web.xml
java -jar [war名称.war]


运行模式
IDEA方式
Jar／War方式
Maven插件方式：
mvn srping-boot:run//需要在Main方法module，使用前，需要在父Module mvn -Dmaven.test.skip -U clean install
https://blog.csdn.net/taiyangdao/article/details/75303181

ConcurrentHashMap  http://www.importnew.com/28263.html  https://www.cnblogs.com/heyonggang/p/9112731.html
AtomicInteger https://www.cnblogs.com/sharkli/p/5623524.html
好的习惯，实体都实现toString()方法 

Flux & Mono
Flux：0到N个对象的集合
Mono：0到1个对象的集合
Reactive中的Flux和Mono是异步处理的，都是Publisher


https://www.imooc.com/learn/1058
组件自动装配：规约大于配置，专注核心业务
外部化部署：一次构建、按需调配，到处运行
嵌入式容器：内置容器、无需部署、独立运行
SpringBoot Starter:简化依赖、按需装配、自我包含
Production-Ready：一站式运维、生态无缝整合

Java 能长盛不衰，主要是命好。每当人们觉得 Java 不行了的时候，总会有英雄横刀救美。
最初 Java 开发出来不知道有什么用的时候，发现可以用 Applet 在网页上做动画。后来企业级软件开发时代 JavaEE 大行其道，开源社区 Spring 桃李满天下。
等到了移动时代，人们觉得 Java 要完蛋了，Google 拍马救市，收购并开放了 Android 平台，当家语言就是 Java，于是 Java 再次焕发勃勃生机。
目前大数据领域，Java 同样是当仁不让的好手。

现在 Spring Framework 那套东西使用了十几年，正当大家被长达几千行的 ApplicationContext 配置文件折磨的死去活来的时候，Spring Boot 诞生了。什么是 Spring Boot？用来简化 Spring 应用程序开发的。

换句话说就是，当你觉得 Java 不好用的时候，我做了个轻量级的 S，让你好好用 Java。等你觉的 S 也不够轻了，我做了个 SB，让你觉得 S 还是挺轻的。


https://www.imooc.com/video/16783
SrpingBoot为微服务框架，与Spring4一起诞生


