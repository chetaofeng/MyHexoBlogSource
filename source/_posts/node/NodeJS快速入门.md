---
title: NodeJS快速入门
tags:
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

http://cw.hubwiz.com/card/c/5359f6f6ec7452081a7873d8/1/1/2/

[toc]

## Node中标准回调函数
~~~js
function(err,data){

}
第一个参数为err是错误信息
第二个参数为data是返回的数据
~~~

## 进程管理

> process是一个全局内置对象，可以在代码中的任何位置访问此对象，这个对象代表我们的node.js代码宿主的操作系统进程对象。

> 使用process对象可以截获进程的异常、退出等事件，也可以获取进程的当前目录、环境变量、内存占用等信息，还可以执行进程退出、工作目录切换等操作。

~~~
* process.cwd();            //查看应用程序当前目录
* process.chdir("目录");    //改变应用程序目录
* stdout是标准输出流,作用就是将内容打印到输出设备上
    console.log = function(d){
        process.stdout.write(d+'\n');
    } 
* stderr是标准错误流,用来打印错误信息,可以通过它来捕获错误信息     //process.stderr.write(输入内容);
* stdin是进程的输入流,我们可以通过注册事件的方式来获取输入的内容
    process.stdin.on('readable', function() {
      var chunk = process.stdin.read();
      if (chunk !== null) {
        process.stdout.write('data: ' + chunk);
      }
    });
* process.exit(code);   //需要在程序内杀死进程，退出程序时使用，参数code为退出后返回的代码，如果省略则默认返回0；
* process.on()；        //此方法可监听进程事件
  exit事件：//当进程要退出之前，会触发exit事件。通过监听exit事件，我们可就以在进程退出前进行一些清理工作： 
        process.on("exit",function(code){//参数code表示退出码 
          console.log("I am tired...")//进行一些清理工作
        }); 
    uncaughtException事件:  //如果进程发生了未捕捉的异常，会触发uncaughtException事件。通过监听这个事件，可以 让进程优雅的退出
        process.on("uncaughtException",function(err){
            console.log(err);
        });
        throw new Error("我故意的..."); //故意抛出一个异常
* 设置编码
  process.stdin.setEncoding(编码);
  process.stdout.setEncoding(编码);
  process.stderr.setEncoding(编码);
~~~

## 子进程
> ==node.js是基于单线程模型架构==，这样的设计可以带来高效的CPU利用率，但是无法却利用多个核心的CPU，为了解决这个问题，node.js提供了==child_process模块，通过多进程来实现对多核CPU的利用==

> child_process模块提供了四个创建子进程的函数，分别是spawn，exec，execFile和fork。
1. spawn函数用给定的命令发布一个子进程，只能运行指定的程序，参数需要在列表中给出
~~~
var child_process = require('child_process');
var child = child_process.spawn( command );
child.stdout.on('data', function(data) {
  console.log(data);
});
通过执行命令得到返回结果
~~~
2. exec也是一个创建子进程的函数，与spawn函数不同它可以直接接受一个回调函数作为参数
~~~
var child_process = require('child_process');
child_process.exec( command , function(err, stdout , stderr ) {
  console.log( stdout );
});
~~~
3. execFile函数与exec函数类似，但execFile函数更显得精简，因为它可以直接执行所指定的文件
~~~
var child_process = require('child_process');
child_process.execFile( file , function(err, stdout , stderr ) {
  console.log( stdout );
});
~~~
4. ==fork函数可直接运行Node.js模块==，所以我们可以直接通过指定模块路径而直接进行操作.==该方法是spawn()的特殊情景，用于派生Node进程==
~~~
var child_process = require('child_process');
child_process.fork( modulePath );
~~~


## 文件I/O
> node.js中提供一个名为fs的模块来支持I/O操作，fs模块的文件I/O是对标准POSIX函数的简单封装。

> fs模块不但提供异步的文件操作，还提供相应的同步操作方法，需要指出的是，nodejs采用异步I/O正是为了避免I/O时的等待时间，提高CPU的利用率，所以在选择使用异步或同步方法的时候需要权衡取舍。
---

* fs.writeFile(filename, data, callback)
> 异步的将数据写入一个文件
如果文件已经存在则会被替换;数据参数可以是string或者是Buffer,编码格式参数可选，默认为"utf8"
~~~
var fs= require("fs"); 
fs.writeFile('test.txt', 'Hello Node', function (err) {
   if (err) throw err;
   console.log('Saved successfully'); //文件被保存
}); 
~~~

* fs.appendFile(文件名,数据,编码,回调函数(err));
> 将新的内容追加到已有的文件中，如果文件不存在，则会创建一个新的文件;编码格式默认为"utf8"
~~~
var fs= require("fs"); 
fs.appendFile('test.txt', 'data to append', function (err) {
   if (err) throw err;  
    console.log('The "data to append" was appended to file!'); 
});
~~~

