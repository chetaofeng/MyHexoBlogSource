---
title: Java8 特性
tags:
  - Java
copyright: true
comments: true
toc: true
date: 2018-11-26 21:25:33
categories: Java
password:
---

[toc]
 
# SAM接口 
Java8中增加了一个新的包：java.util.function，它里面包含了常用的函数式接口
~~~
Predicate<T>——接收T对象并返回boolean
Consumer<T>——接收T对象，不返回值
Function<T, R>——接收T对象，返回R对象
Supplier<T>——提供T对象（例如工厂），不接收值
UnaryOperator<T>——接收T对象，返回T对象
BinaryOperator<T>——接收两个T对象，返回T对象
~~~

# lambda表达式
参考：http://note.youdao.com/noteshare?id=3bc7675e64b86f5e9b75534c0e436694

# 方法引用和构造器引用
## 方法引用
~~~
objectName::instanceMethod

ClassName::staticMethod

ClassName::instanceMethod
~~~
1. 前两种方式类似，等同于把lambda表达式的参数直接当成instanceMethod|staticMethod的参数来调用
2. 最后一种方式，等同于把lambda表达式的第一个参数当成instanceMethod的目标对象，其他剩余参数当成该方法的参数

## 构造器引用
构造器引用语法如下：ClassName::new，把lambda表达式的参数当成ClassName构造器的参数 。例如BigDecimal::new等同于x->new BigDecimal(x)

# Stream语法
stream就是JAVA8提供给我们的对于元素集合统一、快速、并行操作的一种方式。 
它能充分运用多核的优势，以及配合lambda表达式、链式结构对集合等进行许多有用的操作

1. Stream是元素的集合，这点让Stream看起来用些类似Iterator,可以把Stream当成一个装饰后的Iterator；
2. 可以支持顺序和并行的对原Stream进行汇聚的操作；
~~~
List<Integer> nums = Lists.newArrayList(1,null,3,4,null,6);
nums.stream().filter(num -> num != null).count();
~~~


