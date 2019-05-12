---
title: Vue入门
tags:
  - Vue 
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---
~~~
https://cn.vuejs.org/
https://vuejs.org/
https://cn.vuejs.org/v2/api/
~~~

# 简介
> Vue.js是当下很火的一个JavaScript MVVM库，它是以数据驱动和组件化的思想构建的。相比于Angular.js，Vue.js提供了更加简洁、更易于理解的。是个人维护项目

> Vue.js是数据驱动的，你无需手动操作DOM

> 通过一些特殊的HTML语法，将DOM和数据绑定起来。一旦你创建了绑定，DOM将和数据保持同步，每当变更了数据，DOM也会相应地更新

> 使用Vue.js时，也可以结合其他库一起使用，比如jQuery

使用Vue的过程就是定义MVVM各个组成部分的过程的过程
1. 定义View
~~~
<div id="app">
    {{ message }}
</div>
~~~
2. 定义Model，如： 
~~~
var exampleData = {
    message: 'Hello World!'
}
~~~
3. 创建一个Vue实例或"ViewModel"，它用于连接View和Model
~~~
new Vue({
    el: '#app',
    data: exampleData
})
~~~

# Vue实例
## 构造器
每个 Vue.js 应用都是通过构造函数 Vue 创建一个 Vue 的根实例 启动的：
~~~
var vm = new Vue({
  // 选项
})
~~~
实例化 Vue 时，需要传入一个选项对象，它可以包含数据、模板、挂载元素、方法、生命周期钩子等选项,具体API查看：https://cn.vuejs.org/v2/api/

## 属性和方法
* 每个 Vue 实例都会代理其 data 对象里所有的属性
* ==只有这些被代理的属性是响应的==
* 如果在实例创建之后添加新的属性到实例上，它不会触发视图更新
* Vue 实例暴露了一些有用的实例属性与方法。这些属性与方法都有前缀 $，以便与代理的 data 属性区分


## 实例生命周期
每个 Vue 实例在被创建之前都要经过一系列的初始化过程

