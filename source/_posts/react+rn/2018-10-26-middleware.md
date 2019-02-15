---
title: middleware
tags:
  - React 
copyright: true
comments: true
toc: true
date: 2018-10-26 15:32:09
categories: React
password:
---

https://zhuanlan.zhihu.com/p/20597452

# 简介
* middleware 提供了一个分类处理 action 的机会，在 middleware 中你可以检阅每一个流过的 action，挑选出特定类型的 action 进行相应操作，给你一次改变 action 的机会
* redux 的 middleware 是为了增强 dispatch 而出现的
* redux 提供了 applyMiddleware 这个 api 来加载 middleware

![image](/pub-images/redux-middleware1.png)
![image](/pub-images/redux-middleware2.png)

# 四步理解 middleware 机制
![image](/pub-images/middleware机制示例.png)

~~~
var middlewareAPI = {
  getState: store.getState,
  dispatch: (action) => dispatch(action)
};
chain = middlewares.map(middleware => middleware(middlewareAPI));
~~~

## 函数式编程思想设计 middleware
middleware 的设计有点特殊，是一个层层包裹的匿名函数，这其实是函数式编程中的柯里化 curry，一种使用匿名单参数函数来实现多参数函数的方法。applyMiddleware 会对 logger 这个 middleware 进行层层调用，动态地对 store 和 next 参数赋值

柯里化的 middleware 结构好处在于：
1. 易串联，柯里化函数具有延迟执行的特性，通过不断柯里化形成的 middleware 可以累积参数，配合组合（ compose，函数式编程的概念，Step. 2 中会介绍）的方式，很容易形成 pipeline 来处理数据流
2. 共享store，在 applyMiddleware 执行过程中，store 还是旧的，但是因为闭包的存在，applyMiddleware 完成后，所有的 middlewares 内部拿到的 store 是最新且相同的

## 给 middleware 分发 store
创建一个普通的 store 通过如下方式：
~~~
//applyMiddleware 函数陆续获得了三个参数
//第一个是 middlewares 数组，[mid1, mid2, mid3, ...]
//第二个 next 是 Redux 原生的 createStore
//最后一个是 reducer
let newStore = applyMiddleware(mid1, mid2, mid3, ...)(createStore)(reducer, null);
~~~


## 组合串联 middlewares
~~~
dispatch = compose(...chain)(store.dispatch); 
~~~
compose 是函数式编程中的组合，compose 将 chain 中的所有匿名函数，[f1, f2, ... , fx, ..., fn]，组装成一个新的函数，即新的 dispatch，当新 dispatch 执行时，[f1, f2, ... , fx, ..., fn]，从右到左依次执行（ 所以顺序很重要）

## 在 middleware 中调用 dispatch
在middleware 中调用 store.dispatch() 和在其他任何地方调用效果是一样的，而在 middleware 中调用 next()，效果是进入下一个 middleware