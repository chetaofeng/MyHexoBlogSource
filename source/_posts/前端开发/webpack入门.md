---
title: webpack入门
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

~~~
http://webpack.org/
https://github.com/webpack-china/webpack.js.org
http://www.css88.com/doc/webpack2/
~~~

# 简介
![image](http://note.youdao.com/yws/api/personal/file/WEB7518457dae5c37c455088010c54f1e6c?method=download&shareKey=13db111168a449f1c1833f09e42da606)
Webpack 是当下最热门的前端资源模块化管理和打包工具。它可以将许多松散的模块按照依赖和规则打包成符合生产环境部署的前端资源。还可以将按需加载的模块进行代码分隔，等到实际需要的时候再异步加载。通过 loader 的转换，任何形式的资源都可以视作模块，比如 CommonJs 模块、 AMD 模块、 ES6 模块、CSS、图片、 JSON、Coffeescript、 LESS 等。

前身叫browserify，缺点为只能转换js

# 概念
## 入口(Entry)
* webpack 将创建所有应用程序的依赖关系图表(dependency graph)。图表的起点被称之为入口起点(entry point)
* 入口起点告诉 webpack 从哪里开始，并遵循着依赖关系图表知道要打包什么
* 可以将应用程序的入口起点认为是根上下文(contextual root)或 app 第一个启动文件

## 出口(Output)
* 将所有的资源(assets)归拢在一起后，我们还需要告诉 webpack 在哪里打包我们的应用程序。webpack 的 output 属性描述了如何处理归拢在一起的代码(bundled code)
* 即使可以存在多个入口起点，但只指定一个输出配置
* 更多配置：http://www.css88.com/doc/webpack2/concepts/output/

## 加载器(Loader)
* webpack 的目标是，让 webpack 聚焦于项目中的所有资源(asset)，而浏览器不需要关注考虑这些（这并不意味着资源(asset)都必须打包在一起）。webpack 把每个文件(.css, .html, .scss, .jpg, etc.) 都作为模块处理。而且 webpack 只理解 JavaScript
* webpack loader 会将这些文件转换为模块，而转换后的文件会被添加到依赖图表中
* 在 webpack 配置中定义 loader 时，要定义在 module.rules 中，而不是 rules
* webparck默认加载的是js，如果要加载如css，需要额外loader
1. npm install style-loader css-loader -D
2. 在webpack中，多个loader加载通过！连接，后面的“-loader可以省略”，如：require("style!css!./mystyle.css")

## 插件(Plugins)
想要使用一个插件，
1. 需要 require() 它，
2. 它添加到 plugins 数组中
3. 多数插件可以通过选项(option)自定义
4. 由于需要在一个配置中，多次使用一个插件，来针对不同的目的，因此你需要使用 new 来创建插件的实例，并且通过实例来调用插件

webpack 插件是一个具有 apply 属性的 JavaScript 对象。 apply 属性会被 webpack compiler 调用，并且 compiler 对象可在整个 compilation 生命周期访问

webpack.config.js示例：
~~~
const HtmlWebpackPlugin = require('html-webpack-plugin'); //installed via npm
const webpack = require('webpack'); //to access built-in plugins
const path = require('path');

const config = {
  entry: './path/to/my/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'my-first-webpack.bundle.js'
  },
  module: {
    rules: [
      {test: /\.(js|jsx)$/, use: 'babel-loader'}
    ]
  },
  plugins: [
    new webpack.optimize.UglifyJsPlugin(),
    new HtmlWebpackPlugin({template: './src/index.html'})
  ]
};

module.exports = config;
~~~

# webpack安装及起步
## 安装
* cnpm install webpack-cli -g//webpack的cli环境
* cnpm install webpack-dev-server //webpack的自带服务器

运行：
1. 开发环境：webpack
2. 生产环境：webpack -p //会压缩
3. 监听模式：webpack -w //自动编译
4. 开启sourcemaps：webpack -d //方便调试

## 起步
~~~
mkdir webpack-demo && cd webpack-demo
npm init -y
npm install --save-dev webpack
~~~

创建并编辑app/index.js
~~~ 
import _ from 'lodash';

function component () {
  var element = document.createElement('div');

  /* 需要引入 lodash，下一行才能正常工作 */
  element.innerHTML = _.join(['Hello','webpack'], ' ');

  return element;
}

document.body.appendChild(component());
~~~
~~~
npm install --save lodash
~~~
~~~
<html>
  <head>
    <title>webpack 2 demo</title> 
  </head>
  <body> 
       <script src="dist/bundle.js"></script>
  </body>
</html>
~~~
~~~
webpack
查看浏览器index.html页面内容：Hello webpack
~~~

#代码拆分
分离资源，实现缓存资源和并行加载资源:
* 一个典型的应用程序，会依赖于许多提供框架/功能需求的第三方库代码。不同于应用程序代码，这些第三方库代码不会频繁修改
* 如果我们将这些库(library)中的代码，保留到与应用程序代码相独立的 bundle 上，我们就可以利用浏览器缓存机制，把这些文件长时间的缓存到用户的机器上

