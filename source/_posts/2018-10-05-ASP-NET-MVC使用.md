---
title: ASP.NET MVC使用
tags:
  - ASP.NET
  - MVC
copyright: true
comments: true
toc: true
date: 2018-10-05 20:08:31
categories: C#
password:
---
# 申明
文章内容记录自：http://www.w3school.com.cn/aspnet/mvc_intro.asp， 为个人学习笔记记录。

# MVC项目文件夹 
典型的 ASP.NET MVC web 应用程序拥有如下文件夹内容：
<img src="/pub-images/ASPMVC.png" width=256 height=256 />
~~~
应用程序信息
* Properties
* 引用

应用程序文件夹
* App_Data 文件夹  //用于存储应用程序数据
* App_Start 文件夹 //含应用程序的配置逻辑文件
 ** BundleConfig.cs: 注册所使用的捆绑的CSS 和 JS文件。
 ** FilterConfig.cs: 注册外部/全局过滤器，这些过滤器可以被应用到每个Action和Controller中去.
 ** RouteConfig.cs: 配置MVC应用程序的系统路由路径。
 ** Startup.Auth.cs: 配置MVC应用程序的安全信息，包括Authentication和Authorization配置  
* Content 文件夹   //用于静态文件，比如样式表（CSS 文件）、图表和图像
* Controllers 文件夹   //包含负责处理用户输入和响应的控制器类,名称必须以 "Controller" 结尾
* Models 文件夹    //包含表示应用程序模型的类。模型存有并操作应用程序的数据
* Scripts 文件夹   //存储应用程序的 JavaScript 文件
* Views 文件夹 //存有与应用程序的显示相关的 HTML 文件 
 ** Shared   //用于存储控制器间分享的视图
 ** [名称]   //每个控制器对应的一个文件夹
 ** _ViewStart.cshtml //其内代码被自动添加到由应用程序显示的所有视图。

配置文件
* Global.asax   //主要是web应用程序的全局设置文件，该文件包含响应 ASP.NET 或HTTP模块所引发的应用程序级别和会话级别事件的代码。Global.asax 文件驻留在 ASP.NET 应用程序的根目录中。运行时，分析 Global.asax 并将其编译到一个动态生成的 .NET Framework 类，该类是从HttpApplication基类派生的。配置 ASP.NET，以便自动拒绝对 Global.asax 文件的任何直接的 URL 请求；外部用户不能下载或查看其中的代码。Global.asax 文件是可选的。只在希望处理应用程序事件或会话事件时，才应创建它.
* packages.config   //NuGet管理用的
* Web.config
~~~
> 控制器位于 Controllers 文件夹，视图位于 Views 文件夹，模型位于 Models 文件夹。您不必在应用程序代码中使用文件夹名称

# 控制器Controllers
1. web 服务器通常会将进入的 URL 请求直接映射到服务器上的磁盘文件.某个 URL 请求（比如 "http://www.abc.cn/index.asp"）将映射到服务器根目录上的文件 "index.asp"。
> MVC 框架的映射方式有所不同。
2. MVC 将 URL 映射到方法。这些方法在类中被称为“控制器”。控制器负责处理进入的请求、处理输入、保存数据、并把响应发送回客户端。
3. 在mvc中所有的controller类都必须使用"Controller"后缀来命名,并且对Action也有一定的要求：
* 必须是一个public方法
* 必须是实例方法
* 没有标志NonActionAttribute特性的(NoAction)
* 不能被重载
* 必须返回ActionResult类型
> 具体可返回数据类型请参考：https://blog.csdn.net/pasic/article/details/7110134

# 模型Models
模型包含所有应用程序逻辑（业务逻辑、验证逻辑、数据访问逻辑），除了纯视图和控制器逻辑。

# HTML帮助器
HTML 帮助器用于修改 HTML 输出。
## HTML 链接
通过 MVC，Html.ActionLink() 不连接到视图。它创建控制器操作（controller action）的连接。

## HTML 表单元素
* BeginForm()
* EndForm()
* TextArea()
* TextBox()
* CheckBox()
* RadioButton()
* ListBox()
* DropDownList()
* Hidden()
* Password()

~~~
<%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and 
try again.") %>
<% using (Html.BeginForm()){%>
<p>
<label for="FirstName">First Name:</label>
<%= Html.TextBox("FirstName") %>
<%= Html.ValidationMessage("FirstName", "*") %>
</p>
<p>
<label for="LastName">Last Name:</label>
<%= Html.TextBox("LastName") %>
<%= Html.ValidationMessage("LastName", "*") %>
</p>
<p>
<label for="Password">Password:</label>
<%= Html.Password("Password") %>
<%= Html.ValidationMessage("Password", "*") %>
</p>
<p>
<label for="Password">Confirm Password:</label>
<%= Html.Password("ConfirmPassword") %>
<%= Html.ValidationMessage("ConfirmPassword", "*") %>
</p>
<p>
<label for="Profile">Profile:</label>
<%= Html.TextArea("Profile", new {cols=60, rows=10})%>
</p>
<p>
<%= Html.CheckBox("ReceiveNewsletter") %>
<label for="ReceiveNewsletter" style="display:inline">Receive Newsletter?</label>
</p>
<p>
<input type="submit" value="Register" />
</p>
<%}%>
~~~

# MVC参考手册
http://www.w3school.com.cn/aspnet/mvc_reference.asp