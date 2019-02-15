---
title: redux-thunk
tags:
  - React
  - redux组件库
copyright: true
comments: true
toc: true
date: 2018-10-26 15:30:47
categories: React
password:
---
# 简介
* redux-thunk 是一个比较流行的 redux 异步 action 中间件，比如 action 中有 setTimeout 或者通过  fetch 通用远程 API 这些场景，那么久应该使用 redux-thunk 了
* redux-thunk 帮助你统一了异步和同步 action 的调用方式，把异步过程放在 action 级别解决，对 component 没有影响
* redux-thunk中间件可以让action创建函数先不返回一个action对象，而是返回一个函数，函数传递两个参数(dispatch,getState),在函数体内进行业务逻辑的封装
~~~
function add() {
    return {
        type: 'ADD',
    }
}

function addIfOdd() {
    return (dispatch, getState) => {
        const currentValue = getState();
        if (currentValue % 2 == 0) {
            return false;
        }
        //分发一个任务
        dispatch(add())
    }
}
~~~

# 使用方式
1. 安装:npm install redux-thunk --save-dev
2. 导入thunk： import thunk from 'redux-thunk'
3. 导入中间件: import {createStore,applyMiddleware} from 'redux'
4. 创建store：let store = createStore(reducer函数，applyMiddleware(thunk))
5. 激活redux-thunk中间件，只需要在createStore中加入applyMiddleware(thunk)就可以