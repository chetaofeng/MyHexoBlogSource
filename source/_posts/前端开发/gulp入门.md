---
title: gulp入门
tags:
  - 工具
  - node 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

[toc]

# 简介
gulpjs是一个前端构建工具，与gruntjs相比，gulpjs无需写一大堆繁杂的配置参数，API也非常简单，学习起来很容易，而且gulpjs使用的是nodejs中stream来读取和操作数据，其速度更快
~~~
Gulp官网 http://gulpjs.com/
Gulp中文网 http://www.gulpjs.com.cn/
Gulp中文文档 https://github.com/lisposter/gulp-docs-zh-cn
Gulp插件网 http://gulpjs.com/plugins/
Awesome Gulp https://github.com/alferov/awesome-gulp
StuQ-Gulp实战和原理解析 http://i5ting.github.io/stuq-gulp/
~~~
# 工作流程
gulp的使用流程一般是这样子的：
1. 通过gulp.src()方法获取到我们想要处理的文件流，22. 把文件流通过pipe方法导入到gulp的插件中
3. 把经过插件处理后的流再通过pipe方法导入到gulp.dest()中
4. gulp.dest()方法则把流中的内容写入到文件中

==注意：== 给gulp.dest()传入的路径参数，只能用来指定要生成的文件的目录，而不能指定生成文件的文件名，它生成文件的文件名使用的是导入到它的文件流自身的文件名。==生成的文件名是由导入到它的文件流决定的==

# 安装
gulp基于node.js，要通过nodejs的npm安装gulp，所以先要安装nodejs环境
* 全局方式：npm install -g gulp
* gulp的项目中单独安装一次：npm install gulp
* 安装的时候把gulp写进项目package.json文件的依赖中：npm install --save-dev gulp

在全局安装gulp后，还需要在项目中本地安装一次，是为了版本的灵活性，仅供参考

# 开始使用gulp
1. 建立gulpfile.js文件
此时我们的目录结构是这样子的：
~~~
├── gulpfile.js
├── node_modules
│ └── gulp
└── package.json
~~~~
最简gulpfile.js:
~~~
var gulp = require('gulp');
gulp.task('default',function(){
    console.log('hello world');
});
~~~

2. 运行gulp任务
切换到存放gulpfile.js文件的目录
* 执行gulp命令:会执行任务名为default的默认任务
* gulp task1:执行task1任务

# gulpfile.js文件
全局配置config：当gulpfile.js太大时就不好维护了，此时可以将需要在gulpfile中引用的参数，放到这里，包括一些路径，功能的开关等，如：
~~~
module.exports = {
    name : '.....',
    devPath : '.....',    //项目根路径，根路径下可以包含多个项目
    prodPath : '....', //生产路径根路径
    sassPath : '.....', //SASS包含文件路径
    rmHtmlWhitespace : false,//html中是否去除空格
    webpackEntry : {
        index : 'index.js'//js合并
    },
    server : {
        port : 8088
    }
};
~~~
意下这里使用了module.exports，这是nodejs的语法。在gulpfile中将会用require引用config。
~~~
var config = require('./config');//加载项目配置
~~~
使用举例：
~~~
//引入gulp，项目文件中安装的gulp的引入方式
var gulp =require('gulp');

//引入组件
var jshint = require("gulp-jshint");
var gutil = require("gulp-util");
var sass= require("gulp-sass");
var concat = require("gulp-concat");
var uglify = require("gulp-uglify");
var rename = require("gulp-rename");

var path = require("path");
var del = require("del");

//你也许会想要在编译文件之前删除一些文件
gulp.task('clean', function(cb) {
    return del(['build/**/*'], cb);
});

//检查脚本
gulp.task('lint',function () {
    gulp.src('./src/javascript/**/*.js')
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});

//编译sass
//sass 任务会编译scss/目录下的scss文件，并把编译完成的css文件保存到/css目录中
gulp.task('sass',function () {
    gulp.src("./src/scss/**/*.scss")
        .pipe(sass({outputStyle: 'compact'}))
        .pipe(gulp.dest("./build/css"));
});

