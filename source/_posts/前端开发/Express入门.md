---
title: Express入门
tags:
  - Express
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

~~~
中文网站：http://www.expressjs.com.cn/
~~~

# 安装
* 方法1:命令行模式
~~~
1. 确定已安装nodejs
2. mkdir 项目名称；cd 项目名称
3. npm init     //为应用创建一个 package.json 文件,然后根据提示操作或者一路回车
4. npm install express --save   //安装 Express 并将其保存到依赖列表中
5. 新建index.js文件进行编写
~~~
* 方法2:webstorm
~~~
1. npm install express -g //全局安装express
2. webstorm中选择Node.js Expresss App,然后创建
~~~
* 方法3:Express 应用生成器
~~~
1. 安装生成器：npm install express-generator -g
2. 查看express 命令的用法：express -h
3. 创建项目：express 项目名称
4. 安装依赖：npm install
~~~
* 运行：node index.js
* 访问： http://localhost:3000/ 

# 静态文件
* 通过 Express 内置的 express.static 可以方便地托管静态文件，例如图片、CSS、JavaScript 文件等
* 将静态资源文件所在的目录作为参数传递给 express.static 中间件就可以提供静态资源文件的访问了，如：app.use(express.static('public'))，这样public下面的文件就可以直接访问了，如：http://localhost:3000/images/kitten.jpg
* 通过为静态资源目录指定一个挂载路径的方式来实现访问的文件都存放在一个“虚拟（virtual）”目录（即目录根本不存在），如：
~~~
* app.use('/static', express.static('public'));
* 访问：http://localhost:3000/static/images/kitten.jpg
~~~
# 常见问题
1. 如何处理 404 
~~~
Express 执行了所有中间件、路由之后还是没有获取到任何输出。你所需要做的就是在其所有他中间件的后面添加一个处理 404 的中间件
~~~
2. 如何设置一个错误处理器
~~~
错误处理器中间件的定义和其他中间件一样，唯一的区别是 4 个而不是 3 个参数，即 (err, req, res, next)
~~~
3. 如何渲染纯 HTML 文件
~~~
无需通过 res.render() 渲染 HTML。你可以通过 res.sendFile() 直接对外输出 HTML 文件。如果你需要对外提供的资源文件很多，可以使用 express.static() 中间件
~~~

# 路由
学习网址：http://www.expressjs.com.cn/guide/routing.html
* 路由（Routing）是由一个 URI（或者叫路径）和一个特定的 HTTP 方法（GET、POST 等）组成的，涉及到应用如何响应客户端对某个网站节点的访问
* 每一个路由都可以有一个或者多个处理器函数，当匹配到路由时，这个/些函数将被执行
* 路由的定义由如下结构组成：
~~~
app.METHOD(PATH, HANDLER)
其中，
app 是一个 express 实例；
METHOD 是某个 HTTP 请求方式中的一个；
PATH 是服务器端的路径；
HANDLER 是当路由匹配到时需要执行的函数
~~~
* app.all() 是一个特殊的路由方法，没有任何 HTTP 方法与其对应，它的作用是对于一个路径上的所有请求加载中间件
~~~
//来自 “/secret” 的请求，不管使用 GET、POST、PUT等方法请求，句柄都会得到执行
app.all('/secret', function (req, res, next) {
  console.log('Accessing the secret section ...');
  next(); // pass control to the next handler
});
~~~
1. 路由路径：路由路径和请求方法一起定义了请求的端点，它可以是字符串、字符串模式或者正则表达式
2. 路由句柄：可以为请求处理提供多个回调函数，其行为类似 中间件；路由句柄有多种形式，可以是一个函数、一个函数数组，或者是两者混合
~~~
app.get('/example/b', function (req, res, next) {
  console.log('response will be sent by the next function ...');
  next();
}, function (req, res) {
  res.send('Hello from B!');
});
//混合方式
app.get('/example/d', [cb0, cb1], function (req, res, next) {
  console.log('response will be sent by the next function ...');
  next();
}, function (req, res) {
  res.send('Hello from D!');
});
~~~
3. 响应方法：下表中响应对象（res）的方法向客户端返回响应，终结请求响应的循环。如果在路由句柄中一个方法也不调用，来自客户端的请求会一直挂起

