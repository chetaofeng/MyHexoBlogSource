---
title: JSP知识点小记
tags:
  - Java
  - JSP
copyright: true
comments: true
toc: true
date: 2018-11-26 21:25:33
categories: Java
password:
---
~~~
1.	JSP文件中的元素可分为5类：
A 注释 <!--  -->  隐藏注视：不发给客户  <%--  --%>    java中的注释
B 模板元素   HTMl元素
C 脚本元素 
1. 声明：<%!  %>   
2.表达式  <%=  %> 
3.Scriptlets  <%  %>  是JSP中页面处理请求是执行的Java代码
D 指令元素 
	1. page指令 
 2．include指令(静态，编译时包含检查错误了，区别于动作包含)  
3.taglib指令   允许使用自定义标签
E动作元素   <jsp:   >
2.	表达式语言用${}表示
3.	JSP内建对象
所有的内建对象都是由容器管理和实现，在所有的JSP页面中都可以使用该内部对象
1.	request           javax.servelt.ServletRequset的子类
2.	response          javax.servelt.ServletResponse的子类
3.	pageContext 		javax.servelt.jsp.PageContext的子类
4.	session 			javax.servlet.http.HtttpSession
5.	application   		javx.servlet.ServletContext
6.	out				javax.servlet.jsp.JspWriter
7.	config			javax.servlet.ServletConfig
8.	page				javax.lang.Object
9.	exception			java.lang.Throwable
4.	JSP内建对象详解
一．	Out对象
表示为客户打开的输出流PrintWriter通过他向客户端发送输出六，简单的说，它主要用来向客户端输出数据，代表输出流的对象
区分：out.clear();方法清除缓冲区的数据，并把数据输出到客户端
		 Out.clearBuffer();方法清除缓冲区的数据，但不把数据输出到客户端
其中的方法有print和println，但是println并没有换行的的作用，因为被浏览器忽略了，用println（“<br>”）；
二、	request对象
表示请求对象，通过gerParameter方法可以得到request对象的参数，通过Cookies、Referer等可以得到请求的HTTP头。
来自客户端的请求经Servlet容器处理后，由request对象进行封装。
isUserRole方法判断认证后的用户是否属于逻辑的Role的会员
三、	response对象
   response封装了JSP产生的响应，然后被发送到客户端以响应客户的请求，输出流是有缓冲的
四、	session对象
session对西安用来保存每个用户的信息，以便跟踪每个客户的操作状态。其中，session信息保存在容器中，session的ID保存在客户机的Cookie中。
如果客户端禁掉了Cookies，则会自动的转化为URL-rewriting(重写ＵＲＬ，这个ＵＲＬ中包含客户端的信息)，session自动为每个流程提供方便的存储信息的方法。
	Invalidate方法销毁这个session对象，使得和他绑定的对象都失效
五、	pageContext对象
他为ＪＳＰ页面包装了页面的上下文，管理对属于ＪＳＰ中特殊可见部分中已命名对象的访问。创建和初始化是由容器完成的。ＪＳＰ页面中可以直接使用pageContext对象的句柄
	pageContext对象的getXXX()/setXXX()/findXXX()方法可以用来根据不同的对象范围实现对不同范围内的对象的管理
	forward()方法重定向
注意： pageContext属性默认在当前的页面是共享的
	   Session中的属性在当前是session中是共享的
	   ServletContext对象中的属性对所有页面是共享的
六、	application对象
他为多个应用程序保存信息。对于一个容器而已，每个用户都共同是由一个application对象，他和服务器同生同死
getAttributeNames返回的是一个枚举的实例
可以用来做网站计数器（刷新的时候变了？当服务器关闭时就从0开始计数，解决方法是每当服务器宕机后设置技术的初始值）
七、	config对象
他表示servlet的配置，当一个容器初始化的时候，容器把某些信息通过此对象传递给这个Servlet
getServletContext（）返回执行者的Servlet上下文
getInitParameter 和getInitParameterNames返回初始值
八、	page对象
他指的是JSP实现类的实例，即他就是JSP本身，通过这个可以对他进行访问
九、	exception对象
他值得是运行时的异常，也就是被调用的错误页面（isErrorPage==true）的结果，只有在错误页面中才可以使用
5.	JSP中使用JavaBean
JavaBean往往封装了程序的页面逻辑，它是可重用的组建
区别：JavaBean和Enterprise  JavaBean概念是完全不同的。
	EJB为开发服务器端应用程序组件提供了一个模型，利用这个模型来创建可移植与分布式企业应用程序服务器或组件。
	JavaBean的属性是Bean组件内部状态的抽象表示，可分为四类：
A．Simple  B。Indexed （可以操作数组） C。Bound   D。Constrained
6、	动态页面和用户会话
	JSP是一种动态页面技术
动态网页的动态主要是以下几个方面获得：
1.	根据时间的动态
2.	根据用户类型的动态
3.	根据用户自定义信息的动态
4.	根据用户来自地区的动态
5.	根据数据库内容的动态
用户会会话跟踪
不同页面间的信息交换：
	1.	HTTP信息
