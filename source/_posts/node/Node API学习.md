---
title: Node API学习
tags:
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

> Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境。 
Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效。 
Node.js 的包管理器 npm，是全球最大的开源库生态系统。

~~~
中文网址：http://nodejs.cn/
英文网址：https://nodejs.org/en/

其他相关网址：
https://www.npmjs.com/
https://github.com/
~~~

http://nodejs.cn/api/

---

[toc]

## node命令用法
~~~
node [options] [v8 options] [script.js | -e "script"] [arguments]
~~~
## assert (断言)
> assert 模块提供了一组简单的断言测试集合，可被用于测试不变量。 该模块在代码中可通过 require('assert') 使用。 assert 不是一个测试框架，也无意成为通用的断言库。 
## Buffer
> 在 ECMAScript 2015 (ES6) 引入 TypedArray 之前，JavaScript 语言没有读取或操作二进制数据流的机制。 Buffer 类被引入作为 Node.js API 的一部分，使其可以在 TCP 流和文件系统操作等场景中处理二进制数据流。

> 现在 TypedArray 已经被添加进 ES6 中，Buffer 类以一种更优与更适合 Node.js 用例的方式实现了 Uint8Array API。

> Buffer 类的实例类似于整数数组，除了其是大小固定的、且在 V8 堆外分配物理内存。 ==Buffer 的大小在其创建时就已确定，且不能调整大小==。

> Buffer 类在 Node.js 中是一个全局变量，因此无需 require('buffer').Buffer。

## C/C++ 插件
> Node.js 插件是用 C 或 C++ 编写的动态链接共享对象，可以使用 require() 函数加载到 Node.js 中，且像普通的 Node.js 模块一样被使用。 它们主要用于为运行于 Node.js 的 JavaScript 和 C/C++ 库之间提供接口。

* V8：Node.js 当前用于提供 JavaScript 实现的 C++ 库。 V8 提供了用于创建对象、调用函数等机制。 V8 的 API 文档主要在 v8.h 头文件中（Node.js 源代码中的 deps/v8/include/v8.h）==(V8在线文档) https://v8docs.nodesource.com/==
* libuv：实现了 Node.js 的事件循环、工作线程、与平台所有的的异步操作的 C 库。 它也是一个跨平台的抽象库，使所有主流操作系统中可以像 POSIX 一样访问常用的系统任务，比如与文件系统、socket、定时器和系统事件的交互。 libuv 还提供了一个类似 POSIX 多线程的线程抽象，可被用于强化更复杂的需要超越标准事件循环的异步插件。 鼓励插件开发者多思考如何通过在 libuv 的非阻塞系统操作、工作线程、或自定义的 libuv 线程中降低工作负载来避免在 I/O 或其他时间密集型任务中阻塞事件循环。
* 内置的 Node.js 库。Node.js 自身开放了一些插件可以使用的 C/C++ API。 其中最重要的是 node::ObjectWrap 类。
* Node.js 包含一些其他的静态链接库，如 OpenSSL。 这些库位于 Node.js 源代码中的 deps/ 目录。 只有 V8 和 OpenSSL 符号是被 Node.js 有目的地再导出，并且通过插件被用于不同的场景

## child_process (子进程)
> child_process 模块提供了衍生子进程的能力

## Cluster

## CLI(命令行选项)
> Node.js 自带了各种命令行选项。 这些选项对外暴露了内置调试、多种执行脚本的方式、以及其他有用的运行时选项。

> 要在终端中查看本文档作为操作手册，运行 man node

## console (控制台)
> console 模块提供了一个简单的调试控制台，它与 Web 浏览器提供的 JavaScript 控制台的机制类似。

~~~
console.time(label) //启动一个定时器，用以计算一个操作的持续时间。 定时器由一个唯一的 label 标识。 当调用 console.timeEnd() 时，可以使用相同的 label 来停止定时器，并以毫秒为单位将持续时间输出到 stdout。 定时器持续时间精确到亚毫秒。
console.timeEnd(label)  //停止之前通过调用 console.time() 启动的定时器，并打印结果到 stdout
console.trace(message[, ...args])   //打印字符串 'Trace :' 到 stderr ，并通过 util.format() 格式化消息与堆栈跟踪在代码中的当前位置。
~~~

## Crypto (加密)

## debugger (调试器)
> Node.js 包含一个进程外的调试工具，可以通过基于 TCP 的协议和内置调试客户端访问。 要使用它，可以带上 debug 参数启动 Node.js，并带上需要调试的脚本的路径；然后会显示一个提示，表明成功启动调试器

## DNS (域名服务器)

