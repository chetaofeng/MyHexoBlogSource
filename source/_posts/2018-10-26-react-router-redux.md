---
title: react-router-redux
tags:
  - React
  - React组件
copyright: true
comments: true
toc: true
date: 2018-10-26 15:24:49
categories: React
password:
---

# 概述
> 用Redux去管理你的应用状态（state），使用React Router去管理路由，但是，这两个库不能协同工作，react-router-redux库可以协调这两个库

> react-router-redux允许你使用React Router库中的api，使用Redux库像平常一样去管理应用的状态state。 本库只是简单的加强了React Router库中history这个实例，以允许将history中接受到的变化反应到stae中去。

# 原理示例
![image](/pub-images/react-router-redux示例.png)
现在，你进行的所有页面导航和App导航，加强版的history会首先将新的路径通过Redux store传递，然后再通过React Router去更新组件树