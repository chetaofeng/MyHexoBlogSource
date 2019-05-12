---
title: Ant Design of React+dva入门
tags:
  - dva 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

[toc]

# 简介
是 Ant Design 的 React 实现，开发和服务于企业级后台产品

# 安装使用Antd
1. npm install antd --save
2. 浏览器引入
* 在浏览器中使用 script 和 link 标签直接引入文件，并使用全局变量 antd
* 在 npm 发布包内的 antd/dist 目录下提供了 antd.js antd.css 以及 antd.min.js antd.min.css
* 也可以通过 CDNJS https://cdnjs.com/libraries/antd 或 UNPKG https://unpkg.com/antd@3.0.2/dist/ 进行下载
* 强烈不推荐使用已构建文件，这样无法按需加载，而且难以获得底层依赖模块的 bug 快速修复支持

# 安装使用dva
dva 是一个基于 React 和 Redux 的轻量应用框架，概念来自 elm，支持 side effects、热替换、动态加载、react-native、SSR 等，已在生产环境广泛应用。
~~~
npm install dva-cli -g
dva -v
dva new dva-quickstart
cd dva-quickstart
npm start
~~~
在浏览器里打开 http://localhost:8000 ，你会看到 dva 的欢迎界面

# dva项目中使用Antd
1. npm install antd babel-plugin-import --save
2. 编辑 .roadhogrc，使 babel-plugin-import 插件生效

# 按需加载Antd
使用 babel-plugin-import
~~~
// .babelrc or babel-loader option
{
  "plugins": [
    ["import", { "libraryName": "antd", "libraryDirectory": "es", "style": "css" }] // `style: true` 会加载 less 文件
  ]
}
~~~
然后只需从 antd 引入模块即可，无需单独引入样式。等同于下面手动引入的方式。

// babel-plugin-import 会帮助你加载 JS 和 CSS
import { DatePicker } from 'antd';

# 在 create-react-app 中使用
> create-react-app 是业界最优秀的 React 应用开发工具之一

> 使用create-react-app只是创建出了react应用的基本架构，类似于dva-cli创建的架构，antd还是需要自己添加

# dva的出现背景
https://github.com/sorrycc/blog/issues/1
 