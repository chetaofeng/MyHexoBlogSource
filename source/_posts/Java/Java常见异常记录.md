---
title: Java常见异常记录
tags:
  - java
copyright: true
comments: true
toc: true
date: 2019-03-07 09:25:33
categories: Java
password:
---

1. log4j
~~
log4j:WARN No appenders could be found for logger 
log4j:WARN Please initialize the log4j system properly.
~~~
添加log4j.properties在resources文件夹下，内容类似：
~~~
log4j.rootLogger=debug, stdout, R

log4j.appender.stdout=org.apache.log4j.ConsoleAppender
log4j.appender.stdout.layout=org.apache.log4j.PatternLayout

log4j.appender.stdout.layout.ConversionPattern=%5p - %m%n

log4j.appender.R=org.apache.log4j.RollingFileAppender
log4j.appender.R.File=firestorm.log

log4j.appender.R.MaxFileSize=100KB
log4j.appender.R.MaxBackupIndex=1

log4j.appender.R.layout=org.apache.log4j.PatternLayout
log4j.appender.R.layout.ConversionPattern=%p %t %c - %m%n

log4j.logger.com.codefutures=DEBUG
~~~