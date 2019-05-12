---
title: android中handler的使用
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

# 简介
handler是android提供的用来更新UI的一套机制，也是一套消息处理机制，我们可以发送消息，也可以通过它处理消息

android在设计的时候，就封装了一套消息创建、传递、处理机制，如果不遵循这样的机制就没有办法更新UI信息

# 使用
* sendMessage
* sendMessageDelayed
* post(Runnable)
* postDelayed(Runable,long)

handler.obtainMessage();
SendToTarget
拦截MEssage

# 原理
1. Handler分装了消息的发送（主要包括消息发送给谁）
~~~
Looper
* 内部包含一个消息队列也就是MessageQueue，所有的Handler发送的消息都走向这个消息队列
* Looper.Looper方法，就是一个死循环，不断的从MessageQueue去消息，如果有消息就处理消息，没有消息就阻塞
~~~
2. MessageQueue，就是一个消息队列，可以添加消息，并处理消息
3. Handler很简单，内部会跟Looper进行关联，也就说在Handler的内部可以找到Looper，找到了Looper也就找到了MessageQueue，在Handler中发送消息，其实就是想MessageQueue队列中发送消息

总结：Handler负责发送消息，Looper负责接收Handler发送的消息，并直接把消息回传给Handler自己，MessageQueue就是一个存储消息的容器

