---
title: TypeScript入门
tags:
  - TypeScript 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

[toc]

~~~
https://www.tslang.cn/
http://www.typescriptlang.org/
~~~

# 简介
微软出品，2012
1. 编译型语言
2. 强类型语言
3. 真面向对象
4. AMD方式

cnpm install -g typescript


扩展名：.ts／.tsx/.d.ts
编译： tsc 1.ts //1.js

number\string\boolean\symbol\void\null\undefined\enum\any

any:变体变量

var a:any;
a=12;
a="abc";


var a:any; 等同于 var a;//类型推测（隐式类型声明）

冲突检测：编译器会自动排除掉无用的选项


联合类型：
var a:number|string;
a=12;
a='abc';
a=false;//报错

数组也有类型

外部声明declare，window等都内部声明过了
declare var 名字；

function sum(a:number,b:number):number{
    return  a+b;
}

function ajax(url:string,success:(res:string,code:number)=>void,error:(code:number)=>void){
    
}

对象类型：ObjectType
var a:{x:number,y:number}
可选声明：var a:{x:number,y:number,z?:number},调用或赋值的时候，z可有可无

接口：约定、限制
interface Point{
    x:number,
    y:number,
    z?:number
}

泛型：

class  Calc<T>{
    a:T;
    b:T;
}

var obj=new Calc<number>();
obj.a=12;
obj.b='123';//报错


tsconfig.json