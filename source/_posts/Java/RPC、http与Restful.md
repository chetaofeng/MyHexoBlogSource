---
title: RPC、http与Restful
tags: 
  - java 
copyright: true
comments: true
toc: true
date: 2013-03-24 15:41:51
categories: java
password:
---
RPC（即Remote Procedure Call，远程过程调用）和HTTP（HyperText Transfer Protocol，超文本传输协议）

RPC主要工作在TCP协议之上，而HTTP服务主要是工作在HTTP协议之上，我们都知道HTTP协议是在传输层协议TCP之上的，所以效率来看的话，RPC当然是要更胜一筹

REST，即Representational State Transfer的缩写。翻译过来是表现层状态转换。
满足REST约束条件和原则的架构，就被称为是RESTful架构


restful首先是要求必须把所有的应用定义成为“resource”，然后只能针对资源做有限的四种操作

有太多现实中需要的API，无法顺当的融入到restful所定义的规范中。
比方说，user login / resetpassword等等


JSON rpc基本上仅是要求所有的请求必须有msg id，有函数名，然后可定义参数，并且区分返回值与异常；也可定义『命名空间』来对函数模块做划分。

restful API仅适用与业务非常简单的场景，比方说，就是为了提供少量数据表单的增删改查。而这种场景实在是太过简单，实际中几乎找不到。

RPC协议性能要高的多，例如Protobuf、Thrift、Kyro等，（如果算上序列化）吞吐量大概能达到http的二倍

对外开放给全世界的API推荐采用RESTful，是否严格按照规范是一个要权衡的问题。要综合成本、稳定性、易用性、业务场景等等多种因素。
内部调用推荐采用RPC方式

以Apache Thrift为代表的二进制RPC，支持多种语言（但不是所有语言），四层通讯协议，性能高，节省带宽。相对Restful协议，使用Thrifpt RPC，在同等硬件条件下，带宽使用率仅为前者的20%，性能却提升一个数量级。但是这种协议最大的问题在于，无法穿透防火墙。

以Spring Cloud为代表所支持的Restful 协议，优势在于能够穿透防火墙，使用方便，语言无关，基本上可以使用各种开发语言实现的系统，都可以接受Restful 的请求。 但性能和带宽占用上有劣势

业内对微服务的实现，基本是确定一个组织边界，在该边界内，使用RPC; 边界外，使用Restful。这个边界，可以是业务、部门，甚至是全公司

REST 是面向资源的，这个概念非常重要，而资源是通过 URI 进行暴露
URI 的设计只要负责把资源通过合理方式暴露出来就可以了。对资源的操作与它无关，操作是通过 HTTP动词来体现，所以REST 通过 URI 暴露资源时，会强调不要在 URI 中出现动词。
比如：左边是错误的设计，而右边是正确的
~~~
GET /rest/api/getDogs --> GET /rest/api/dogs 获取所有小狗狗 
GET /rest/api/addDogs --> POST /rest/api/dogs 添加一个小狗狗 
GET /rest/api/editDogs/:dog_id --> PUT /rest/api/dogs/:dog_id 修改一个小狗狗 
GET /rest/api/deleteDogs/:dog_id --> DELETE /rest/api/dogs/:dog_id 删除一个小狗狗
~~~

一个完整的RPC架构里面包含了四个核心的组件，分别是Client ,Server,Client Stub以及Server Stub，这个Stub大家可以理解为存根
1)客户端（Client），服务的调用方。
2)服务端（Server），真正的服务提供者。
3)客户端存根，存放服务端的地址消息，再将客户端的请求参数打包成网络消息，然后通过网络远程发送给服务方。
4)服务端存根，接收客户端发送过来的消息，将消息解包，并调用本地的方法。 
目前流行的开源RPC框架：
gRPC是Google；Thrift是Facebook的一个开源项目；Dubbo是阿里集团开源的一个极为出名的RPC框架

RPC框架的好处就显示出来了，首先就是长链接，不必每次通信都要像http一样去3次握手什么的，减少了网络开销；其次就是RPC框架一般都有注册中心，有丰富的监控管理；发布、下线接口、动态扩展等，对调用方来说是无感知、统一化的操作

RPC服务主要是针对大型企业的，而HTTP服务主要是针对小企业的，因为RPC效率更高，而HTTP服务开发迭代会更快


RPC是分布式架构的核心，按响应方式分如下两种：
同步调用：客户端调用服务方方法，等待直到服务方返回结果或者超时，再继续自己的操作
异步调用：客户端把消息发送给中间件，不再等待服务端返回，直接继续自己的操作。

同步调用的实现方式有WebService和RMI。RMI实际上是Java语言的RPC实现
异步调用的JAVA实现版就是JMS(Java Message Service)，目前开源的的JMS中间件有Apache社区的ActiveMQ、Kafka消息中间件，另外有阿里的RocketMQ。

https://blog.csdn.net/u014590757/article/details/80233901

REST使用HTTP+URI+XML /JSON 的技术来实现其API要求的架构风格：HTTP协议和URI用于统一接口和定位资源，文本、二进制流、XML、JSON等格式用来作为资源的表述

 RPC架构分为三部分：
1.     服务提供者，运行在服务器端，提供服务接口定义与服务实现类。
2.     服务中心，运行在服务器端，负责将本地服务发布成远程服务，管理远程服务，提供给服务消费者使用。
3.     服务消费者，运行在客户端，通过远程代理对象调用远程服务。