//合并，压缩文件
//scipts 任务会合并js 目录下的所有js文件并输出到dist目录中，然后gulp会重命名。压缩合并的文件，也输出到dist/目录
gulp.task('scripts',function () {
    gulp.src('./src/javascript/**/*.js')
        .pipe(concat('all.js'))
        .pipe(gulp.dest('./dest'))
        .pipe(rename("all.min.js"))
        .pipe(uglify())
        .pipe(gulp.dest("./build"))
});

//这时，我们创建了一个基于其他任务的default任务。
//使用.run()方法关联和运行我们上面定义的任务，使用.watch() 方法去坚挺制定目录的文件变化,当有文件变化时，会运行回调定义的其他任务。
gulp.task('default',function(){
    //将你的默认的任务代码放在这里
    gulp.run('lint','sass','scripts');
    //监听文件变化
    gulp.watch("",function () {
        gulp.run('lint','sass','scripts');
    });
});
~~~

# gulp的API介绍
更多API介绍： http://www.gulpjs.com.cn/docs/api/
## gulp.src()
gulp.src()方法正是用来获取流的，但要注意这个流里的内容不是原始的文件流，而是一个虚拟文件对象流(Vinyl files)，这个虚拟文件对象中存储着原始文件的路径、文件名、内容等信息 
~~~
gulp.src(globs[, options])

* globs参数是文件匹配模式(类似正则表达式)，用来匹配文件路径(包括文件名)，当然这里也可以直接指定某个具体的文件路径。当有多个匹配模式时，该参数可以为一个数组
* options为可选参数
~~~

* 当我们没有在gulp.src()方法中配置base属性时，base的默认值为通配符开始出现之前那部分路径，例如：
~~~
gulp.src('app/src/**/*.css') //此时base的值为 app/src
~~~

Gulp内部使用了node-glob模块来实现其文件匹配功能。我们可以使用下面这些特殊的字符来匹配我们想要的文件：
~~~
* 匹配文件路径中的0个或多个字符，但不会匹配路径分隔符，除非路径分隔符出现在末尾
** 匹配路径中的0个或多个目录及其子目录,需要单独出现，即它左右不能有其他东西了。如果出现在末尾，也能匹配文件。
? 匹配文件路径中的一个字符(不会匹配路径分隔符)
[...] 匹配方括号中出现的字符中的任意一个，当方括号中第一个字符为^或!时，则表示不匹配方括号中出现的其他字符中的任意一个，类似js正则表达式中的用法
!(pattern|pattern|pattern) 匹配任何与括号中给定的任一模式都不匹配的
?(pattern|pattern|pattern) 匹配括号中给定的任一模式0次或1次，类似于js正则中的(pattern|pattern|pattern)?
+(pattern|pattern|pattern) 匹配括号中给定的任一模式至少1次，类似于js正则中的(pattern|pattern|pattern)+
*(pattern|pattern|pattern) 匹配括号中给定的任一模式0次或多次，类似于js正则中的(pattern|pattern|pattern)*
@(pattern|pattern|pattern) 匹配括号中给定的任一模式1次，类似于js正则中的(pattern|pattern|pattern)
~~~
==注意：== 不能在数组中的第一个元素中使用排除模式

使用举例：
~~~
//使用数组的方式来匹配多种文件
gulp.src(['js/*.js','css/*.css','*.html'])

gulp.src([*.js,'!b*.js']) //匹配所有js文件，但排除掉以b开头的js文件
gulp.src(['!b*.js',*.js]) //不会排除任何文件，因为排除模式不能出现在数组的第一个元素中
~~~

## gulp.dest()
gulp.dest()方法是用来写文件的，其语法为：
~~~
gulp.dest(path[,options])

* path为写入文件的路径
* options为一个可选的参数对象，通常我们不需要用到
~~~
* 生成的文件路径是我们传入的path参数后面再加上gulp.src()中有通配符开始出现的那部分路径

## gulp.task()
gulp.task方法用来定义任务，内部使用的是Orchestrator，其语法为：
~~~
gulp.task(name[, deps], fn)
* name 为任务名
* deps 是当前定义的任务需要依赖的其他任务，为一个数组。当前定义的任务会在所有依赖的任务执行完毕后才开始执行。如果没有依赖，则可省略这个参数
* fn 为任务函数，我们把任务要执行的代码都写在里面。该参数也是可选的。
~~~
使用举例：
~~~
gulp.task('mytask', ['array', 'of', 'task', 'names'], function() { //定义一个有依赖的任务
  // Do something
});
~~~
1. 如果任务相互之间没有依赖，任务会按你书写的顺序来执行
2. 如果有依赖的话则会先执行依赖的任务
3. 如果某个任务所依赖的任务是异步的，就要注意了，gulp并不会等待那个所依赖的异步任务完成，而是会接着执行后续的任务

