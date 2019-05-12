---
title: CSS选择符号
tags:
  - css
copyright: true
comments: true
toc: true
date: 2018-10-26 16:04:30
categories: 前端
password:
---

# CSS的缺点
1.	不能重新排序文档中的元素
2.	不能判断和控制那个元素被显示，哪个元素不被显示
3.	不能统计计算元素中的数据

XSL：eXtensible StyleSheet Language可扩展样式表语言

# 在HTML中应用CSS的三种方式
1.	嵌入式，通过script标签放在head中
2.	外部引用式：A @import方法 @import “*.css”/@import url(“*.css”);  B link元素
3.	内联式：写在元素内部
规则块：@规则以一个关键字@开头，紧跟在后的是一个标识符，共有如下几个@规则：
	@import，@charset，@page，@media
注意：CSS不区分大小写；关键字以标识符的形式出现，不可发那个旨在引号之间；客户端浏览器特定的扩展以字符-或者—开头；
升入了解一下CSS的计数器
属性值的计算步骤：指定值，计算值，使用值，实际值

# CSS的选择符的语法：
1.	简单选择符：类型选择符 p{}；通用选择符 *
2.	派生选择符： A B，元素B是其前辈元素的任意后代，而不仅仅是元素A的直接子元素
3.	子选择符：body >em，当一个元素是另一个匀速的直接子元素是使用
4.	相邻同级选择符： E1+E2，其中E2是选择符的主题，也就是说，设置的是E2元素的样式。匹配条件是：如果E1和E2在文档中的父元素相同，且E1紧接在E2之前（忽略文本节点和注释），则匹配
5.	属性选择符和类选择符
A 属性选择符：E[];E[foo=”str”];E[foo~=””]属性的值可以是包含空白的字符串，但是字符串中两个空白之间必须有一个只是恰好等于str;E[lang|=”en”],左边开始的字符串值必须是en
B 类选择符  *.E
C 匹配子集 <P class=“Tom john boy”/>，则p.Tom.john.boy匹配他
D ID选择符  *#E
E 伪元素和伪类（见下方详细说明）

# BOX模型
由外到内是margin，border，padding，content

# 块级元素和行内级元素（div和span）：
了解其不同，通过display属性进行转换

# 伪元素、伪类选择和动态生成内容
为了对文档树之外的信息赋予样式，CSS引入了伪元素和伪类的概念，有如下几种：

1.	第一个子元素伪类：first-child
2.	动态和链接相关的伪类
A 链接伪类（：link，：visited）
B 动态伪类（：hover，：active，：focus）
C 语言伪类（：lang）
D 首行和首字符伪元素（：first-line，：first-letter）
E 用于插入内容的伪元素（：before，：after）

* 学习对列表定义样式
* 学习对溢出和裁剪的用法：overflow，clip:rect(5px,12px,1px,3px)

！import用来改变属性的优先级，一般不建议使用，可通过此标签查找冲突
# CSS中盒子的定位：
* 定位方式：正常流向，浮动，绝对定位
* 学习position，display，flow和z-index的使用

利用CSS分页显示(Page-break-before)和打印
使用IE转悠filter属性实现滤镜和过渡效果
   Filter:滤镜名（滤镜参数）
