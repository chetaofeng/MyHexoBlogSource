---
title: grunt入门
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

Grunt中文网：http://www.gruntjs.net/

# 简介
> Grunt和 Grunt 插件是通过 npm 安装并管理的，npm是 Node.js 的包管理器。Grunt配合Node.js有相应的版本要求，如：Grunt 0.4.x 必须配合Node.js >= 0.8.0版本使用

> 奇数版本号的 Node.js 被认为是不稳定的开发版

# Grunt-CLI
## 简介
安装：npm install -g grunt-cli 

注意：
1. 安装grunt-cli并不等于安装了 Grunt！
2. Grunt CLI的任务很简单：调用与Gruntfile在同一目录中 Grunt。这样带来的好处是，允许你在同一个系统上同时安装多个版本的 Grunt。

运行原理：
1. 每次运行grunt 时，他就利用node提供的require()系统查找本地安装的 Grunt。正是由于这一机制，你可以在项目的任意子目录中运行grunt 。
2. 如果找到一份本地安装的 Grunt，CLI就将其加载，并传递Gruntfile中的配置信息，然后执行你所指定的任务。

一份新的 Grunt项目一般需要在你的项目中添加两份文件：package.json 和 Gruntfile

## package.json: 
package.json字段全解：http://blog.csdn.net/woxueliuyun/article/details/39294375
1. 被npm用于存储项目的元数据便将此项目发布为npm模块。你可以在此文件中列出项目依赖的grunt和Grunt插件，放置于devDependencies配置段内
2. package.json应当放置于项目的根目录中，与Gruntfile在同一目录中，并且应该与项目的源代码一起被提交
3. 在目录(package.json所在目录)中运行npm install将依据package.json文件中所列出的每个依赖来自动安装适当版本的依赖
4. 为项目添加package.json文件的方式：
- 大部分 grunt-init 模版都会自动创建特定于项目的package.json文件
- npm init命令会创建一个基本的package.json文件
- 复制下面的案例，并根据需要做扩充，参考https://npmjs.org/doc/json.html
~~~
{
 "name": "my-project-name",
 "version": "0.1.0",
 "devDependencies": {
      "grunt": "~0.4.1",
      "grunt-contrib-jshint": "~0.6.0",
      "grunt-contrib-nodeunit": "~0.2.0",
      "grunt-contrib-uglify": "~0.2.2"
 }
}
~~~

## Gruntfile:
1. 此文件被命名为 Gruntfile.js 或 Gruntfile.coffee，用来配置或定义任务（task）并加载Grunt插件的
2. Gruntfile.js 或 Gruntfile.coffee 文件是有效的 JavaScript 或 CoffeeScript 文件，应当放在你的项目根目录中，和package.json文件在同一目录层级
3. Gruntfile由以下几部分构成："wrapper" 函数；项目与任务配置；加载grunt插件和任务；自定义任务
- "wrapper"函数:
每一份 Gruntfile（和grunt插件）都遵循同样的格式，你所书写的Grunt代码必须放在此函数内：
~~~
module.exports = function(grunt) {
 // Do grunt-related things in here
};
~~~
- 项目与任务配置:大部分的Grunt任务都依赖某些配置数据，这些数据被定义在一个object内，并传递给grunt.initConfig方法，如package.json文件
- 加载grunt插件和任务:像 concatenation、[minification]、grunt-contrib-uglify 和 linting这些常用的任务（task）都已经以grunt插件的形式被开发出来了。只要在 package.json 文件中被列为dependency（依赖）的包，并通过npm install安装之后，都可以在Gruntfile中以简单命令的形式使用：
~~~
// 加载能够提供"uglify"任务的插件。
grunt.loadNpmTasks('grunt-contrib-uglify');
~~~
注意： grunt --help 命令将列出所有可用的任务。
- 自定义任务:通过定义 default 任务，可以让Grunt默认执行一个或多个任务

Gruntfile.js文件示例：
~~~
module.exports = function(grunt) {
    // Project configuration.
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'), //package.json文件中的项目元数据（metadata）被导入到 Grunt 配置中
        uglify: {
            options: {
                banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
            },
            build: {
                src: 'src/<%= pkg.name %>.js',
                dest: 'build/<%= pkg.name %>.min.js'
            }
        }
    }); 
    // 加载包含 "uglify" 任务的插件。
    grunt.loadNpmTasks('grunt-contrib-uglify');
    // 默认被执行的任务列表。
    grunt.registerTask('default', ['uglify']);
};
~~~