将信息保存在HTTP头部，以淘汰了
2． 隐藏字段
<input type=”hiddern” name=”” value=””>
3. URL重写
<a href=”   ?name=3&……”></a>
缺点:不安全，连接长度   （URL长度一般是2KB）
4.Cookie
5.session
7  Sevlet技术
Servlet先于JEE平台而出现
Servlet是由服务器端调用和执行的、按照Servlet自身规范编写的Java类，可以实现Java编写的所有功能除图形界面以外
作用：可以处理客户端传过来的HTTP请求，并返回一个响应。
Servlet的生命周期：
1．	装载Servlet
2．	创建Servlet对象
3．	调用Servlet的init方法
4．	服务  调用service方法
5．	销毁   调用Servlet的destroy方法
平常编写Servlet一般都直接继承HttpServlet
重点：编写配置文件
8. Servlet常用接口的使用
一、  Servlet实现相关
Public interface Servlet 是所有Servlet必须直接或间接实现的接口，有init，destroy，service等方法
Public abstract class GenericServlet implements Servlet，ServletConfig，java.io.Serializable
其方法service是抽象方法
Public abstract class HttpServlet extends GenericServlet implements java.io.Serializable
他是针对使用HTTP协议的Web服务器的Servlet类，通过执行Servlet接口，能够提供HTTP协议的功能
二、Servlet配置相关
Javax.servlet.ServletConfig接口代表Servlet的配置，包括Servlet的名字，促使参数和上下文。
Public interface ServletConfig 有getInitParameter方法，getServletContext等方法
三、Servlet异常相关
1、public class ServletException extends Exception  方法getRootCase返回异常产生原因
2、public class UnavailableException  extends ServletException
当Servelet或Filter不能使用时抛出此异常
四、 请求和相应相关
ServletRequest 、ervletI/O、ServletRequestWrapper（ServletRequest的实现类）、HttpServletReqest等
五、会话跟踪
Public interface HttpSession
此接口被Servlet引擎用来实现HTTP客户端和HTTP会话两者之间的关联。Session用来再无状态的HTTP协议下越过多个请求页面来维持状态和识别用户
一个Session可以通过Coookie或URL来维持
六、Servlet上下文
public interface ServletContext
在服务器上使用Session对象维持与单个客户相关的状态，而当多个用户的Web应用维持一个状态时，则应使用Servlet环境（Context），ServletContext对象代表一组Servlet共享的资源。
七、Servlet协作
public interface RequestDispatcher，包含两个方法：forward和include
八、过滤
通过过滤可以对请求进行统一的编码、对请求进行认证等。每个filter可能只担任很少的任务，多个Filter可以相互协作，通过这种协作，可以完成一个复杂的功能。
public interface Filter  他是Filter必须实现的接口，包含init，doFilter，destroy等方法
public interface FilterChain  是代码的过滤链，通过它可以把过滤的任务在不同的Filter之间转移，包含doFilter方法
public interface FilterConfig 代表Filter的配置
十、	使用HttpServlet处理客户端的请求
Servlet被设计成轻轻驱动的。
当Web容器接受到某个对Servlet的请求时，把他封装成一个HttpServletRequest对象，然后把此对象传给Servlet的对应处理方法，如doGet和doPost等
doGet：可以获取服务器信息，并将其作为响应返回给客户端
doGet：用户把数据传送到服务器端，可以隐藏放松的数据，适合发送大量的数据
9、获得Servlet的初始化参数
   通过ServletConfig接口获得Servlet的初始参数 
10、Servlet的配置
第八章
15、JSP和Servlet结合的方法
   模式一：JSP+JavaBean
       所有数据通过Bean处理，JSP实现页面的表现
       小型应用中可以考虑
   模式二：JSP+Servlet+JavaBean 
       遵循MVC模式，Servlet作为控制器修改Bean的属性，JSP读取Bean的属性，然后进行显示，即JavaBean作为ＪＳＰ和Ｓｅｒｖｌｅｔ通信的中间工具
       大中型项目中使用
实际中，所有ＪＳＰ都必须编译成Servlet，并且在Servlet的容器中执行。
16、JSP开发中的常用技巧
一、在不同页面之间共享数据（同一用户）
A．ssession  B. Cookie C.隐含表单 D.ServletContext  E.application F.文件系统或者数据库
二、在不同用户之间共享数据
A．使用ServletContext     B、application对象
三、创建错误处理页面
在编译时出现错误，其代码为500.
在JSP中声明出错页面<%@ page errorPage=”error.jsp”%>;在error.jsp中首先要制定该isErrorPage=“true”，只有这样，这个页面才能进行错误处理 ，才能使用exception对象。
一句话：JSP 错误处理的本质是在不同的页面或者类中传递异常，并且在目标页面处理异常
17、自定义标签库的开发
~~~