## CSS分割
要通过webpack打包CSS，像任何其他模块一样将CSS导入JavaScript代码，并使用css-loader（它输出CSS作为JS模块），并可选地应用ExtractTextWebpackPlugin（它提取打包的CSS并输出CSS文件

1. 导入 CSS
* import 'bootstrap/dist/css/bootstrap.css';
2. 使用 css-loader:webpack.config.js中配置 css-loader
~~~
module.exports = {
    module: {
        rules: [{
            test: /\.css$/,
            use: 'css-loader'
        }]
    }
}
~~~
3. 使用 ExtractTextWebpackPlugin
* npm install --save-dev extract-text-webpack-plugin
4. webpack.config.js中添加插件配置
~~~
module.exports = {
    module: {
         rules: [{
             test: /\.css$/,
-            use: 'css-loader'
+            use: ExtractTextPlugin.extract({
+                use: 'css-loader'
+            })
         }]
     },
+    plugins: [
+        new ExtractTextPlugin('styles.css'),
+    ]
} 
~~~

## Libraries分割
默认会将库文件打包，可通过为库，如moment 添加一个单独的入口点并将其命名为 vendor 来缓解这一情况
~~~
var path = require('path');

module.exports = function(env) {
    return {
        entry: {
            main: './index.js',
            vendor: 'moment'
        },
        output: {
            filename: '[chunkhash].[name].js',
            path: path.resolve(__dirname, 'dist')
        }
    }
}
~~~
运行webpakc生成了两个 bundle，都包含lodash，所以还需要插件
* CommonsChunkPlugin：它从根本上允许我们从不同的 bundle 中提取所有的公共模块，并且将他们加入公共 bundle 中。如果公共 bundle 不存在，那么它将会创建一个出来
~~~
var webpack = require('webpack');
var path = require('path');

module.exports = function(env) {
    return {
        entry: {
            main: './index.js',
            vendor: 'moment'
        },
        output: {
            filename: '[chunkhash].[name].js',
            path: path.resolve(__dirname, 'dist')
        },
        plugins: [
            new webpack.optimize.CommonsChunkPlugin({
                name: 'vendor' // 指定公共 bundle 的名字。
            })
        ]
    }
}
~~~
以上完成之后，每次运行的vendor文件的hash码会改变，需在plugins配置如下：
~~~
plugins: [
    new webpack.optimize.CommonsChunkPlugin({
        names: ['vendor', 'manifest'] // 指定公共 bundle 的名字
    })
]
~~~
将运行时代码提取到一个单独的 manifest 文件中就解决了

## 生产环境构建
1. 自动方式
* 运行webpack -p (也可以运行 webpack --optimize-minimize --define process.env.NODE_ENV="'production'", 他们是等效的). 它会执行如下步骤:
- - 使用UglifyJsPlugin进行 JS文件压缩
- - 运行LoaderOptionsPlugin
- - 设置Node环境变量
2. 手动方式: 为多环境配置Webpack
编写一个基本配置文件,把所有公用的功能放在里面。再编写特定环境的文件,使用'webpack-merge'来合并他们

base.js
~~~
module.exports = function() {
    return {
        entry: { 
            'vendor': './src/vendor.ts',
            'main': './src/main.ts'

        },
        output: {
            path: path.join(__dirname, '/../dist/assets'),
            filename: '[name].bundle.js',
            publicPath: publicPath,
            sourceMapFilename: '[name].map'
        },
        resolve: {
            extensions: ['', '.js', '.json'],
            modules: [path.join(__dirname, 'src'), 'node_modules']

        },
        module: {
            loaders: [{
                test: /\.css$/,
                loaders: ['to-string-loader', 'css-loader']
            }, {
                test: /\.(jpg|png|gif)$/,
                loader: 'file-loader'
            }, {
                test: /\.(woff|woff2|eot|ttf|svg)$/,
                loader: 'url-loader?limit=100000'
            }],
        },
        plugins: [
            new ForkCheckerPlugin(),

            new webpack.optimize.CommonsChunkPlugin({
                name: ['polyfills', 'vendor'].reverse()
            }),
            new HtmlWebpackPlugin({
                template: 'src/index.html',
                chunksSortMode: 'dependency'
            })
        ],
    };
}
~~~
使用'webpack-merge'合并这个基础配置和针对环境的特定的配置

prod.js (updated)
~~~
const webpackMerge = require('webpack-merge');

const commonConfig = require('./base.js');

module.exports = function(env) {
    return webpackMerge(commonConfig(), {
        plugins: [
            new webpack.LoaderOptionsPlugin({
                minimize: true,
                debug: false
            }),
            new webpack.DefinePlugin({
                'process.env': {
                    'NODE_ENV': JSON.stringify('prod')
                }
            }),
            new webpack.optimize.UglifyJsPlugin({
                beautify: false,
                mangle: {
                    screw_ie8: true,
                    keep_fnames: true
                },
                compress: {
                    screw_ie8: true
                },
                comments: false
            })
        ]
    })
}
~~~