![image](http://note.youdao.com/yws/api/personal/file/WEB57f1826aa9ca7087a82b38e583419433?method=download&shareKey=33f8412154b6172b3bf4b99f8bcf0a40)

# Vue.js的常用指令
Vue.js的指令是以v-开头的，它们作用于HTML元素，指令提供了一些特殊的特性，将指令绑定在元素上时，指令会为绑定的目标元素添加一些特殊的行为，我们可以将指令看作特殊的HTML特性（attribute）

* 用 key 管理可复用的元素:添加一个具有唯一值的 key 属性,来声明“这两个元素是完全独立的——不要复用它们”

Vue.js提供了一些常用的内置指令，接下来我们将介绍以下几个内置指令：

##  v-if指令
条件渲染指令，它根据表达式的真假来删除和插入元素
~~~
<h1 v-if="age >= 25">Age: {{ age }}</h1>
~~~
## v-show指令
控制显示／隐藏，true／false
* 和v-if指令不同的是，使用v-show指令的元素始终会被渲染到HTML，它只是简单地为元素设置CSS的style属性
~~~
<h1 v-show="age >= 25">Age: {{ age }}</h1>
~~~
## v-else指令
* 可以用v-else指令为v-if或v-show添加一个“else块”
* v-else元素必须立即跟在v-if或v-show元素的后面——否则它不能被识别
~~~
<h1 v-show="name.indexOf('keep') >= 0">Name: {{ name }}</h1>
<h1 v-else>Sex: {{ sex }}</h1>
~~~
## v-for指令
~~~
<ul>
    <li v-for="value in json">
        {{value}} {{$index}} {{$key}}
    </li>
     <li v-for="(k,v) in json">
        {{k}} {{v}} {{$index}} {{$key}}
    </li>
</ul>
~~~
## v-bind指令
* 如果属性中要绑定Vue数据，最好用绑定的方式
* v-bind指令可以在其名称后面带一个参数，中间放一个冒号隔开，这个参数通常是HTML元素的特性（attribute）
~~~
<img v-bind:src="{{url}} alt=""/>"//后台不会报错误，不绑定后台会报错，界面不影响
~~~
* class

用法一：其值为数组形式，数组中的值为Vue的data中定义的属性，而vue中属性对应的值为真正的css样式
~~~
.astyle{ color:red}
.bstyle{ background-color:bule}
<script>
    new Vue(){
        data:{
            a:"astyle",
            b:"bstyle"
        }
    }
</script>
<div id="box">
    <strong :class="[a,b]">测试文字</strong>
</div>
~~~
方式二：其值为json格式，json的key为真正的css样式名称，value为true/false／data中的属性
~~~
<div id="box">
    <strong :class="{astyle:true,bstyle:a}">测试文字</strong>
</div>
~~~
方式三：class的值直接是data的一个json数据
~~~
new Vue(){
    data:{
       jsonData:{
            astyle:true,
            bstyle:false
       }
    }
}
<div id="box">
    <strong :class="jsonData">测试文字</strong>
</div>
~~~
* style：复合样式采用的是驼峰命名法

方法一：
~~~
<strong :style="color:red">文字</strong>
~~~
方式二：
~~~
new Vue(){
    data:{
        astyle:{color:'red'},
        bstyle:{backgroudColor:'blue'}
    }
}
<div id="box">
    <strong :style="[astyle,bstyle]]">测试文字</strong>
</div>
~~~
方式三：官方推荐
~~~
new Vue(){
    data:{
        jsonData:{
            color:'red',
            backgroudColor:'blue'
        }
    }
}
<div id="box">
    <strong :style="jsonData">测试文字</strong>
</div>
~~~
## v-on指令
用于监听DOM事件
~~~
<script>
new Vue(){
    methods:{
        show:function(){alert(124);}
    }
}
</script>

<input type="button" value="弹框" v-on:click="show()"
~~~

==知识点==：v-bind指令可以缩写为一个冒号，v-on指令可以缩写为@符号 

## v-model
表单元素的双向绑定，它会根据控件类型自动选取正确的方法来更新元素
~~~
<input v-model="message.trim" placeholder="edit me">
<p>Message is: {{ message }}</p>
~~~
* .number:将用户的输入值转为 Number 类型（如果原值的转换结果为 NaN 则返回原值）,如：<input v-model.number="age" type="number">
* .trim：自动过滤用户输入的首尾空格
* .lazy：在默认情况下， v-model 在 input 事件中同步输入框的值与数据 ，但可以添加一个修饰符 lazy ，从而转变为在 change 事件中同步


# 事件
## 事件修饰符
~~~
<!-- 阻止单击事件冒泡 -->
<a v-on:click.stop="doThis"></a>
<!-- 提交事件不再重载页面 -->
<form v-on:submit.prevent="onSubmit"></form>
<!-- 修饰符可以串联  -->
<a v-on:click.stop.prevent="doThat"></a>
<!-- 只有修饰符 -->
<form v-on:submit.prevent></form>
<!-- 添加事件侦听器时使用事件捕获模式 -->
<div v-on:click.capture="doThis">...</div>
<!-- 只当事件在该元素本身（而不是子元素）触发时触发回调 -->
<div v-on:click.self="doThat">...</div>
~~~
### 事件冒泡阻止
1. 传递事件$event，ev.cancleBubble=true;
2. @click.stop

### 默认行为
如网页中添加了右键事件后，系统还有默认右键事件
1. 传递事件$event，ev.preventDefault();
2. @contextmenu.prevent

### 键盘事件
1. 传递事件$event，ev.keyCode，判断后进行操作
2. @keyup.键值，如：@keyup.13
3. @keyup.键盘键面值，如：@keyup.enter

## 按键修饰符
~~~
<input v-on:keyup.13="submit">
~~~
全部的按键别名：
~~~
.enter
.tab
.delete (捕获 “删除” 和 “退格” 键)
.esc
.space
.up
.down
.left
.right
~~~

# 模版语法
msg类似为js变量,Mustache中可以进行JS编程，如申明变量，条件判断等
~~~
* 数据绑定最常见的形式就是使用 “Mustache” 语法（双大括号）的文本插值：{{msg}} 数据更新模版变化
* {{*msg}} 只绑定一次
* {{{msg}}}  HTML转义，html语法会翻译
~~~

# 计算属性
* 在模板中放入太多的逻辑会让模板过重且难以维护，应当考虑使用计算属性
* 可以像绑定普通属性一样在模板中绑定计算属性
* 计算属性是基于它们的依赖进行缓存的。计算属性只有在它的相关依赖发生改变时才会重新求值,==这也是计算属性和methods的区别，需依据具体情况使用==
~~~
<div id="example">
  <p>Original message: "{{ message }}"</p>
  <p>Computed reversed message: "{{ reversedMessage }}"</p>
</div>

var vm = new Vue({
  el: '#example',
  data: {
    message: 'Hello'
  },
  computed: {
    // a computed getter
    reversedMessage: function () {
      // `this` points to the vm instance
      return this.message.split('').reverse().join('')
    }
  }
});
~~~
* 计算属性默认只有 getter ，不过在需要时你也可以提供一个 setter 
~~~
computed: {
  fullName: {
    // getter
    get: function () {
      return this.firstName + ' ' + this.lastName
    },
    // setter
    set: function (newValue) {
      var names = newValue.split(' ')
      this.firstName = names[0]
      this.lastName = names[names.length - 1]
    }
  }
}

在运行 vm.fullName = 'John Doe' 时， setter 会被调用
~~~

# 过滤器
> 过滤模版数据
~~~
{{msg|filterA 参数|filterB 参数|...}}
~~~

系统默认提供过滤器，如：
~~~
* {{'welcome'|uppercase}}
* {{'welcome'|lowercase}}
* {{'welcome'|capitalize}}
* {{'welcome'|currency}}
* {{'welcome'|currency "$"}}    //传参
* {{ message | filterA('arg1', arg2) }}  //穿参
~~~

# 交互
Vue本身不支持Ajax框架，需引入官方库vue-resource,支持get、post、jsonp
* get
~~~
methods:{
    getFun:function(){
        this.$http.get("a.txt").then(function(res){
            console.log(res.data);
        },function(res){
            console.log(res.status);
        });
    },
    //传递参数
    get2Fun:function(){
        this.$http.get("a.php",{a:1,b:2}}).then(function(res){
            console.log(res.data);
        },function(res){
            console.log(res.status);
        });
    }
}
~~~
* post
~~~
methods:{
    postFun:function(){
        this.$http.post("a.php",{a:1,b:2},{emulateJSON:true}).then(function(res){
            console.log(res.data);
        },function(res){
            console.log(res.status);
        });
    }
}
~~~
* jsonp
~~~
methods:{
    postFun:function(){
        this.$http.jsonp(
            "https://www.baidu....",
            {a:1},
            {jsonp:''cb''}//callback 名字
        )
        .then(function(res){
                console.log(res.data);
            },function(res){
                console.log(res.status);
            }
        );
    }
}
~~~