## gulp.watch()
gulp.watch()用来监视文件的变化，当文件发生变化后，我们可以利用它来执行相应的任务，例如文件压缩等。其语法为
~~~
gulp.watch(glob[, opts], tasks)
* glob 为要监视的文件匹配模式，规则和用法与gulp.src()方法中的glob相同。
* opts 为一个可选的配置对象，通常不需要用到
* tasks 为文件变化后要执行的任务，为一个数组
~~~
~~~
gulp.task('uglify',function(){
  //do something
});
gulp.task('reload',function(){
  //do something
});
gulp.watch('js/**/*.js', ['uglify','reload']);
~~~

# 一些常用的gulp插件
## 自动加载插件pulp-load-plugins
* 这个插件能自动帮你加载package.json文件里的gulp插件
* gulp-load-plugins是通过package.json文件来加载插件
* gulp-load-plugins并不会一开始就加载所有package.json里的gulp插件，而是在我们需要用到某个插件的时候，才去加载那个插件
* 定义及启用
~~~
var gulp = require('gulp');
//加载gulp-load-plugins插件，并马上运行它
var plugins = require('gulp-load-plugins')();
~~~
* 使用举例：
~~~
plugins.rename          //gulp-rename插件的使用 
~~~
## 重命名插件gulp-rename
~~~
gulp.task('rename', function () {
    gulp.src('js/jquery.js')
    .pipe(uglify())  //压缩
    .pipe(rename('jquery.min.js')) //会将jquery.js重命名为jquery.min.js
    .pipe(gulp.dest('js')); 
});
~~~
## js文件压缩插件gulp-uglify
~~~
var gulp = require('gulp'),
    uglify = require("gulp-uglify");
 
gulp.task('minify-js', function () {
    gulp.src('js/*.js') // 要压缩的js文件
    .pipe(uglify())  //使用uglify进行压缩,更多配置请参考：
    .pipe(gulp.dest('dist/js')); //压缩后的路径
});
~~~
## css文件压缩插件gulp-minify-css
~~~
var gulp = require('gulp'),
    minifyCss = require("gulp-minify-css");
 
gulp.task('minify-css', function () {
    gulp.src('css/*.css') // 要压缩的css文件
    .pipe(minifyCss()) //压缩css
    .pipe(gulp.dest('dist/css'));
});
~~~
## html文件压缩插件gulp-minify-html
~~~
var gulp = require('gulp'),
    minifyHtml = require("gulp-minify-html");
 
gulp.task('minify-html', function () {
    gulp.src('html/*.html') // 要压缩的html文件
    .pipe(minifyHtml()) //压缩
    .pipe(gulp.dest('dist/html'));
});
~~~
## js代码检查插件
~~~
var gulp = require('gulp'),
    jshint = require("gulp-jshint");
 
gulp.task('jsLint', function () {
    gulp.src('js/*.js')
    .pipe(jshint())
    .pipe(jshint.reporter()); // 输出检查结果
});
~~~
## 文件合并插件gulp-concat
~~~
var gulp = require('gulp'),
    concat = require("gulp-concat");
 
gulp.task('concat', function () {
    gulp.src('js/*.js')  //要合并的文件
    .pipe(concat('all.js'))  // 合并匹配到的js文件并命名为 "all.js"
    .pipe(gulp.dest('dist/js'));
});
~~~ 

## 图片压缩插件
~~~
var gulp = require('gulp');
var imagemin = require('gulp-imagemin');
var pngquant = require('imagemin-pngquant'); //png图片压缩插件

gulp.task('default', function () {
    return gulp.src('src/images/*')
        .pipe(imagemin({
            progressive: true,
            use: [pngquant()] //使用pngquant来压缩png图片
        }))
        .pipe(gulp.dest('dist'));
});
~~~
