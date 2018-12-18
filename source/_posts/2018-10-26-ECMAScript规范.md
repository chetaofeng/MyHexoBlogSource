---
title: ECMAScript规范
tags:
  - 前端规范 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---
> ECMAScript 6（简称ES6）是JavaScript语言的下一代标准，于2015年6月正式发布，也称ECMAScript 2015。

~~~
参考资料
《ECMAScript 6 入门》： http://es6.ruanyifeng.com/
~~~

ECMA是标准，js是实现

[toc]

### 历史
* 1996    ES1.0   js稳定，Netscapte将js提交给ECMA组织，ES正式出现
* 1998  ES2.0   ES2.0正式发布
* 1999  ES3.0   ES3被浏览器广泛支持
* 2007  ES4.0   ES4过于激进，被废除了
* 2008  ES3.1   4.0退化为严重缩水版3.1，代号Harmony（和谐）
* 2009  ES5.0   ES5正式发布了，公布了JS.next，即后来的ES6.0
* 2011  ES5.1   ES5.1成为了ISO国际标准
* 2013.3  ES6.0   制定草案
* 2013.12   ES6.0   ES6.0草案发布
* 2015.6    ES6.0   ES6.0预计发布正式版，同时JS.next指向ES7.0

### 兼容性
> 目前ES5、ES6支持还可以，凑合；ES5、ES6逐渐沦为后台语言

> 在浏览器中使用需要用到编译工具，babel／traceur（由google出的编译器，把ES6语法编译成ES5）

### 使用的三种方式
1. 网页内直接使用
~~~
<script src="traceur.js"></script>
<script src="bootstrap.js"></script>
<script type="module">
    //此出写ES6代码
</script>
~~~
2. 直接在线编译（主要用于测试） 
* http://babeljs.io/repl/
* https://google.github.io/traceur-compiler/demo/repl.html
3. 直接在node中使用
* 直接用，需添加‘use strict’
~~~ 
//test.js
'use strict'
let a=2;
console.log(a);
~~~
node test.js
* node --harmony_desctructuring test.js 

### 新增功能
####  定义变量 let 
* let定义的变量只能在代码块中使用，具备块级作用域；var具备函数级作用域；
* 块级作用域其实就是匿名函数立即调用
* 变量不能重复定义
* 可用于封闭空间;封闭空间可解决i问题
以前：
    (function(i){
        var a=12; 
    })(i);
现在：
    {
        let  a=12;
    }
#### 定义常量 const
定义后则不能修改

#### 字符串连接
==反单引号==：==``==,内容模版,==${变量名}填充模版==
#### 解构赋值

* var [a,b,c]=[12,5,101];解析结构，给a、b、c都赋值；
* json格式（通过名称匹配，与顺序无关）也支持
* ==模式匹配==：var [a,[b,c],d] =[12,[3,2],101],左侧的样子需要和右侧一样
* 可==以给默认值==。var {time=12,date} ={data=123}
    
#### 复制数组
数组赋值为引用赋值，复制以前用for循环🔥 Array.from()函数，现在使用==超引用'...'==, var arr2 = [...arr1]; 在函数中通过 ...args 接收多个参数
#### 循环 
以前是for或for in，现在：for of，支持数组、json、map
~~~
//i表示数组或者json的值，for in中i是下标，for of中表示key+value，实质是jsonObj.entrys(),类似的还有jsonObj.keys()、jsonObj.values()
for(var i of arr){
    console.log(i);
}
~~~
#### map操作  
get()\set()\delete()
#### 箭头函数  => 
**注意事项**
* this问题  //this指向了window对象
* arguments不能使用，箭头函数没有自己的 arguments
~~~
function foo() { 
  var f = (...args) => args[0]; 
  return f(2); 
}

foo(1); // 2
~~~

更多：https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Functions/Arrow_functions

#### 对象语法简洁化
~~~
//以前
var person={
    name:'abc',
    age:100,
    showName:function(){
        alert(this.name);       //this有问题
    }
}

//ES6
var name='abc';
var age =100;
var person={
    name,
    age,
    showName(){
        alert(this.name);
    }
}
~~~

#### 面向对象
~~~
//以前面向对象
function Person(name,age){  //类和构造函数一体
    this.name = name;
    this.age = age;
}
Person.prototype.showName=function(){
    return this.name;
}
var p1 = new Person('abc',100);
alert(p1.name);
~~~

~~~
//ES6面向对象
class Person{
    constructor(name='defalut',age=0){  //此处可以设置默认值，这是函数的功能，即：函数参数可以给默认值
        this.name = name;
        this.age = age;
    }
    showName(){
        return this.name;
    }
}

var p1 = new Person('abc',100);
alert(p1.name);     
alert(p1.showName());
~~~

继承
~~~
//以前  子类.prototype = new 父类();
function Worker(name,age){
    Person.apply(this,arguments);
}
Worker.prototype=new Person();

//ES6
class Woker extends Person{
    constructor(){
        super();    //调用父级构造
    }
}
~~~

#### ES5:  this.bind();

#### 模块化
> 当前使用模块化必须引入traceur和bootstrap，type必须写成module

~~~
//定义
export default {a,b}
//引用
import modA from './a.js';
//使用
var sum = modA.a + modA.b
~~~

#### Promise
> 本身为一个对象，用来传递异步操作的数据

> 整体是链式操作

~~~
pending(等待、处理中)  ---> Resolve（完成）   
                     ---> Reject  (拒绝)
~~~
使用
~~~
var p1 = new Promise(function(resolve,reject){
    if(异步处理成功了)
        resolve(成功数据)
    else
        reject(失败原因)
});
~~~
包含方法如下：
~~~
所有方法都支持链式编程
*  then(成功(resolve数据),失败（reject数据）)  //此方法可以防止异步编程括号深度太多的的问题
*  catch（function（e）{}）；    // 用来捕获错误
*  all[p1,p2,p3....]  //用于将多个promise对象组合／包装成一个全新的promise对象,数组中的Promise又一个错误则按错误流程走，所有都成功则按成功流程走
*  Promise.race([p1,p2....]).then(function(value){}); //返回最先执行的Promise的结果
*  Promise.reject()         //生成错误的Promise
*  Promise.resolve()        //生成成功的Promise
~~~

#### Generator+yield
> Generator:生成器，是一个函数，可以遍历
 
* Generator函数名字前有*
* Generator函数内部使用yield语句
~~~
//普通函数
function show(){
    
}
//generator函数
function* show(){
    yield “Hello”；
    yield "World";
}
//generator函数
*show(){
    yield “Hello”；
    yield "World";
}

var res=show();
console.log(res.next());  //{value:"Hello",done:false}
console.log(res.next());  //{value:"World",done:false}
console.log(res.next());  //{value:"undefined",done:true}
~~~ 
* Generator函数调用后的对象有next方法
* next方法每次返回一个value和done结果，value位yield后面的值，done代表是否遍历结束
* yield语句本身没有返回值或每次返回undefined
* next可以带参数，所带参数给了上一个yield
* for ...of循环支持Generator函数
~~~
for (let v of show()){
        document.write(v);
}
~~~

#### 展开运算符
 扩展语法允许一个表达式在期望多个参数（用于函数调用）或多个元素（用于数组文本）或多个变量（用于解构赋值）的位置扩展
1. 用于函数调用
~~~
myFunction(...iterableObj);
~~~
2. 用于数组字面量
~~~
[...iterableObj, 4, 5, 6]
~~~

ECMA-262文档下载：https://chetaofeng.github.io/pub-images/Ecma-262.pdf