# 缓存
> 这一块没有理解，需重新看
为了能够长期缓存webpack生成的静态资源:

1. 使用[chunkhash]向每个文件添加一个依赖于内容的缓存杀手(cache-buster)
2. 将webpack mainfest提取到一个单独的文件中去
3. 对于一组依赖关系相同的资源，确保包含引导代码的入口起点模块(entrychunk)不会随时间改变它的哈希值
4. 当需要在HTML中加载资源时，使用编译器统计信息(compiler stats)来获取文件名
5. 生成模块清单(chunk manifest)的JSON内容，并在页面资源加载之前内联进HTML中去

* 将开发和生产模式的配置分开，并在开发模式中使用[name].js的文件名， 在生产模式中使用[name].[chunkhash].js文件名
* 为了在HTML中引用正确的文件,因为有hash生存文件名的一部分，可以使用下面这个插件，从webpack编译统计中提取：
~~~
// webpack.config.js
const path = require("path");

module.exports = { 
  plugins: [
    function() {
      this.plugin("done", function(stats) {
        require("fs").writeFileSync(
          path.join(__dirname, "build", "stats.json"),
          JSON.stringify(stats.toJson()));
      });
    }
  ]
};
~~~
或者使用插件：https://www.npmjs.com/package/webpack-manifest-plugin

# 开发
## 调整你的文本编辑器
* 一些文本编辑器有“safe write”（安全写入）功能，并且默认启用。因此，保存文件后并不总是会导致 webpack 重新编译
* WebStorm - 在 Preferences > Appearance & Behavior > System Settings 中取消选中 Use "safe write"

## Source Maps
更多配置：http://www.css88.com/doc/webpack2/configuration/devtool/
~~~
devtool:'source-map'
~~~

## 选择一个工具
* webpack 可以在 watch mode(监视模式)下使用。在这种模式下，webpack 将监视您的文件，并在更改时重新编译
* webpack-dev-server 提供了一个易于部署的开发服务器，具有快速的实时重载（live reloading）功能
* 如果你已经有一个开发服务器并且需要完全的灵活性，可以使用 webpack-dev-middleware 作为中间件

### webpack-dev-server
1. npm install webpack-dev-server --save-dev
2. webpack-dev-server --open

### webpack-dev-middleware
webpack-dev-middleware 适用于基于链接的中间件环境（connect-based middleware stacks）。如果你已经有一个 Node.js 服务器或者你想要完全控制服务器，这将很实用
1. npm install express webpack-dev-middleware --save-dev
2. 使用
~~~
var express = require("express");
var webpackDevMiddleware = require("webpack-dev-middleware");
var webpack = require("webpack");
var webpackConfig = require("./webpack.config");

var app = express();
var compiler = webpack(webpackConfig);

app.use(webpackDevMiddleware(compiler, {
  publicPath: "/" // 大部分情况下和 `output.publicPath`相同
}));

app.listen(3000, function () {
  console.log("Listening on port 3000!");
});
~~~
根据你在 output.publicPath 和 output.filename 中设置的内容，你的 bundle 现在应该在 http://localhost:3000/bundle.js 中可以看到了
3. 默认情况下会使用watch mode。也可以使用 lazy mode，这使得 webpack 只在对入口点进行请求时再进行重新编译
~~~
app.use(webpackDevMiddleware(compiler, {
  lazy: true,
  filename: "bundle.js" // Same as `output.filename` in most cases.
}));
~~~
4. 命令说明
~~~
* webpack-dev-server  //默认8080
* webpack-dev-server --port 8088
* webpack-dev-server --inline //改变代码之后，自动刷新浏览器
* webpack-dev-server --hot //热重载（局部更改）
~~~
5. 此功能设置在webpack.config.js配置文件中如下：
~~~
devServer:{
    port:8088,
    inline:true
}
~~~
6. 也可以配置在package.json文件中，如：
~~~
"scripts":{
    "dev":"webpack-dev-server --port 8088 --inline --hot"
}

$ run npm dev
~~~
7. resolve配置
* 配置扩展名,即代码中引用的时候可以省略后缀
~~~
resolve:{
    "extensions":['','.js','.css','.json']
}
~~~

## 配合babel的使用
以下为react配合webpack的各种依赖库：
* cnpm install babel-core -D 
* cnpm install babel-preset-es2015 --save-dev
* cnpm install babel-loader -D

设置js的转换
1. 通过weback.config.js设置
~~~
moudule:{
    loaders:[
        {
            test:/\.js$/,
            loader:'babel',
            exclude:/node_moudules/
        }
    ]
},
babel:{
    "presets":['es2015']
}
~~~
2. 通过.babelrc文件，文件内容为：
~~~
{
    "presets":["es2015"]
}
~~~

## 配合react使用
前提：配合babel的配置已经安装
* cnpm install babel-preset-react -D //babel的react预设，babel可以给其他用，react是支持的一种
* cnpm install react-hot-loader
* 设置预设.babelrc
~~~
{
    "presets":[
        ["es2015"],
        ["react"]
    ]
}
~~~
* 预设webpack.config