Gurnt CLI参数：
~~~
--help, -h ==Display help text
--base, -b ==Specify an alternate base path. By default, all file paths are relative to the Gruntfile.
==Alternative to grunt.file.setBase(...)
--no-color ==Disable colored output.
--gruntfile ==Specify an alternate Gruntfile.
==By default,grunt looks in the current or parent directories for the nearest Gruntfile.(js/coffee) file.
--debug, -d ==Enable debugging mode for tasks that support it.
--stack ==Print a stack trace when exiting with a warning or fatal error.
--force, -f ==A way to force your way past warnings.Want a suggestion? Don't use this option, fix your code.
--tasks ==Additional directory paths to scan for task and "extra" files.Alternative to grunt.loadTasks(...)
--npm ==Npm-installed grunt plugins to scan for task and "extra" files.Alternative to grunt.loadNpmTasks(...)
--no-write ==Disable writing files (dry run).
--verbose, -v ==Verbose mode. A lot more information output.
--version, -V ==Print the grunt version. Combine with --verbose for more info.
--completion ==Output shell auto-completion rules. See the grunt-cli documentation for more information.
~~~

# 安装Gurnt和Gurnt插件
## 安装命令
* npm install grunt --save-dev  
* npm install grunt ==[@VERSION]== --save-dev  

## Gurnt插件
> http://gruntjs.com/plugins 

> Grunt官方插件列表，其中带星号的为官方维护的插件

创建插件：
1. 通过 npm install -g grunt-init 命令安装 grunt-init 。
2. 通过 git clone git://github.com/gruntjs/grunt-init-gruntplugin.git ~/.grunt-init/gruntplugin 命令安装grunt插件模版。
3. 在一个空的目录中执行 grunt-init gruntplugin 。
4. 执行 npm install 命令以准备开发环境。
5. 为你的插件书写代码。
6. 执行 npm publish 命令将你创建的 Grunt 插件提发布npm

注意：
1. grunt-contrib" 命名空间保留给 Grunt 团队维护的task使用，请给你自己的task起一个合适名字，并且避免使用被保留的命名空间
2. Grunt默认隐藏error stack traces，但可--stack启用方便调试自己的task;在bash中可通过alias grunt='grunt --stack'创建别名默认记录下stack trace
3. 存储任务文件：建议使用几个常用npm模块（例如 temporary、tmp）来调用操作系统级别的临时目录功能
4. 避免改变当前工作目录：process.cwd()
- 默认包含gruntfile文件的目录被设置为当前工作目录。用户可在自己的gruntfile中通过grunt.file.setBase()改变改变当前工作目录，但是插件不应该改变它
- path.resolve('foo') 可以被用来获取'foo' 相对于 Gruntfile 所在目录的绝对路径
5. Grunt常用插件
* grunt-contrib-uglify：压缩js代码
* grunt-contrib-concat：合并js文件
* grunt-contrib-qunit：单元测试
* grunt-contrib-jshint：js代码检查
* grunt-contrib-watch：监控文件修改并重新执行注册的任务

# Task
> Grunt就只支持两种任务：基本的Task以及MultiTasks

> 区别是基本的Task的任务配置只有一个，而MultiTasks则有多个。大多数的grunt插件任务都是MultiTasks

## Task的创建
* grunt注册任务的格式:
~~~
grunt.registerTask(taskName, [description, ] taskList)
~~~
* grunt默认任务:
~~~
//如果运行Grunt时没有指定任何任务，它将自动执行'jshint'、'qunit'、'concat' 和 'uglify' 任务
grunt.registerTask('default', ['jshint', 'qunit', 'concat', 'uglify']); 
~~~
* grunt任务带参数的格式:
~~~
grunt.registerTask('dist', ['concat:distArg', 'uglify:distArg']); 
~~~
1. 当一个基本任务执行时，Grunt并不会检查配置和环境 -- 它仅仅执行指定的任务函数，并传递任何使用冒号分割的参数作为函数的参数
2. 如果你的任务并没有遵循 "多任务" 结构，那就使用自定义任务，在一个任务内部，执行其他的任务，使用grunt.task.run('bar', 'baz');
3. 任务还可以依赖于其他任务的成功执行。注意 grunt.task.requires 并不会真正的运行其他任务，它仅仅检查其它任务是否已经执行，并且没有失败

## Task的配置
Grunt的task配置都是在 Gruntfile 中的grunt.initConfig方法中指定的。此配置主要是以任务名称命名的属性，也可以包含其他任意数据。一旦这些代表任意数据的属性与任务所需要的属性相冲突，就将被忽略。

在一个任务配置中:
* options属性可以用来指定覆盖内置属性的默认。
* 每一个目标（target）中还可以拥有一个专门针对此目标（target）的options属性
* 目标（target）级的options将会覆盖任务级的options
~~~
grunt.initConfig({
    concat: { =================Task
        options: {
         // 这里是任务级的Options，覆盖默认值
        },
        foo: { =================Target，并非子任务
            options: {
            // "foo" target options may go here, overriding task-level options.
            },
        },
        bar: {
        // No options specified; this target will use task-level options.
        },
    },
});
~~~
## 文件
由于大多的任务都是执行文件操作，Grunt有一个强大的抽象层用于声明任务应该操作哪些文件。这里有好几种定义src-dest(源文件-目标文件)文件映射的方式，均提供了不同程度的描述和控制操作方式。任何一种多任务（multi-task）都能理解下面的格式，所以你只需要选择满足你需求的格式就行。

