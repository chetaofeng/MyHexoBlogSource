---
title: CommonJS规范&AMD&CMD
tags:
  - 前端规范 
copyright: true
comments: true
toc: true
date: 2018-10-26 15:41:00
categories: 前端
password:
---

> 浏览器端的js和服务器端js都主要做了哪些事

服务器端JS | 浏览器端JS
---------- | ----------
相同的代码需要多次执行|代码需要从一个服务器端分发到多个客户端执行
CPU和内存资源是瓶颈|带宽是瓶颈
加载时从磁盘中加载| 加载时需要通过网络加载

> CommonJS是主要为了JS在==后端的表现制定==的，他是不适合前端的;AMD(异步模块定义)出现了，它就主要==为前端JS的表现制定规范==

> CommonJS规范加载模块是同步的，也就是说，只有加载完成，才能执行后面的操作。

> AMD规范则是非同步加载模块，允许指定回调函数。

>由于Node.js主要用于服务器编程，模块文件一般都已经存在于本地硬盘，所以加载起来比较快，不用考虑非同步加载的方式，所以CommonJS规范比较适用。但是，如果是浏览器环境，要从服务器端加载模块，这时就必须采用非同步模式，因此浏览器端一般采用AMD规范

[toc]

# CommonJS
> CommonJS规范: http://javascript.ruanyifeng.com/nodejs/module.html

> CommonJS模块的特点如下:

~~~
所有代码都运行在模块作用域，不会污染全局作用域。
模块可以多次加载，但是只会在第一次加载时运行一次，然后运行结果就被缓存了，以后再加载，就直接读取缓存结果。要想让模块再次运行，必须清除缓存。
模块加载的顺序，按照其在代码中出现的顺序
~~~

> CommonJS是一种规范，NodeJS是这种规范的实现

> JavaScript是一个强大面向对象语言，它有很多快速高效的解释器。官方JavaScript标准定义的API是为了构建基于浏览器的应用程序。然而，并没有定于一个用于更广泛的应用程序的标准库。

> CommonJS API定义很多普通应用程序（主要指非浏览器的应用）使用的API，从而填补了这个空白。它的终极目标是提供一个类似Python，Ruby和Java标准库。这样的话，开发者可以使用CommonJS API编写==应用程序==，然后这些应用可以运行在不同的JavaScript解释器和不同的主机环境中。 

CommonJS定义的模块分为:模块引用(require)；模块定义(exports)；模块标识(module) 

## require
> require命令用于加载文件，后缀名默认为.js

> 每个模块中有一个自由变量require，它是一个方法，这个方法接受一个参数，即模块的唯一ID。

> CommonJS模块的加载机制是，输入的是被输出的值的拷贝。也就是说，一旦输出一个值，模块内部的变化就影响不到这个值
 
> require根据外部模块ID，返回该模块输出的API。如果外部模块被required的时候还没有执行完，require至少应改返回该模块的exports（另一个自由变量）。如果必需的模块不存在，require方法应该抛出一个异常。

> require可以有一个main属性，属性值要么为undefined，要么等于module（另一个自由变量）;可以用来判断模块是直接执行，还是被调用执行。直接执行的时候（node module.js），require.main属性指向模块本身;调用执行的时候（通过require加载该脚本执行），==require.main === module== 返回false

> require可以有一个paths属性，属性值为由路径字符串组成的数组，路径按优先级从高到低的顺序排列

根据参数的不同格式，require命令去不同路径寻找模块文件
~~~
* 如果参数字符串以“/”开头，则表示加载的是一个位于绝对路径的模块文
* 如果参数字符串以“./”开头，则表示加载的是一个位于相对路径的模块文件
* 如果参数字符串不以“./“或”/“开头，则表示加载的是一个默认提供的核心模块或者一个位于各级node_modules目录的已安装模块
* 如果参数字符串不以“./“或”/“开头，而且是一个路径如果参数字符串不以“./“或”/“开头，而且是一个路径，比如require('example-module/path/to/file')，则将先找到example-module的位置，然后再以它为参数，找到后续路径。
* 如果指定的模块文件没有发现，Node会尝试为文件名添加.js、.json、.node后，再去搜索
* 如果想得到require命令加载的确切文件名，使用require.resolve()方法
~~~

## exports
每个模块中还有一个自由变量exports，它是一个对象，==模块对外输出的API就绑定在这个对象上==。而且==exports是模块对外输出API的唯一途径==。Node为每个模块提供一个exports变量，指向module.exports

> 不能直接将exports变量指向一个值，因为这样等于切断了exports与module.exports的联系

## module
CommonJS规范规定，每个模块内部，module变量代表当前模块。这个变量是一个对象，它的exports属性（即module.exports）是对外的接口。==加载某个模块，其实是加载该模块的module.exports属性==

> 每个模块中必须有一个自由变量module，它是对象。这个对象有一个id属性，表示该模块的id，同时应该是只读属性。

> module对象可以有一个uri属性，表示这个模块被加载的来源。

每个模块内部，都有一个module对象，代表当前模块。它有以下属性:
~~~
module.id 模块的识别符，通常是带有绝对路径的模块文件名。
module.filename 模块的文件名，带有绝对路径。
module.loaded 返回一个布尔值，表示模块是否已经完成加载。
module.parent 返回一个对象，表示调用该模块的模块。
module.children 返回一个数组，表示该模块要用到的其他模块。
module.exports 表示模块对外输出的值
~~~

## 目录的加载规则
> 通常，我们会把相关的文件会放在一个目录里面，便于组织。这时，最好为该目录设置一个入口文件，让require方法可以通过这个入口文件，加载整个目录

> 在目录中放置一个package.json文件，并且将入口文件写入main字段

> 如果package.json文件没有main字段，或者根本就没有package.json文件，则会加载该目录下的index.js文件或index.node文件

## 模块的缓存
> 第一次加载某个模块时，Node会缓存该模块。以后再加载该模块，就直接从缓存取出该模块的module.exports属性

> 所有缓存的模块保存在require.cache之中，如果想删除模块的缓存，可以像下面这样写
~~~
// 删除指定模块的缓存
delete require.cache[moduleName];

// 删除所有模块的缓存
Object.keys(require.cache).forEach(function(key) {
  delete require.cache[key];
})
~~~

# AMD
> AMD就只有一个接口：define(id?,dependencies?,factory);

> RequireJS就是实现了AMD规范

# CMD
> 大名远扬的玉伯写了seajs，就是遵循他提出的CMD规范，与AMD蛮相近的，不过用起来感觉更加方便些，最重要的是中文版