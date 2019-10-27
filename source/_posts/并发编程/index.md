---
title: 并发编程基础
tags:
  - 并发编程 
copyright: true
comments: true
toc: true
date: 2019-07-26 15:41:00
categories: 并发编程
password:
---

# 多线程发展历史
计算器-批处理-进程（独立内存+CPU空间）-线程

# 线程的应用
1. 通过并行计算提高程序性能
2. 等待网络、IO响应导致的耗时问题

Java线程实现：Thread/Runnable/Callable,Future

zookeeper的处理链:Thread如何合理的使用

# 并发编程的基础
## 线程的状态：6种，看Thread的源码

* NEW：没有调用start方法
* RUNNABLE：运行状态
* BLOCKED：阻塞 （等待阻塞wait、同步阻塞synchronized、其他阻塞sleep/join/）
* WAITING：等待
* TIMED_WAITING：时间等待
* TERMINATED：终止

线程：初始-就绪-运行-终止

// 编写demo学习状态

jstack pid

## 线程的启动和终止
 启动：start
 
 停止：
 1. stop（已过期）；
 2. interrupt优雅终端(
    * while(!Thread.currentThread.isInterrupted());   
    * thread.interrupt();//设置interrupt标志为true
    * thread.interrupted();//复位interrupt标志为false
 3. 通过指令的方式volatile boolean isStop = false;


# 线程安全问题
可见性、原子性、有序性问题

* 硬件层面：引入高速缓存、多CPU技术     CPU的高速缓存: 缓存一致性问题
* 软件层面：JMM模型

JVM8个原子操作

## JMM内存模型

## JMM如何解决可见性、原子性、有序性问题
volatile/synchronized/final/j.u.c(java.util.concurrent)

原子性：synchronized（monitorenter/monitoerexit）；
可见性：volatile/synchronized/final
有序性：volatile/synchronized

## volatile和synchronized
运行查看汇编指令


指令重排序问题：编译器指令重排序、处理器指令重排序、内存系统的重排序

volatile：轻量级的锁（解决可见性（Lock）、防止指令重排）
1. 可以保证可见性和内存重排序  
2. #lock -> 缓存锁（MESI）
3. 内存屏障 (解决内存重排序：store barrier/load barrier/full barrier) 
    （java层面解决编译器和CPU层面屏障的解决方法：storestore、loadlaod、storeload、loadstore）

javap -c 类名，查看字节码

CPU内存屏障：解决指令顺序一致性问题

编译器层面解决指令顺序一致性问题：volatile


总线锁、缓存锁

---
# 并发编程的原理
书：并发编程的艺术  必读

synchronized：可以解决原子性、一致性、可见性问题
任何对象都可以成为加锁对象；注意区分全局锁（类、static）和普通锁（对象）

synchronized添加后查看字节码，实现是monitorenter、monitorexit

32位对象头、64位对象头

每一个object都有一个oop/oopDesc 对应mark 存放对象头，对象头可存放锁标志