详见：http://www.gruntjs.net/configuring-tasks


# 项目实战
Nodejs和CLI安装好之后，参考：http://www.bluesdream.com/blog/windows-installs-the-grunt-and-instructions.html
1. mkdir testProject  -> cd testProject
2. 创建package.json文件

package.json官方文档:https://docs.npmjs.com/json
- A: npm init ==自动创建pachage.json文件
- B: 手动创建package.json文件，添加项目/模块的描述信息 
3. 安装Grunt和Grunt插件：
- 手动添加，修改package.json文件，然后执行npm install
{
"name": "my-project",
"version": "0.1.0",
"devDependencies": {
"grunt": "~0.4.1",
"grunt-contrib-cssmin": "~0.7.0" //其中"~0.7.0"代表安装该插件的某个特定版本，如果只需安装最新版本，可以改成"*"
}
}
- 自动安装： 其中--save-dev，表示将它作为你的项目依赖添加到package.json文件中devDependencies内
~~~
npm install grunt --save-dev //安装最新版的Grunt
npm install grunt-contrib-cssmin --save-dev //安装我们所需要的插件
~~~
4. 创建Gruntfile.js文件：
~~~
module.exports = function(grunt) {
    // 配置任务参数
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        cssmin: {
            combine: {
                files: {
                    'css/release/compress.css': ['css/*.css'] // 指定合并的CSS文件 ['css/base.css', 'css/global.css']
                }
            },
            minify: {
                options: {
                    keepSpecialComments: 0, /* 删除所有注释 */
                    banner: '/* minified css file */'
                },
                files: {
                    'css/release/master.min.css': ['css/master.css']
                }
            }
        }
    });
    // 插件加载（加载 "cssmin" 模块）
    grunt.loadNpmTasks('grunt-contrib-cssmin');
    // 自定义任务：通过定义 default 任务，可以让Grunt默认执行一个或多个任务。
    grunt.registerTask('default', ['cssmin']);
};
~~~
5. 执行：
* grunt //执行配置中所有的任务
* grunt cssmin //执行特定的任务
6. 测试：
* 在项目文件夹中创建个子文件夹，命名为：CSS
* 在里面创建base.css和master.css，2个CSS文件，你可以随便写点内容在里面。
* 在命令行中执行grunt，看到如下提示说明执行成功：
~~~
Running "cssmin:combine" (cssmin) task
File css/release/compress.css created.
Running "cssmin:minify" (cssmin) task
File css/release/master.min.css created.
Done, without errors.
~~~

# JSDoc&Grunt
grunt-jsdoc是一个Grunt的插件。这个插件集成了JsDoc Toolkit 3，并且你能够通过配置Grunt任务来生成API文档

补充：grunt-jsdoc-plugin是同一个开发者，但是区别是grunt-jsdoc是基于JsDoc Toolkit 3而grunt-jsdoc-plugin是基于JsDoc Toolkit 2的

安装:
1. 已安装好JAVA且配置好了Java环境变量
2. npm install grunt-jsdoc --save-dev //安装jsdoc插件

grunt-jsdoc的grunt任务配置
~~~
grunt.initConfig({
    jsdoc : {
        dist : {
            src: ['src/*.js', 'test/*.js'],
            options: {
                destination: 'doc'
            }
        }
    }
});
~~~
参数说明：
~~~
src: 要自动生成API文档的源文件路径数组
jsdoc: jsdoc的bin文件夹目录
options: jsdoc单独使用的配置项
destination： 必填，指定文档输出路径
configure： jsdoc配置文件路径
template： 文档模板路径
private： 是否在文档中输出private成员，默认为true
~~~
更多参数：参考官方文档：Command-line arguments to JSDoc: http://usejsdoc.org/about-commandline.html

# Grunt.js和Gulp.js工作方式的区别
* Grunt主要是以文件为媒介来运行它的工作流的，比如在Grunt中执行完一项任务后，会把结果写入到一个临时文件中，然后可以在这个临时文件内容的基础上执行其它任务，执行完成后又把结果写入到临时文件中，然后又以这个为基础继续执行其它任务...就这样反复下去。
* 在Gulp中，使用的是Nodejs中的stream(流)，首先获取到需要的stream，然后可以通过stream的pipe()方法把流导入到你想要的地方，比如Gulp的插件中，经过插件处理后的流又可以继续导入到其他插件中，当然也可以把流写入到文件中。所以Gulp是以stream为媒介的，它不需要频繁的生成临时文件，这也是Gulp的速度比Grunt快的一个原因
