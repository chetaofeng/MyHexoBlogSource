---
title: Angular入门
tags:
  - Angular 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

~~~
https://angular.io/
https://www.angular.cn/
http://www.angularjs.cn/
~~~

~~~
1. Angular和JavaScript不互通（函数、变量、事件都不互通）
2. Angular的开发模式和传统开发模式完全不通：只需盯住数据，数据是核心
~~~

# 简介及入门
Angular2是面向未来的科技，要求浏览器支持ES6+

Angular 应用是由组件组成的。 组件由 HTML 模板和组件类组成，组件类控制视图

每个组件都以@Component装饰器函数开始，它接受一个元数据对象参数。该元素对象描述了 HTML 模板和组件类是如何一起工作的

selector属性为 Angular 指定了在index.html中的自定义<my-app>标签里显示该组件
~~~
import { Component } from '@angular/core';

@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`
})
export class AppComponent { name = 'Angular'; }

注️：template后面不是单引号
~~~

## 网页版使用示例
~~~
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>网页版使用示例</title>
    <script src="angular.js"></script>
</head>
<body>
    <div ng-app="" ng-init="str=123">
        <input type="text" ng-model="str"/>
        <div ng-bing="str"></div>
    </div>
</body>
</html>
~~~
说明：
* ng-app:表示此区域内由angular控制


# Angular CLI
http://www.itnose.net/detail/6694827.html

Angular CLI是一个命令行界面工具，它可以创建项目、添加文件以及执行一大堆开发任务，比如测试、打包和发布

0. 因为angular-cli是用typescript写的，所以要先装这两个:npm install -g typescript typings
1. 全局安装 :npm install -g @angular/cli
2. 创建新项目:ng new my-app
3. 启动开发服务器:cd my-app;ng serve --open

* 问题1：/usr/local/lib/node_modules/angular-cli/node_modules/_@ngtools_json-schema@1.0.9@@ngtools/json-schema/src/schema-class-factory.js:34
~~~
解决：node版本太低
~~~
* 问题2:Installing packages for tooling via npm.
~~~
太耗时，强制停止后，通过cnpm下载依赖
~~~

命令|	使用说明
----------|--------
组件Component|	ng generate component my-new-component
指令Directive|	ng generate directive my-new-directive
服务Service|	ng generate pipe my-new-service
管道Pipe|	ng generate pipe my-new-pipe
类Class|	ng generate class my-new-class
接口Interface|	ng generate interface my-new-interface
枚举对象Enum|	ng generate enum my-new-enum
模块Module|	ng generate module my-module

# 架构
Angular 应用使用方法：用 Angular 扩展语法编写 HTML 模板， 用组件类管理这些模板，用服务添加应用逻辑， 用模块打包发布组件与服务

通过引导根模块来启动该应用。 Angular 在浏览器中接管、展现应用的内容，并根据我们提供的操作指令响应用户的交互

![image](http://note.youdao.com/yws/api/personal/file/WEBbb5e44b6400e1044b8304cd17df748bc?method=download&shareKey=1fb157c2334799e7329bcbb28240114b)

## 模块 (module)
### 模块简介
Angular 应用是模块化的，并且 Angular 有自己的模块系统，它被称为 Angular 模块或 NgModules

每个 Angular 应用至少有一个模块（根模块），习惯上命名为AppModule。

Angular 模块都是一个带有@NgModule装饰器的类。

NgModule是一个装饰器函数，它接收一个用来描述模块属性的元数据对象。其中最重要的属性是：
* declarations - 声明本模块中拥有的视图类。Angular 有三种视图类：组件、指令和管道。
* exports - declarations 的子集，可用于其它模块的组件模板。
* imports - 本模块声明的组件模板需要的类所在的其它模块。
* providers - 服务的创建者，并加入到全局服务列表中，可用于应用任何部分。
* bootstrap - 指定应用的主视图（称为根组件），它是所有其它视图的宿主。只有根模块才能设置bootstrap属性。
~~~
// src/app/app.module.ts
import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
@NgModule({
  imports:      [ BrowserModule ],
  providers:    [ Logger ],
  declarations: [ AppComponent ],
  exports:      [ AppComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
~~~
### Angular 模块库
Angular 提供了一组 JavaScript 模块。可以把它们看做库模块。每个 Angular 库的名字都带有@angular前缀
~~~
import { Component } from '@angular/core';
~~~

## 组件 (component)
组件负责控制屏幕上的一小块区域，我们称之为视图; 组件通过一些由属性和方法组成的 API 与视图交互
~~~
export class HeroListComponent implements OnInit {
  heroes: Hero[];
  selectedHero: Hero;

  constructor(private service: HeroService) { }

  ngOnInit() {
    this.heroes = this.service.getHeroes();
  }

  selectHero(hero: Hero) { this.selectedHero = hero; }
}

~~~
## 模板 (template)
通过组件的自带的模板来定义组件视图。模板以 HTML 形式存在，告诉 Angular 如何渲染组件

## 元数据 (metadata)
元数据告诉 Angular 如何处理一个类;要告诉 Angular HeroListComponent是个组件，只要把元数据附加到这个类
~~~
@Component({
  selector:    'hero-list',
  templateUrl: './hero-list.component.html',
  providers:  [ HeroService ]
})
export class HeroListComponent implements OnInit {
/* . . . */
}
~~~

## 数据绑定 (data binding)
数据绑定的语法有四种形式：
![image](http://note.youdao.com/yws/api/personal/file/WEBa57b03e91f6bd4ed38e8c6b1e8caa70a?method=download&shareKey=b3b585887d1a4e10af48b2acbd8367f2)
~~~
<li>{{hero.name}}</li>
<hero-detail [hero]="selectedHero"></hero-detail>
<li (click)="selectHero(hero)"></li>
<input [(ngModel)]="hero.name">
~~~
每种形式都有一个方向 —— 绑定到 DOM 、绑定自 DOM 以及双向绑定。

## 指令 (directive)
Angular 模板是动态的。当 Angular 渲染它们时，它会根据指令提供的操作对 DOM 进行转换


## 服务 (service)
组件是最大的服务消费者
~~~
//src/app/logger.service.ts
export class Logger {
  log(msg: any)   { console.log(msg); }
  error(msg: any) { console.error(msg); }
  warn(msg: any)  { console.warn(msg); }
}
//src/app/hero.service.ts
export class HeroService {
  private heroes: Hero[] = [];

  constructor(
    private backend: BackendService,
    private logger: Logger) { }

  getHeroes() {
    this.backend.getAll(Hero).then( (heroes: Hero[]) => {
      this.logger.log(`Fetched ${heroes.length} heroes.`);
      this.heroes.push(...heroes); // fill cache
    });
    return this.heroes;
  }
}
~~~

## 依赖注入 (dependency injection)

Angular 使用依赖注入来提供新组件以及组件所需的服务

1. 当 Angular 创建组件时，会首先为组件所需的服务请求一个注入器 (injector)。
2. 注入器维护了一个服务实例的容器，存放着以前创建的实例。 如果所请求的服务实例不在容器中，注入器就会创建一个服务实例，并且添加到容器中，然后把这个服务返回给 Angular。
3. 当所有请求的服务都被解析完并返回时，Angular 会以这些服务为参数去调用组件的构造函数。 

这就是依赖注入 

![image](http://note.youdao.com/yws/api/personal/file/WEB74722e9c03ab05fe303782eb6e27172b?method=download&shareKey=d698cb66bf2c3035e7b1ada6c2e255e0)

* 函数：参数由调用方决定
* 依赖注入：参数由定于方决定

# 模版
~~~
* {{msg}}  

*  $scope  Controller

* filter    {{123|currency}} {{12321213|date:"yyyy-MM-dd"}}

* ng-clack
~~~