## Error 错误
Node.js 中运行的应用程序一般会遇到以下四类错误：
* 标准的 JavaScript 错误：
     1. <EvalError> : 当调用 eval() 失败时抛出。
     2. <SyntaxError> : 当 JavaScript 语法错误时抛出。
     3. <RangeError> : 当一个值不在预期范围内时抛出。
     4. <ReferenceError> : 当使用未定义的变量时抛出。
     5. <TypeError> : 当传入错误类型的参数时抛出。
     6. <URIError> : 当一个全局的 URI 处理函数被误用时抛出。
* 由底层操作系的触发的系统错误，例如试图打开一个不存在的文件、试图向一个已关闭的 socket 发送数据等
* 由应用程序代码触发的用户自定义的错误。
* 断言错误是错误的一个特殊的类，每当 Node.js 检测到一个不应该发生的异常逻辑时会触发。 这类错误通常由 assert 模块触发。

> JavaScript 的 throw 机制的任何使用都会引起异常，异常必须使用 try / catch 处理，否则 Node.js 进程会立即退出。

> ==开发者必须查阅各个方法的文档以明确在错误发生时这些方法是如何冒泡的。==

## events (事件)
> 大多数 Node.js 核心 API 都是采用惯用的异步事件驱动架构，其中某些类型的对象（称为触发器）会周期性地触发命名事件来调用函数对象（监听器）。

> ==所有能触发事件的对象都是 EventEmitter 类的实例==。 这些对象开放了一个 eventEmitter.on() 函数，允许将一个或多个函数附加到会被对象触发的命名事件上。==当 EventEmitter 对象触发一个事件时，所有附加在特定事件上的函数都被同步地调用。==

> 当新的监听器被添加时，所有的 EventEmitter 会触发 'newListener' 事件；当移除已存在的监听器时，则触发 'removeListener'。

> 每个事件默认可以注册最多 10 个监听器。可以通过一定方法设置。

~~~js
//此方法可用来自定义事件
const EventEmitter = require('events');
class MyEmitter extends EventEmitter {}
const myEmitter = new MyEmitter();
myEmitter.on('event', () => {
  console.log('发生了一个事件！');
});
myEmitter.emit('event');
~~~
#### 异步与同步
> EventListener 会按照监听器注册的顺序同步地调用所有监听器。 所以需要确保事件的正确排序且避免竞争条件或逻辑错误。监听器函数可以使用 setImmediate() 或 process.nextTick() 方法切换到异步操作模式.

* eventEmitter.on() //监听器会在==每次==触发命名事件时被调用
* eventEmitter.once() //注册一个对于特定事件被调用==最多一次==的监听器

#### 错误事件
> 当 EventEmitter 实例中发生错误时，会触发一个 'error' 事件.为了防止 Node.js 进程崩溃，可以在 process 对象的 uncaughtException 事件上注册监听器

## fs (文件系统)
> 文件 I/O 是由简单封装的标准 POSIX 函数提供的。 通过 require('fs') 使用该模块。 ==所有的方法都有异步和同步的形式==

> 异步形式始终以完成==回调作为它最后一个参数==。 传给完成回调的参数取决于具体方法，但==第一个参数总是留给异常==。 如果操作成功完成，则第一个参数会是 null 或 undefined。

> 当使用同步形式时，任何异常都会被立即抛出。 可以使用 try/catch 来处理异常，或让它们往上冒泡。

#### 同步和异步的比较
~~~
//同步的方式
const fs = require('fs'); 
fs.unlinkSync('/tmp/hello');
console.log('successfully deleted /tmp/hello');

//异步方式
const fs = require('fs'); 
fs.unlink('/tmp/hello', (err) => {
  if (err) throw err;
  console.log('successfully deleted /tmp/hello');
});
~~~
* 异步方法不保证执行顺序
* 异步方法之间如果有执行顺序，则正确的方法是把回调链起来
* 强烈推荐开发者使用这些函数的异步版本。 同步版本会阻塞整个进程，直到它们完成

## 全局变量
~~~
* __dirname     //当前模块的目录名。 等同于 __filename 的 path.dirname()
* __filename    //当前模块的文件名。 这是当前模块文件的解析后的绝对路径
* exports       //module.exports 的一个简短的引用
* module        //当前模块的引用。 具体地说，module.exports 用于定义一个模块导出什么，且通过 require() 引入
* require.resolve() //使用内部的 require() 机制来查找模块的位置，但不会加载模块，只返回解析后的文件名
~~~

## http
> Node.js 中的 HTTP 接口被设计为支持以往较难使用的协议的许多特性。 比如，大块编码的消息。 该接口从不缓存整个请求或响应，所以用户能够流化数据。

## https
> HTTPS 是 HTTP 基于 TLS/SSL 的版本。在 Node.js 中，它被实现为一个独立的模块。

## module (模块)
> Node.js 有一个简单的模块加载系统。 在 Node.js 中，文件和模块是一一对应的（每个文件被视为一个独立的模块）