* fs.exists(文件，回调函数(exists));    //exists的回调函数只有一个参数，类型为布尔型，通过它来表示文件是否存在
* fs.rename(旧文件，新文件，回调函数(err)); ==//修改文件名称==
* fs.rename(oldPath,newPath,function (err); ==//移动文件==
* fs.readFile(文件,[编码],回调函数);    //读取文件内容
* fs.unlink(文件,回调函数(err)); ==//删除文件==
* fs.mkdir(路径，权限，回调函数(err)); //创建目录；
~~~
权限：默认为0777，表示文件所有者、文件所有者所在的组的用户、所有用户，都有权限进行读、写、执行的操作
~~~

* fs.rmdir(路径，回调函数(err)); //删除目录
* fs.readdir(目录,回调函数(err,files));//读取目录下所有的文件

## url处理
> node.js为互联网而生，和url打交道是无法避免的了，url模块提供一些基础的url处理。

* url.parse('http://www.baidu.com');    //解析url，返回一个json格式的数组
* url.parse('http://www.baidu.com?page=1',true);//当==第二个==参数为true时，会将查询条件也解析成json格式的对象。
* url.parse('http://www.baidu.com/news',false,true);当==第三个==参数为true，解析时会将url的"//"和第一个"/"之间的部分解析为主机名
* url.format({
                protocol: 'http:',
                hostname:'www.baidu.com',
                port:'80',
                pathname :'/news',
                query:{page:1}
                }
  );
==**作用与parse相反，它的参数是一个JSON对象，返回一个组装好的url地址**==
* url.resolve('http://example.com/two', '/one')；//组装路径，第一个路径是开始的路径或者说当前路径，第二个则是想要去往的路径。==结果：=='http://example.com/one'

## path优化
> 本模块包含一套用于处理和转换文件路径的工具集,用于处理目录的对象，提高用户开发效率

* path.normalize('/path///normalize/hi/..');//将不符合规范的路径经过格式化转换为标准路径,解析路径中的.与..外，还能去掉多余的斜杠
* path.join('///you', '/are', '//beautiful');//结果：'/you/are/beautiful'。join函数将传入的多个路径拼接为标准路径并将其格式化，返回规范后的路径，避免手工拼接路径字符串的繁琐
* path.dirname('/foo/strong/cool/nice'); //用来返回路径中的目录名
* basename函数可返回路径中的最后一部分，并且可以对其进行条件排除.
1. path.basename('路径字符串');
2. path.basename('路径字符串', '[ext]')<排除[ext]后缀字符串>;
*  path.extname('index.html'); //返回路径中文件的扩展名

## 字符串转换 
> Query String模块用于==实现URL参数字符串与参数对象之间的互相转换==，提供了"stringify"、"parse"等一些实用函数来针对字符串进行处理，通过序列化和反序列化，来更好的应对实际开发中的条件需求，对于逻辑的处理也提供了很好的帮助

### 序列化
--- 
* querystring.stringify({foo:'bar',cool:['xux', 'yys']}); //结果：foo=bar&cool=xux&cool=yys。
~~~
作用就是序列化对象，也就是说将对象类型转换成一个字符串类型（默认的分割符（"&"）和分配符（"="））
~~~
* querystring.stringify("对象"，"分隔符"，"分配符")
~~~
querystring.stringify({foo:'bar',cool:['xux', 'yys']},'*','$');
结果：'foo$bar*cool$xux*cool$yys'
~~~

### 反序列化
---
* querystring.parse('foo=bar&cool=xux&cool=yys');
~~~
运行结果：{ foo: 'bar', cool: ['xux', 'yys']}
parse函数的作用就是反序列化字符串（默认是由"="、"&"拼接而成），转换得到一个对象类型
~~~
* querystring.parse('foo@bar$cool@xux$cool@yys','@','$');
~~~
运行结果：{ foo: '', bar: 'cool', xux: 'cool', yys: '' }
~~~

## 实用工具
>util模块。util模块呢，是一个Node.js核心模块，提供常用函数的集合，用于弥补核心JavaScript的一些功能过于精简的不足。并且还提供了一系列常用工具，用来对数据的输出和验证

* util.inspect(object,[showHidden],[depth],[colors])； //将任意对象转换为字符串的函数，通常用于调试和错误输出
* format函数
~~~
1. 如果占位符没有相对应的参数，占位符将不会被替换
2. 如果有多个参数占位符，额外的参数将会调用util.inspect()转换为字符串。这些字符串被连接在一起，并且以空格分隔
3. 如果第一个参数是一个非格式化字符串，则会把所有的参数转成字符串并以空格隔开拼接在一块，而且返回该字符串
~~~
* util.isArray(object);  //判断对象是否为数组类型，是则返回ture,否则为fals
* util.isDate(object); //判断对象是否为日期类型，是则返回ture,否则返回false
* util.isRegExp(object); //判断对象是否为正则类型，是则返回ture,否则返回false