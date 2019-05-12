---
title: docker网络详解
tags:
  - docker
copyright: true
comments: true
toc: true
date: 2019-03-01 09:38:59
categories: docker
password:
---

学习参考文章：https://www.cnblogs.com/zuxing/articles/8780661.html 

# Docker自身的4种网络工作方式
安装Docker时，它会自动创建三个网络，bridge（创建容器默认连接到此网络）、 none 、host，可通过：docker network ls 查看
* host：容器将不会虚拟出自己的网卡，配置自己的IP等，而是使用宿主机的IP和端口。
* Container：创建的容器不会创建自己的网卡，配置自己的IP，而是和一个指定的容器共享IP、端口范围。
* None：该模式关闭了容器的网络功能。
* Bridge：此模式会为每一个容器分配、设置IP等，并将容器连接到一个docker0虚拟网桥，通过docker0网桥以及Iptables nat表配置与宿主机通信。除非你使用该docker run --network=<NETWORK>选项指定，否则Docker守护程序默认将容器连接到此网络。

## host
* host模式：使用 --net=host 指定
* docker的host模式相当于Vmware中的桥接模式，与宿主机在同一个网络中，但没有独立IP地址。
* Docker使用了Linux的Namespaces技术来进行资源隔离，如PID Namespace隔离进程，Mount Namespace隔离文件系统，Network Namespace隔离网络等。
* 一个Network Namespace提供了一份独立的网络环境，包括网卡、路由、Iptable规则等都与其他的Network Namespace隔离。
* 一个Docker容器一般会分配一个独立的Network Namespace。
* 如果启动容器的时候使用host模式，那么这个容器将不会获得一个独立的Network Namespace，而是和宿主机共用一个Network Namespace。容器将不会虚拟出自己的网卡，配置自己的IP等，而是使用宿主机的IP和端口。
* 外界访问容器中的应用，则直接使用宿主机IP即可，不用任何NAT转换，就如直接跑在宿主机中一样。但是，容器的其他方面，如文件系统、进程列表等还是和宿主机隔离的。

## Container
此模式类似于host模式，指定新创建的容器和已经存在的一个容器共享一个Network Namespace，而不是和宿主机共享，其他机制和host模式类似

* container模式：使用 --net=container:NAME_or_ID 指定

## None
* none模式：使用 --net=none 指定
该模式关闭了容器的网络功能

## Bridge
相当于Vmware中的Nat模式，容器使用独立network Namespace，并连接到docker0虚拟网卡（默认模式）


### Docker：网络模式详解
![image](/pub-images/docker桥接模式图.jpg)
* bridge模式：使用 --net=bridge 指定
* 当Docker server启动时，会在主机上创建一个名为docker0的虚拟网桥，此主机上启动的Docker容器会连接到这个虚拟网桥上
* 在主机上创建一对虚拟网卡veth pair设备。veth设备总是成对出现的，它们组成了一个数据的通道，数据从一个设备进入，就会从另一个设备出来。因此，veth设备常用来连接两个网络设备。
* Docker将veth pair设备的一端放在新创建的容器中，并命名为eth0。另一端放在主机中，以veth65f9这样类似的名字命名，并将这个网络设备加入到docker0网桥中，可以通过brctl show命令查看
* 从docker0子网中分配一个IP给容器使用，并设置docker0的IP地址为容器的默认网关，可以通过docker inspect 容器ID方式查看网络

宿主机ifconfig：（较新版的udev使用了新的命名规则，原来的eth0网卡命名变成类似enp0s5）
![image](/pub-images/宿主机ip.png)  
容器ifconfig
![image](/pub-images/容器ip.png)

### bridge模式下容器的通信
* 在bridge模式下，连在同一网桥上的容器可以相互通信
* 若出于安全考虑，也可以禁止它们之间通信，方法是在DOCKER_OPTS变量中设置–icc=false，这样只有使用–link才能使两个容器通信

# 自定义网络
Docker 提供三种 user-defined 网络驱动：bridge, overlay 和 macvlan。overlay 和 macvlan 用于创建跨主机的网络
~~~
docker network ls //显示所有网络
docker network create -d bridge my-net  //新建网络,-d bridge为默认，也可省略
docker run -it --rm --name busybox1 --network my-net busybox sh
docker run -it --rm --name busybox2 --network my-net busybox sh //busybox1和busybox2加入了相同的网络，在调用相互的服务时可以使用别名进行调用了，也可进入容器ping测试
docker network connect my-net web   //添加已经运行的容器到自定义网络
~~~

# 参考文章
https://www.cnblogs.com/zuxing/articles/8780661.html