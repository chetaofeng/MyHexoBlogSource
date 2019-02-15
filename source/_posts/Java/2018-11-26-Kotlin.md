---
title: Kotlin
tags:
  - Kotlin
copyright: true
comments: true
toc: true
date: 2018-11-26 21:25:33
categories: Kotlin
password:
---

http://kotlinlang.org/
https://try.kotlinlang.org/#/Examples/Hello,%20world!/Simplest%20version/Simplest%20version.kt

Kotlin作者Andrey
Kotlin是一种在 Java 虚拟机上运行的静态类型编程语言,被称之为 Android 世界的Swift,由 JetBrains 设计开发并开源
Kotlin是一种运行在Java虚拟机、Android、浏览器上的静态语言 
Kotlin可以编译成Java字节码，也可以编译成 JavaScript，方便在没有 JVM 的设备上运行。
Android官方语言；100%兼容Java；Kotlin-js前端开发；Kotlin-jvm服务端开发；Kotlin-native本地执行程序；Kotlin是一门全栈语言

千里之行，始于Hello World


Kotlin不存在拆箱装箱问题;Kotlin不可隐式转换类型 
var tmp:[类型]=[变量值]

Boolean类型
Number数据类型：Byte，Short，Int，Long，Float，Double
Char数据类型：Char
String数据类型：String         字符串a==b 比较内容；a===b比较应用  字符串模版$args1  ${args1+args2},引号中$引用变量 ，多行
    var a:String ...
        a1
        a2
    ...

Kotlin中 Any 等于 Java中 Object，是顶级类

空类型：任意类型都有可空和不可空两种状态，？表示可为空，!!表示强制认定nullable不可为空
fun main(args:Array<String>){
    var name:String = getName() ?: return
    println(name)

    var tmp:String? = "Hello Kotlin"
    println(tmp)
    println(tmp!!.length)
}

fun getName():String?{
    return null
}
 
智能类型转换
Java方式的：var sub:Subclass = parent as Subclass   //类似于Java方式，转换异常则会抛异常
安全类型转换：var sub:Subclass? = parent as? Subclass   //如果转换失败，则返回null，不抛异常

if(parent is Subclass)


import com.test as test

区间Range:一个数学上的概念，表示范围；是ClosedRange的子类，IntRange最常用；i in 0..1024 判断i是否在区间内
var range:IntRange = 0..1024    //[0,1024]
var range:IntRange = 0 until 1024    //[0,1024) == [0,1023]

className::java.class.name
className::java.class.simpleName

数组: val array:Array<> = arrayOf(...)
为了避免不必要的拆箱和装箱，基本类型的数组是定制的
val arrayOfInt:IntArray = intArrayOf(1,2,4)
val arrayOfChar:CharArray = charArrayOf('H','e','y')
val arrayOfString: Array<String> = arrayOf("Hello","Kotlin")
val arrayOfOther:Array<Other> = arrayOf(Other(1),Other(2))

常量：val，常量因为赋值了，编译器可以推导出来类型，所以类型可以不用写，变量：var

External Tools
Tools->Kotlin->Show Kotlin Bytecode

函数：Kotlin中没有申明返回值的默认返回值是Unit
kotlinc安装，使用和javac一样
变量函数
var int2Long = fun(x:Int):Long{
    return x.toLong()
} 
int2Long(123)
fun sum(arg1:Int,arg2:Int) = arg1+arg2
Lambda表达式调用使用()或者invoke(),如：sum(1,2) 或 sum.invoke(1,2)
Lambda表达式--匿名函数

var = {arg1:Int,arg2:Int -> arg1+arg2}

arrayOfString.forEach { println(it) }   //如果字面函数只有一个参数,可以省略该参数声明,并用“it”代替
arrayOfString.forEach(::println)

Lambda表达式中的return
https://www.jianshu.com/p/92cd94cba709?utm_source=oschina-app

public inline fun <T> Array<out T>.forEach(action: (T) -> Unit): Unit {
    for (element in this) action(element)
}

indexes.forEach {
    if (it > 5) {
        return@forEach
    }
    println(it)
}

indexes.forEach label@ {
    if (it > 5) {
        return @label
    }
    println(it)
}

函数参数调用时最后一个Lambda可以移出去
函数参数只有一个Lambda，调用时小括号可以省略
Lambda有一个参数，可默认为it
入参、返回值与形参一致的函数可以用函数引用的方式作为实参传入

类成员方法和成员变量
class B
class A{
	var b=0;
    lateinit var c:String 
    val d:B by lazy{
        B()
    }
}
属性初始化
1. 尽量在构造方法中完成
2. 无法在构造方法中完成的，尝试降级为局部变量
3. var用lateinit延迟初始化，val用lazy
4. 可空类型慎用null直接初始化


中缀表达式：只有一个参数，且用infix修饰的函数
class Book {infix fun on(placeString:String){...}}
Book() on "My Desk" //使用方式
分支表达式：
val mode=if(args.isNotEmpty() && args[0] ==1){
    0
}else{
    1    
}

异常捕捉
try ..catch ..finally中的执行完之后，再返回结果，可通过var获取返回值

具名参数：sum(arg1=2,arg0=3)  //参数就可以不按照顺序传递了
变长参数：如main方法中的args
fun test(vararg  args:String){}
默认参数：给出参数默认值

导出可执行程序

kotlin应用场景：

kotlin-android


