---
title: Java反射
tags: 
  - java 
copyright: true
comments: true
toc: true
date: 2013-03-23 15:41:51
categories: java
password:
--- 

来源视频： https://www.imooc.com/video/3725

# Class类的使用
* 在面向对象的世界中，万事万物皆对象。Java中，只有静态的成员和普通数据类型（但是有包装对象）不是对象；
* Class类是java.lang.Class类的实例对象（There is a class named Class）,其构造方法为私有的，只有JVM可以调用
* 基本数据类型、void都存在类类型，如：Class c1=void.class,Class c2=int.class
* 任何类都是Class的实例对象，这个实例对象有（如：Food类）3种表现方式：
~~~
Food food1 = new Food();//Food这个类是Class类的实例对象
//第一种
Class c1 = Food.class;//说明任何类都有一个隐含的静态成员变量class
//第二种:已知道该类的实例对象
Class c2 = food1.getClass();
//第三种
Class c3 = null;
try {
    c3 = Class.forName("com.reflect.test.myreflect.Food");
} catch (ClassNotFoundException e) {
    e.printStackTrace();
}

System.out.println(c1 == c2);   //true
System.out.println(c2 == c3);   //true

//可以通过类的类类型创建该类的对象实例，但是需要强制转换
//c1.newInstance();
//c2.newInstance();
try {
    Food food2 = (Food) c3.newInstance();   //前提：需要有无参数的构造方法
} catch (InstantiationException e) {
    e.printStackTrace();
} catch (IllegalAccessException e) {
    e.printStackTrace();
}
~~~
## 动态加载类：Class类
* Class.forName("类的全称");不仅表示了类的类类型，还表示了动态加载类
* 编译时刻加载类是静态加载类，运行时刻加载类是动态加载类
* new创建对象时，是静态加载类，在编译时就需要加载所有可能用到的类

## 反射的操作流程
1. 获取类的类类型
2. 通过类的类类型获取方法、属性等相关信息

# 方法的反射
~~~
//获取类的类类型
Class c = object.getClass();
System.out.println(c.getName());
//获取类的方法信息
Method[] ms = c.getMethods();//获取所有public类型的函数，包括父类继承而来的
for (Method method:ms) {
    System.out.println(method.getName());
}
System.out.println("======================");
ms = c.getDeclaredMethods();//获取所有该类自己声明的方法，不问访问权限
for (Method method:ms) {
    System.out.println(method.getName());
    //获取所有方法的参数及类型
    //获取参数列表的类类型
    Class[]  paramsType = method.getParameterTypes();
    for (Class paramTypeClass:paramsType) {
        System.out.println(paramTypeClass.getName());
    }
}
~~~

# 成员变量的反射
~~~
//获取类的类类型
Class c = object.getClass();
System.out.println(c.getName());
//获取类的成员变量信息
Field[] fs = c.getFields();//获取所有public类型的成员信息
for (Field field:fs) {
    System.out.println(field.getName());
}
System.out.println("======================");
fs = c.getDeclaredFields();//获取所有该类自己声明的成员变量，不问访问权限
for (Field field:fs) {
    //获取成员变量类类型名称
    Class fieldType = field.getType();
    System.out.println(fieldType.getName());
    //获取成员变量的名称
    System.out.println(field.getName());
}
~~~

# 构造函数的反射
构造方法获取类似：
~~~
c.getDeclaredConstructors();//得到所有构造函数
c.getConstructors();//得到所有public构造函数
~~~

# 方法反射的基本操作
* 方法的名称和方法的参数列表才能唯一决定某个方法
1. method.invoke(对象，参数列表 )，如：
~~~
//获取方法对象
Method method1 = c.getMethod("add",int.class,int.class);
Object obj = method1.invoke(calc,new Object[]{10,20});Object obj = method1.invoke(food,10,20)
~~~

# 集合范型的本质
* 反射的操作都是编译之后的操作
* 编译之后集合的范型是去范型化的，Java中集合的范型是防止错误输入的，只在编译阶段有效，可以通过反射的操作来绕过编译,如：
~~~
List<String> list = new ArrayList<String>();
list.add("hello");
//list.add(100);//编译时报错
//反射方式添加
Class clazz = list.getClass();
Method methodAddOfList = clazz.getMethod("add",Object.class);
methodAddOfList.invoke(list,100);//添加不同类型
System.out.println(list);   //[hello, 100]
~~~