# 组件
## 使用组件
* 要注册一个全局组件，你可以使用 Vue.component(tagName, options)。 例如：
~~~
Vue.component('my-component', {
  // 选项
})
~~~
* Vue.js建议自定义标签名：==小写，并且包含一个短杠==
* 要确保在初始化根实例 之前 注册了组件
* 局部注册
~~~
var Child = {
  template: '<div>A custom component!</div>'
}
new Vue({
  // ...
  components: {
    // <my-component> 将只在父模板可用
    'my-component': Child
  }
})
~~~

## 组件通信
在 Vue.js 中，父子组件的关系可以总结为 props down, events up 。父组件通过 props 向下传递数据给子组件，子组件通过 events 给父组件发送消息

### Prop
~~~
Vue.component('child', {
  // 声明 props
  props: ['myMessage'],
  // 就像 data 一样，prop 可以用在模板内
  // 同样也可以在 vm 实例中像 “this.myMessage” 这样使用
  template: '<span>{{ myMessage }}</span>'
})

<child my-message="hello!"></child>   //传入属性值
~~~
* HTML 特性是不区分大小写的。所以，当使用的不是字符串模版，camelCased (驼峰式) 命名的 prop 需要转换为相对应的 kebab-case (短横线隔开式) 命名
* 每次父组件更新时，子组件的所有 prop 都会更新为最新值,不应该在子组件内部改变 prop,如果有改变的需要，可通过A.定义一个局部变量;B.定义一个计算属性

Prop验证
~~~
Vue.component('example', {
  props: {
    // 基础类型检测 （`null` 意思是任何类型都可以）
    propA: Number,
    // 多种类型
    propB: [String, Number],
    // 必传且是字符串
    propC: {
      type: String,
      required: true
    },
    // 数字，有默认值
    propD: {
      type: Number,
      default: 100
    },
    // 数组／对象的默认值应当由一个工厂函数返回
    propE: {
      type: Object,
      default: function () {
        return { message: 'hello' }
      }
    },
    // 自定义验证函数
    propF: {
      validator: function (value) {
        return value > 10
      }
    }
  }
})
~~~
type 可以：String/Number/Boolean/Function/Object/Array

### 自定义事件
每个 Vue 实例都实现了事件接口(Events interface)，即：
* 使用 $on(eventName) 监听事件
* 使用 $emit(eventName) 触发事件
~~~
<div id="counter-event-example">
  <p>{{ total }}</p>
  <button-counter v-on:increment="incrementTotal"></button-counter>
</div>

Vue.component('button-counter', {
  template: '<button v-on:click="increment">{{ counter }}</button>',
  data: function () {
    return {
      counter: 0
    }
  },
  methods: {
    increment: function () {
      this.counter += 1
      this.$emit('increment')
    }
  },
})
new Vue({
  el: '#counter-event-example',
  data: {
    total: 0
  },
  methods: {
    incrementTotal: function () {
      this.total += 1
    }
  }
})
~~~

### 非父子组件通信
~~~
var bus = new Vue()
// 触发组件 A 中的事件
bus.$emit('id-selected', 1)
// 在组件 B 创建的钩子中监听事件
bus.$on('id-selected', function (id) {
  // ...
})
~~~

## 使用Slot分发内容
* 为了让组件可以组合，我们需要一种方式来混合父组件的内容与子组件自己的模板，这个过程被称为 内容分发
* 使用特殊的 <slot> 元素作为原始内容的插槽
* 父组件模板的内容在父组件作用域内编译；子组件模板的内容在子组件作用域内编译
~~~
<!-- 无效,试图在父组件模板内将一个指令绑定到子组件的属性/方法 -->
<child-component v-show="someChildProperty"></child-component>
~~~
如果要绑定作用域内的指令到一个组件的根节点，你应当在组件自己的模板上做：
~~~
Vue.component('child-component', {
  // 有效，因为是在正确的作用域内
  template: '<div v-show="someChildProperty">Child</div>',
  data: function () {
    return {
      someChildProperty: true
    }
  }
})
~~~