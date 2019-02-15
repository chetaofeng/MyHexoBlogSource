---
title: CSS预处理技术
tags:
  - CSS  
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

CSS预处理器技术已经非常的成熟，而且也涌现出了越来越多的 CSS 的预处理器框架。最普遍的分别是 Sass、Less CSS、Stylus，本文以Less重点讲解。

CSS预处理器
CSS 预处理器是一种语言用来为 CSS 增加一些编程的的特性，无需考虑浏览器的兼容性问题，例如你可以在 CSS 中使用变量、简单的程序逻辑、函数等等在编程语言中的一些基本技巧，可以让你的 CSS 更见简洁，适应性更强，代码更直观等诸多好处

1.Less 可以运行在 Node、浏览器和 Rhino 平台上。网上有很多第三方工具帮助你编译 Less 源码
2.Less 可以通过 npm 在命令行上运行；在浏览器上作为脚本文件下载；或者集成在广大的第三方工具内
3.在服务器端最容易的安装方式就是通过 npm （node.js 的包管理器），方法如下：npm install -g less
4.安装 Less 后，就可以在命令行上调用 Less 编译器了，如：lessc styles.less或lessc styles.less > styles.css
若要输出压缩过的 CSS，只需添加 -x 选项。如果希望获得更好的压缩效果，还可以通过 --clean-css 选项启用 Clean CSS 进行压缩
5.在代码中调用 Less如下：
var less = require('less');

less.render('.class { width: (1 + 1) }', function (e, css) {
  console.log(css);
});
6.还可以手动调用分析器（paser）和编译器:
var parser = new(less.Parser);

parser.parse('.class { width: (1 + 1) }', function (err, tree) {
  if (err) {
    return console.error(err)
  }
  console.log(tree.toCSS());
});
7.可以给编译器传递多个参数
var parser = new(less.Parser)({
  paths: ['.', './lib'], // Specify search paths for @import directives
  filename: 'style.less' // Specify a filename, for better error messages
});

parser.parse('.class { width: (1 + 1) }', function (e, tree) {
  tree.toCSS({
    // Minify CSS output
    compress: true
  });
});
8.Less 还和流行的 Grunt 构建工具进行了集成，可以参考 grunt-contrib-less 插件
9.在客户端使用 Less.js 是最容易的方式，并且在开发阶段很方便，但是，在生产环境中，性能和可靠性非常重要，我们建议最好使用 node.js 或其它第三方工具进行预编译




http://www.bootcss.com/p/lesscss/

LESS 原理及使用方式
本质上，LESS 包含一套自定义的语法及一个解析器，用户根据这些语法定义自己的样式规则，这些规则最终会通过解析器，编译生成对应的 CSS 文件。LESS 并没有裁剪 CSS 原有的特性，更不是用来取代 CSS 的，而是在现有 CSS 语法的基础上，为 CSS 加入程序式语言的特性

LESS 可以直接在客户端使用，也可以在服务器端使用。在实际项目开发中，我们更推荐使用第三种方式，将 LESS 文件编译生成静态 CSS 文件，并在 HTML 文档中应用
客户端：<link rel="stylesheet/less" type="text/css" href="styles.less"> ==LESS 源文件一定要在 less.js 引入之前引入，这样才能保证 LESS 源文件正确编译解析
服务器端：目前常用的方式是利用 node 的包管理器 (npm) 安装 LESS，安装成功后就可以在 node 环境中对 LESS 源文件进行编译
以通过这个关键字引入我们需要的 .less 或 .css 文件。 如：
@import “variables.less”;
.less 文件也可以省略后缀名，像这样：
@import “variables”;
引入 CSS 同 LESS 文件一样，只是 .css 后缀名不能省略

变量
1.LESS 允许开发者自定义变量，变量可以在全局样式中使用，变量使得样式修改起来更加简单
2.ESS 中的变量和其他编程语言一样，可以实现值的复用，同样它也有生命周期，也就是作用域，查找变量的顺序是先在局部定义中找，如果找不到，则查找上级定义，直至全局
@width : 20px; 
 #homeDiv { 
   @width : 30px; 
   #centerDiv{ 
       width : @width;// 此处应该取最近定义的变量 width 的值 30px 
              } 
 } 

Mixins（混入）
1.混入是指在一个 CLASS 中引入另外一个已经定义的 CLASS，就像在当前 CLASS 中增加一个属性一样
// 定义一个样式选择器
 .roundedCorners(@radius:5px) { 
 -moz-border-radius: @radius; 
 -webkit-border-radius: @radius; 
 border-radius: @radius; 
 } 
 // 在另外的样式选择器中使用
 #header { 
 .roundedCorners; 
 } 
 #footer { 
 .roundedCorners(10px); 
 }
2.Mixins中@arguments是一个很特别的参数，当 Mixins 引用这个参数时，该参数表示所有的变量，很多情况下，这个参数可以省去你很多代码
.boxShadow(@x:0,@y:0,@blur:1px,@color:#000){ 
 -moz-box-shadow: @arguments; 
 -webkit-box-shadow: @arguments; 
 box-shadow: @arguments; 
 } 
 #header { 
 .boxShadow(2px,2px,3px,#f36); 
 }
3.LESS也采用了命名空间的方法来避免重名问题
 #mynamespace { 
 .home {...} 
 .user {...} 
 }
如果我们要复用 user 这个选择器的时候，就可以了通过：#mynamespace > .user 的方式
4.嵌套的规则
在我们书写标准 CSS 的时候，遇到多层的元素嵌套这种情况时，我们要么采用从外到内的选择器嵌套定义，要么采用给特定元素加 CLASS 或 ID 的方式。在 LESS 中我们可以这样写：
 HTML 片段
 <div id="home"> 
	 <div id="top">top</div> 
	 <div id="center"> 
	 <div id="left">left</div> 
	 <div id="right">right</div> 
	 </div> 
 </div>
    对应LESS 文件
 #home{ 
   color : blue; 
   width : 600px; 
   height : 500px; 
   border:outset; 
   #top{ 
        border:outset; 
        width : 90%; 
   } 
   #center{ 
        border:outset; 
        height : 300px; 
        width : 90%; 
        #left{ 
          border:outset; 
          float : left; 
        width : 40%; 
        } 
        #right{ 
          border:outset; 
          float : left; 
          width : 40%; 
        } 
    } 
 }

运算及函数
简单的讲，就是对数值型的 value（数字、颜色、变量等）进行加减乘除四则运算。同时 LESS 还有一个专门针对 color 的操作提供一组函数。
下面是 LESS 提供的针对颜色操作的函数列表：
 lighten(@color, 10%); // return a color which is 10% *lighter* than @color 
 darken(@color, 10%); // return a color which is 10% *darker* than @color 
 saturate(@color, 10%); // return a color 10% *more* saturated than @color 
 desaturate(@color, 10%);// return a color 10% *less* saturated than @color 
 fadein(@color, 10%); // return a color 10% *less* transparent than @color 
 fadeout(@color, 10%); // return a color 10% *more* transparent than @color 
 spin(@color, 10); // return a color with a 10 degree larger in hue than @color 
 spin(@color, -10); // return a color with a 10 degree smaller hue than @color
变量使用示例：
 @init: #111111; 
 @transition: @init*2; 
 .switchColor { 
  color: @transition; 
 }

Comments（注释）
适当的注释是保证代码可读性的必要手段，LESS 对注释也提供了支持，主要有两种方式：单行注释和多行注释
LESS 中单行注释 (// 单行注释 ) 是不能显示在编译后的 CSS 中，所以如果注释是针对样式说明的请使用多行注释
