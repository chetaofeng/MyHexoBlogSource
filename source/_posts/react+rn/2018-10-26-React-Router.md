---
title: React Router
tags:
  - React
  - React-Router
copyright: true
comments: true
toc: true
date: 2018-10-26 15:18:27
categories: React
password:
---
https://reacttraining.com/react-router/

# 概述
React Router 4.0 （以下简称 RR4）

RR4 本次采用单代码仓库模型架构（monorepo），这意味者这个仓库里面有若干相互独立的包，分别是：
~~~
react-router React Router 核心
react-router-dom 用于 DOM 绑定的 React Router
react-router-native 用于 React Native 的 React Router
react-router-redux React Router 和 Redux 的集成
react-router-config 静态路由配置的小助手
~~~

> 它是官方维护的，事实上也是唯一可选的路由库。

# react-router 还是 react-router-dom
1. 在 React 的使用中，我们一般要引入两个包，react 和 react-dom
2. react-router 和 react-router-dom 两个只要引用一个就行了，不同之处就是后者比前者多出了 <Link> <BrowserRouter> 这样的 DOM 类组件


# 学习
* （阮一峰）http://www.ruanyifeng.com/blog/2016/05/react_router.html
* （gitbook）http://react-guide.github.io/react-router-cn/docs/API.html