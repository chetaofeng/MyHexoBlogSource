---
title: MQTT入门
tags:
  - java
copyright: true
comments: true
toc: true
date: 2019-02-20 21:25:33
categories: Java
password:
---

# 简介
官网：http://mqtt.org/
* MQTT(英语全称，Message Queue Telemetry Transport),中文翻译过来就是遥测传输协议,是一个轻量级的消息总线协议，提供消息订阅与发布，属于物联网(Internet of Thing)的一个传输协议
* 主流的MQTT是基于TCP连接进行数据推送的，但是同样有基于UDP的版本，叫做MQTT-SN
* MQTT是一套标准，常用的服务端有Eclipse的Mosquitto。MQTT是IBM出品，Eclipse也是IBM出品，所以Mosquitto算是官方实现吧
* MQTT在通过卫星链路通信传感器、偶尔拨号的医疗设备、智能家居、及一些小型化设备中已广泛使用。　　

MQTT协议中文版： https://mcxiaoke.gitbooks.io/mqtt-cn/content/mqtt/01-Introduction.html

# 消息发布服务质量（QoS）
为了满足不同的场景，MQTT支持三种不同级别的服务质量（Quality of Service，QoS）为不同场景提供消息可靠性：
* 级别0：尽力而为，“至多一次”。消息发布完全依赖底层TCP/IP网络，遇到意外并不会重试，会发生消息丢失或重复，这一级别可用于如下情况，环境传感器数据，丢失一次读记录无所谓，因为不久后还会有第二次发送。这一种方式主要普通APP的推送，倘若你的智能设备在消息推送时未联网，推送过去没收到，再次联网也就收不到了
* 级别1：“至少一次”，确保消息到达，但消息重复可能会发生。
* 级别2：“只有一次”，确保消息到达一次 

# 实现方式
* 实现MQTT协议需要客户端和服务器端通讯完成，在通讯过程中，MQTT协议中有三种身份：发布者（Publish）、代理（Broker）（服务器）、订阅者（Subscribe）
* 消息的发布者和订阅者都是客户端，消息代理是服务器，消息发布者可以同时是订阅者

MQTT传输的消息分为：主题（Topic）和负载（payload）两部分：
* Topic，可以理解为消息的类型，订阅者订阅（Subscribe）后，就会收到该主题的消息内容（payload）；
* payload，可以理解为消息的内容，是指订阅者具体要使用的内容。

# 消息类型
MQTT拥有14种不同的消息类型:
~~~
CONNECT：客户端连接到MQTT代理
CONNACK：连接确认
PUBLISH：新发布消息
PUBACK：新发布消息确认，是QoS 1给PUBLISH消息的回复
PUBREC：QoS 2消息流的第一部分，表示消息发布已记录
PUBREL：QoS 2消息流的第二部分，表示消息发布已释放
PUBCOMP：QoS 2消息流的第三部分，表示消息发布完成
SUBSCRIBE：客户端订阅某个主题
SUBACK：对于SUBSCRIBE消息的确认
UNSUBSCRIBE：客户端终止订阅的消息
UNSUBACK：对于UNSUBSCRIBE消息的确认
PINGREQ：心跳（空闲时发一个）
PINGRESP：确认心跳
DISCONNECT：客户端终止连接前优雅地通知MQTT代理
~~~

# mosquitto
一款实现了消息推送协议 MQTT v3.1 的开源消息代理软件，提供轻量级的，支持可发布/可订阅的的消息推送模式，使设备对设备之间的短消息通信变得简单
~~~
mosquitto – 代理器主程序
mosquitto.conf – 配置文件
mosquitto_passwd – 用户密码管理工具
mosquitto_tls – very rough cheat sheet for helping with SSL/TLS
mosquitto_pub – 用于发布消息的命令行客户端
mosquitto_sub – 用于订阅消息的命令行客户端
mqtt – MQTT的后台进程
libmosquitto – 客户端编译的库文件
~~~

## 安装
~~~
sudo apt-get install mosquitto
sudo apt-get install mosquitto-clients
sudo service mosquitto status   //测试mosquitto运行状态
~~~
## 测试
订阅主题
~~~
mosquitto_sub -h 10.211.55.3 -t "mtopic" -v
~~~
再打开一个终端，发布主题
~~~
mosquitto_pub -h 10.211.55.3 -t "mtopic" -m "Hello mqtt"
~~~
## 更多配置
* 更多配置参数讲解，参考：https://www.cnblogs.com/saryli/p/9812452.html
* mosquitto默认可匿名访问，password-file密码文件，acl_file访问控制列表，通过mosquitto.conf启用，编辑文末添加如下：
~~~
allow_anonymous false
password_file /etc/mosquitto/pwfile.conf
acl_file /etc/mosquitto/aclfile.conf
~~~
* 准备配置的相关配置文件
~~~
cd /usr/share/doc/mosquitto/examples/
sudo cp aclfile.example  /etc/mosquitto/aclfile.conf
sudo cp pwfile.example /etc/mosquitto/pwfile.conf
sudo cp pskfile.example /etc/mosquitto/pskfile.conf
~~~
* 添加用户
添加用户admin、mosquitto,密码同用户名
~~~
sudo mosquitto_passwd -b /etc/mosquitto/pwfile.conf mosquitto mosquitto
sudo mosquitto_passwd -b /etc/mosquitto/pwfile.conf admin admin
~~~
* 关联Topic和用户
admin设置为订阅权限，并且只能访问的主题为"root/topic/#"，mosquitto 设置为发布权限，并且只能访问的主题为"root/topic/#"，编辑aclfile.conf：
~~~
user admin
topic read mtopic/#
user mosquitto
topic write mtopic/#
~~~
read 订阅权限 、write 发布权限、# 通配符表示所有的
* 重启服务，测试配置
~~~
ps -aux|grep mosquitto
sudo kill -9 pid
ps -aux|grep mosquitto
sudo mosquitto -c /etc/mosquitto/mosquitto.conf  -d
~~~
* 启动订阅端
~~~
mosquitto_sub -h localhost -t "mtopic" -u mosquitto -P mosquitto -v
~~~
* 启动发布端
再打开一个终端
~~~
mosquitto_pub -h localhost -t "mtopic" -u admin -P admin -m "Hello mqtt user"
~~~

## Java实现
Maven依赖 MQTT的Java客户端的使用
~~~
<dependency>
    <groupId>org.eclipse.paho</groupId>
    <artifactId>org.eclipse.paho.client.mqttv3</artifactId> 
    <version>${mqtt.version}</version>
</dependency>
~~~
代码实现参考：
https://www.cnblogs.com/sxkgeek/p/9140180.html
