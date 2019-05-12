---
title: Rxjava和lambda语法
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
Java8 lambda表达式官网：https://docs.oracle.com/javase/tutorial/java/javaOO/lambdaexpressions.html

翻译：https://blog.csdn.net/future234/article/details/51919545

语法糖：也译为糖衣语法，指计算机语言中添加的某种语法，这种语法对语言的功能并没有影响，但是更方便程序员使用。通常来说使用语法糖能够增加程序的可读性，从而减少程序代码出错的机会。

lambda表达式其实就是实现SAM接口的语法糖。lambda写的好可以极大的减少代码冗余，同时可读性也好过冗长的内部类，匿名类

可以把Lambda表达式理解为简洁地表示可传递的匿名函数的一种方式：它没有名称，但它有参数列表、函数主体、返回类型，可能还有一个可以抛出的异常列表


参考文章：
https://www.cnblogs.com/aoeiuv/p/5911692.html

# AndroidStudio配置使用lambda
1. 更新 Android 插件到 3.0.0（或更高版本）
2. 针对使用（包括在源代码中或通过依赖项使用）Java 8 语言功能的每个模块，在其 build.gradle 文件中添加以下代码：
~~~
android {
  ...
  // Configure only for each module that uses Java 8
  // language features (either in its source code or
  // through dependencies).
  compileOptions {
    sourceCompatibility JavaVersion.VERSION_1_8
    targetCompatibility JavaVersion.VERSION_1_8
  }
~~~

# lambda表达式语法
~~~
(Type1 param1, Type2 param2, ..., TypeN paramN) -> {
  statment1;
  statment2;
  //.............
  return statmentM;
}
~~~
1. 当lambda表达式的参数个数只有一个，可以省略小括号
2. 当lambda表达式只包含一条语句时，可以省略大括号、return和语句结尾的分号
3. lambda表达式可以访问给它传递的变量，访问自己内部定义的变量，同时也能访问它外部的变量。
不过lambda表达式访问外部变量有一个非常重要的限制：变量不可变（只是引用不可变，而不是真正的不可变）
4. 在lambda中，this不是指向lambda表达式产生的那个SAM对象，而是声明它的外部对象

# 函数式接口
* 函数式接口：Functional Interface. 
* 定义的一个接口，接口里面必须 有且只有一个抽象方法 ，这样的接口就成为函数式接口
* 在可以使用lambda表达式的地方，方法声明时必须包含一个函数式的接口
* lambda表达式只能出现在目标类型为函数式接口的上下文中,意味着如果我们提供的这个接口包含一个以上的Abstract Method，那么使用lambda表达式则会报错

# 常见写法
## 替代匿名内部类
~~~
public void oldRunable() {
    new Thread(new Runnable() {
        @Override
        public void run() {
            System.out.println("The old runable now is using!");
        }
    }).start();
}
    
public void runable() {
    new Thread(() -> System.out.println("It's a lambda function!")).start();
}    
~~~
## 对集合进行迭代
~~~
public void iterTest() {
    List<String> languages = Arrays.asList("java","scala","python");
    //before java8
    for(String each:languages) {
        System.out.println(each);
    }
    //after java8
    languages.forEach(x -> System.out.println(x));
    languages.forEach(System.out::println);
}
~~~
## 用lambda表达式实现map
map函数可以说是函数式编程里最重要的一个方法了,map的作用是将一个对象变换为另外一个
~~~
public void mapTest() {
    List<Double> cost = Arrays.asList(10.0, 20.0,30.0);
    cost.stream().map(x -> x + x*0.05).forEach(x -> System.out.println(x));
}
~~~
## 用lambda表达式实现map与reduce
educe与map一样，也是函数式编程里最重要的几个方法之一。。。map的作用是将一个对象变为另外一个，而reduce实现的则是将所有值合并为一个
~~~
public void mapReduceTest() {
    List<Double> cost = Arrays.asList(10.0, 20.0,30.0);
    double allCost = cost.stream().map(x -> x+x*0.05).reduce((sum,x) -> sum + x).get();
    System.out.println(allCost);
}
~~~