方法|描述
----|-----
res.download()|提示下载文件。
res.end()|终结响应处理流程。
res.json()|发送一个 JSON 格式的响应。
res.jsonp()|发送一个支持 JSONP 的 JSON 格式的响应。
res.redirect()|重定向请求。
res.render()|渲染视图模板。
res.send()|发送各种类型的响应。
res.sendFile|以八位字节流的形式发送文件。
res.sendStatus()|设置响应状态代码，并将其以字符串形式作为响应体的一部分发送。

* app.route()：可使用 app.route() 创建路由路径的链式路由句柄
~~~
app.route('/book')
  .get(function(req, res) {
    res.send('Get a random book');
  })
  .post(function(req, res) {
    res.send('Add a book');
  })
  .put(function(req, res) {
    res.send('Update the book');
  });
~~~
* express.Router:可使用 express.Router 类创建模块化、可挂载的路由句柄。推荐。定于格式如下：
~~~
//brid.js
var express = require('express');
var router = express.Router();

// 该路由使用的中间件  可选
router.use(function timeLog(req, res, next) {
  console.log('Time: ', Date.now());
  next();
});
 
// 定义 about 页面的路由
router.get('/about', function(req, res) {
  res.send('About birds');
});

module.exports = router;

//加载使用
var birds = require('./birds');
...
app.use('/birds', birds);
~~~

# 中间件
> Express 是一个自身功能极简，完全是由路由和中间件构成一个的 web 开发框架：从本质上来说，一个 Express 应用就是在调用各种中间件

> 中间件（Middleware） 是一个函数，它可以访问请求对象（request object (req)）, 响应对象（response object (res)）, 和 web 应用中处于请求-响应循环流程中的中间件，一般被命名为 next 的变量；如果当前中间件没有终结请求-响应循环，则必须调用 next() 方法将控制权交给下一个中间件，否则请求就会挂起

> 中间件的功能：执行任何代码；修改请求和响应对象；终结请求-响应循环；调用堆栈中的下一个中间件

Express 应用中间件种类：
1. 应用级中间件
2. 路由级中间件
3. 错误处理中间件
4. 内置中间件
5. 第三方中间件

## 应用级中间件
应用级中间件绑定到 app 对象 使用 app.use() 和 app.METHOD()， 其中， METHOD 是需要处理的 HTTP 请求的方法，例如 GET, PUT, POST 等等，全部小写
* 中间件系统的路由句柄可以为路径定义多个路由
* 各路由之间通过next()逐次调用
* 调用过程中如果某个路由句柄已经终止了请求-响应循环，则后面的路由及其句柄不会执行，也不会报错
* 如果需要在中间件栈中跳过剩余中间件，调用 next('route') 方法将控制权交给下一个路由； next('route') 只对使用 app.VERB() 或 router.VERB() 加载的中间件有效
~~~
// 一个中间件栈，处理指向 /user/:id 的 GET 请求
app.get('/user/:id', function (req, res, next) {
  // 如果 user id 为 0, 跳到下一个路由
  if (req.params.id == 0) next('route');
  // 否则将控制权交给栈中下一个中间件
  else next(); //
}, function (req, res, next) {
  // 渲染常规页面
  res.render('regular');
});

// 处理 /user/:id， 渲染一个特殊页面
app.get('/user/:id', function (req, res, next) {
  res.render('special');
});
~~~

## 路由级中间件
* 路由级中间件和应用级中间件一样，只是它绑定的对象为 express.Router(),使用：var router = express.Router();
* 路由级使用 router.use() 或 router.VERB() 加载
* 需要将路由挂载至应用，通过 app.use挂载

