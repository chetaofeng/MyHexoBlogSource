---
title: readline模块的使用
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

API: http://nodejs.cn/api/readline

# 简介
Readline是Node.js里实现标准输入输出的封装好的模块，通过这个模块我们可以以逐行的方式读取数据流。使用require(“readline”)可以引用模块

# 创建Readline实例
readline.createInterface(options)
~~~
创建一个readline的接口实例. 接受一个Object类型参数，可传递以下几个值:

input - 要监听的可读流 (必需)
output - 要写入 readline 的可写流 (必须).
completer - 用于 Tab 自动补全的可选函数。(不常用)
terminal - 如果希望 input 和 output 流像 TTY 一样对待，那么传递参数 true ，并且经由 ANSI/VT100 转码。 默认情况下检查 isTTY 是否在 output 流上实例化。(不常用)

var readline = require(‘readline’); 
var rl = readline.createInterface({ 
    input: process.stdin, 
    output: process.stdout 
});
~~~

# 接口
* rl.close()：关闭接口实例 (Interface instance), 放弃控制输入输出流。”close” 事件会被触发
* rl.pause()：暂停 readline 的输入流 (input stream), 如果有需要稍后还可以恢复
* rl.prompt([preserveCursor])：为用户输入准备好readline，将现有的setPrompt选项放到新的一行，让用户有一个新的地方开始输入。将preserveCursor设为true来防止光标位置被重新设定成0
* rl.question(query, callback)：预先提示指定的query，然后用户应答后触发指定的callback。 显示指定的query给用户后，当用户的应答被输入后，就触发了指定的callback
* rl.resume()：恢复 readline 的输入流 (input stream)
* rl.setPrompt(prompt)：设置提示符，例如当你在命令行运行 node 时，你会看到(prompt)

# 示例
~~~
var readline = require('readline');
var rl = readline.createInterface(process.stdin,process.stdout);

// question方法
rl.question('what is you name? ',function(answer){
  console.log('my name is ' + answer);
  //不加close，则不会结束
  rl.close();
});
// close事件监听
rl.on('close',function(){
  console.log('欢迎下次再来');
  process.exit(0);
});
~~~