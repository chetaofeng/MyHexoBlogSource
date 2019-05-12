---
title: 异步编程及Async模块的使用
tags:
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

[toc]

~~~
汇智网-异步编程：http://cw.hubwiz.com/card/c/543e1a4f032c7816c0d5dfa1/1/3/6/
~~~

# 简介
> github网址：https://github.com/caolan/async
* 异步编程是指由于异步I/O等因素，无法同步获得执行结果时，在回调函数中进行下一步操作的代码编写风格,常见的如setTimeout函数、ajax请求等等
* 使用Asycn模块需要安装，它不是node自带的
~~~
安装：npm install async 
引用：var async = require('async');
~~~
* 异常捕获：异步I/O的实现主要有两个阶段，①提交请求；②处理结果； 这两个阶段彼此不关联，而异常并不一定发生在请求提交（即调用函数）时，平常的try/catch并不能有效的捕捉到程序的异常

# 函数式编程
## 高阶函数
* 高阶函数与普通函数不同的地方是高阶函数可以把函数作为参数，或者是将函数作为返回值
* 函数作为参数；函数作为返回值；
~~~
//高阶函数test的返回值是一个匿名函数
function test(v){
  return function(){
    return v;
  }
}
~~~
## 偏函数
* 一个创建函数的工厂函数；通过指定部分参数，定制新的函数
* 假设有一个参数或变量已经预置的函数A，我们通过调用A来产生一个新的函数B，函数B就是我们说的偏函数
~~~
//isType函数中预置了判断类型的方法，只指定部分参数来产生的新的定制的函数isString和isFunction就是偏函数
var isType = function(type){
  return function(obj){
    return toString.call(obj)=='[object '+type+']';
  }
};
var isString = isType('String');
var isFunction = isType('Function');
~~~
编写偏函数
~~~
var say =function(name){
    return function(text){
        console.log(name+' say '+text);
    }
};
var tomSay = say('tom');

tomSay ('hello');
~~~
# 方法说明
## series
> 它是控制异步函数按照串行顺序执行，只有前一个执行完毕，才能执行下一个异步调用
~~~
async.series([function(cb){
    setTimeout(function(){
        cb(null,1);
    },1000)
},function(cb){
    setTimeout(cb,1000,null,2); 
}],function(err,result){  //result是每个回调函数传进来的data参数，result=[1,2]
    if (err) 
        console.error(err);
    else 
        console.log(result);
})
~~~

## parallel
> parallel的用法和series类似。只是数组中的函数是并行执行，parallel的总时间取决于运行时间最长的函数。而最终的回调函数里result的值是按照数组中函数的顺序排列的

## waterfall
> 和series函数有很多相似之处，都是按照顺序执行。
不同之处是waterfall每个函数产生的值，都将传给下一个函数，而series则没有这个功能
~~~
async.waterfall([function(cb){
    setTimeout(function(){
        cb(null,1);
    },1000)
},function(data,cb){
    setTimeout(cb,1000,null,data+"+"+"2");
}],function(err,result){  //result = "1+2"
    if (err) 
        console.error(err);
    else 
        console.log(result);
})
~~~ 

## parallelLimit(tasks, limit, [callback])
parallelLimit函数和parallel类似，但是它多了一个参数limit。 limit参数限制任务只能同时并发一定数量，而不是无限制并发

## whilst(test, fn, callback)
相当于while，但其中的异步调用将在完成后才会进行下一次循环;test参数是一个返回布尔值结果的函数，通过返回值来决定循环是否继续，作用等同于while循环停止的条件
~~~
var count = 0;
async.whilst(
    function () { return count < 5; },
    function (callback) {
        count++;
        setTimeout(callback, 1000);
    },
    function (err) {

    }
);
~~~

## doWhilst(fn, test, callback)
相当于do…while,较whilst而言，doWhilst交换了fn,test的参数位置，先执行一次循环，再做test判断

## until(test, fn, callback)
until与whilst正好相反，当test条件函数返回值为false时继续循环，与true时跳出。其它特性一致
~~~
var count = 5;
async.until(
    function () { return count < 0; },
    function (callback) {
        count--;
        setTimeout(callback, 1000);
    },
    function (err) {

    }
);
~~~

## doUntil(fn, test, callback)
doUntil与doWhilst正好相反，当test为false时循环，与true时跳出。其它特性一致

## forever(fn, errback)
forever函数比较特殊，它的功能是无论条件如何，函数都一直循环执行，只有出现程序执行的过程中出现错误时循环才会停止，callback才会被调用

## compose(fn1, fn2...)
使用compose可以创建一个异步函数的集合函数，将传入的多个异步函数包含在其中，当我们执行这个集合函数时，会依次执行每一个异步函数，每个函数会消费上一次函数的返回值

==注意==：从内层到外层的执行的顺序；从右往左执行
~~~
var async = require('async');
function fn1(n, callback) {
    setTimeout(function () {
        callback(null, n + 1);
    }, 1000);
}
function fn2(n, callback) {
    setTimeout(function () {
        callback(null, n * 3);
    }, 1000);
}
var demo = async.compose(fn2, fn1);
demo(4, function (err, result) {
    console.log(result);            //结果15
});
demo = async.compose(fn1, fn2);
demo(4, function (err, result) {
    console.log(result);            //结果13
});
~~~

## auto(tasks, [callback])
* 用来处理有依赖关系的多个任务的执行
* async.auto的强大是在于，你定义好相互之间的dependencies，他来帮你决定用parallel还是waterfull
~~~
async.auto({
    getData: function(callback){
        callback(null, 'data', 'converted to array');
    },
    makeFolder: function(callback){        
        callback(null, 'folder');
    },
    writeFile: ['getData', 'makeFolder', function(callback, results){        
        callback(null, 'filename');
    }],
    emailLink: ['writeFile', function(callback, results){
        callback(null, {'file':results.writeFile, 'email':'user@example.com'});
    }]
}, function(err, results) { 
    console.log('err = ', err);
    console.log('results = ', results);
});
~~~

## queue(worker, concurrency)
queue相当于一个加强版的parallel，主要是限制了worker数量，不再一次性全部执行。当worker数量不够用时，新加入的任务将会排队等候，直到有新的worker可用

## apply(function, arguments..)
apply是一个非常好用的函数，可以让我们给一个函数预绑定多个参数并生成一个可直接调用的新函数，简化代码
~~~
function(callback) { 
    test(3, callback); 
};
用apply改写：
async.apply(test, 3);
~~~

## iterator(tasks)
* 将一组函数包装成为一个iterator，可通过next()得到以下一个函数为起点的新的iterator。该函数通常由async在内部使用，但如果需要时，也可在我们的代码中使用它
* 直接调用()，会执行当前函数，并返回一个由下个函数为起点的新的iterator。调用next()，不会执行当前函数，直接返回由下个函数为起点的新iterator
* 对于同一个iterator，多次调用next()，不会影响自己。如果只剩下一个元素，调用next()会返回null
~~~
var iter = async.iterator([
    function() { console.log('111') },
    function() { console.log('222') },
    function() { console.log('333') }
]);
iter();
~~~