## 错误处理中间件
错误处理中间件有 4 个参数，定义错误处理中间件时必须使用这 4 个参数。即使不需要 next 对象，也必须在签名中声明它，否则中间件会被识别为一个常规中间件，不能处理错误

## 内置中间件
从 4.x 版本开始，, Express 已经不再依赖 Connect 了。除了 express.static, Express 以前内置的中间件现在已经全部单独作为模块安装使用了

express.static(root, [options])
* 参数 root 指提供静态资源的根目录
* 可选的 options 参数拥有如下属性

属性|描述|类型|缺省值
---|---|---|---
dotfiles|是否对外输出文件名以点（.）开头的文件。可选值为 “allow”、“deny” 和 “ignore”|String	|“ignore”
etag|是否启用 etag 生成	|Boolean|true
extensions|设置文件扩展名备份选项|Array|[]
index|发送目录索引文件，设置为 false 禁用目录索引|Mixed|“index.html”
lastModified|设置 Last-Modified 头为文件在操作系统上的最后修改日期。可能值为 true 或 false|Boolean|true
maxAge|以毫秒或者其字符串格式设置 Cache-Control 头的 max-age 属性|Number|0
redirect|当路径为目录时，重定向至 “/”|Boolean|	true
setHeaders|设置 HTTP 头以提供文件的函数|	Function	 

## 第三方中间件
* 通过使用第三方中间件从而为 Express 应用增加更多功能
* 安装所需功能的 node 模块，并在应用中加载，可以在应用级加载，也可以在路由级加载

# 在 Express 中使用模板引擎
需要在应用中进行如下设置才能让 Express 渲染模板文件：
* views, 放模板文件的目录，比如： app.set('views', './views')
* view engine, 模板引擎，比如： app.set('view engine', 'jade')
* 安装相应的模板引擎 npm 软件包:npm install jade --save

# 错误处理
* 在其他 app.use() 和路由调用后，最后定义错误处理中间件
* next() 和 next(err) 类似于 Promise.resolve() 和 Promise.reject()。它们让您可以向 Express 发信号，告诉它当前句柄执行结束并且处于什么状态。next(err) 会跳过后续句柄，除了那些用来处理错误的句柄

# 调试 Express
* debug 有点像改装过的 console.log，不同的是，您不需要在生产代码中注释掉 debug。它会默认关闭，而且使用一个名为 DEBUG 的环境变量还可以打开
* 在启动应用时，设置 DEBUG 环境变量为 express:*，可以查看 Express 中用到的所有内部日志。webstorm中默认已设置
* 设置 DEBUG 的值为 express:router，只查看路由部分的日志；设置 DEBUG 的值为 express:application，只查看应用部分的日志

# 集成数据库
为 Express 应用添加连接数据库的能力，只需要加载相应数据库的 Node.js 驱动即可
## MySQL
npm install mysql --save
~~~
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'dbuser',
  password : 's3kreee7'
});

connection.connect();

connection.query('SELECT 1 + 1 AS solution', function(err, rows, fields) {
  if (err) throw err;
  console.log('The solution is: ', rows[0].solution);
});

connection.end();
~~~
## MongoDB
npm install mongoskin
~~~
var db = require('mongoskin').db('localhost:27017/animals');

db.collection('mamals').find().toArray(function(err, result) {
  if (err) throw err;
  console.log(result);
});
~~~
## SQLite
npm install sqlite3
~~~
var sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database(':memory:');

db.serialize(function() {

  db.run('CREATE TABLE lorem (info TEXT)');
  var stmt = db.prepare('INSERT INTO lorem VALUES (?)');

  for (var i = 0; i < 10; i++) {
    stmt.run('Ipsum ' + i);
  }

  stmt.finalize();

  db.each('SELECT rowid AS id, info FROM lorem', function(err, row) {
    console.log(row.id + ': ' + row.info);
  });
});

db.close();
~~~

## 中文API
http://www.expressjs.com.cn/4x/api.html