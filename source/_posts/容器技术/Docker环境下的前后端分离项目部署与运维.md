---
title: Docker环境下的前后端分离项目部署与运维
tags:
  - docker
copyright: true
comments: true
toc: true
date: 2019-02-24 09:38:59
categories: docker
password:
---

学习视频：https://coding.imooc.com/learn/list/219.html

# 简介
人人开源项目：https://www.renren.io/
项目部署图解：
![image](/pub-images/renrenfast架构.png)
![image](/pub-images/前后端分离项目集群.png)
![image](/pub-images/前后端分离项目部署图.png)

# 开发环境要求
软件：宿主机-Vmware虚拟机（CentOS／Ubuntu）-Docker虚拟机

# MySQL集群
单节点数据库无法满足性能上的要求及高可用冗余设计，大型互联网程序用户群体庞大，架构必须特殊设计，mysql常见集群方案：
![image](/pub-images/mysql常见集群方案.png)

## PXC方案原理
PXC（Percona XtraDB Cluster）：建议PXC使用PerconaServer（MySQL改进版，性能提升很大）
![image](/pub-images/pxc方案原理.png)
PXC数据强一致性：同步复制，事物在所有集群节点要么同时提交，要么不提交

## PXC集群搭建
网络准备：
~~~
docker network create --subnet=172.18.0.0/24 net1
docker network inspect net1 //查看网络详细信息
~~~
准备数据卷：
~~~
docker volume create --name v1
docker inspect v1   //查看volume在宿主机上的实际路径，方便后期做容器卷映射
docker volume create v2
docker volume create v3
docker volume create v4
docker volume create v5
docker volume create ‐‐name backup  //创建备份数据卷用于热备份数据
~~~
创建pxc容器：每个MySQL容器创建之后，因为要执行PXC的初始化和加入集群等工作，耐心等待1分钟左右再用客户 端连接MySQL。另外，必须第1个MySQL节点启动成功，用MySQL客户端能连接上之后，再去创建其他 MySQL节点。
~~~
docker pull percona/percona-xtradb-cluster
//创建第一个节点
docker run -d -p 3307:3306 -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=PXC -e XTRABACKUP_PASSWORD=root -v v1:/var/lib/mysql -v backup:/data --privileged --name=node1 --net=net1 --ip 172.18.0.2 percona/percona-xtradb-cluster
//创建第二个节点
docker run -d -p 3308:3306 -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=PXC -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 -v v2:/var/lib/mysql -v backup:/data --privileged --name=node2 --net=net1 --ip 172.18.0.3 percona/percona-xtradb-cluster
//创建第三个节点
docker run -d -p 3309:3306 -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=PXC -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 -v v3:/var/lib/mysql -v backup:/data --privileged --name=node3 --net=net1 --ip 172.18.0.4 percona/percona-xtradb-cluster
//创建第四个节点
docker run -d -p 3310:3306 -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=PXC -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 -v v4:/var/lib/mysql -v backup:/data --privileged --name=node4 --net=net1 --ip 172.18.0.5 percona/percona-xtradb-cluster
//创建第五个节点
docker run -d -p 3311:3306 -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=PXC -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node1 -v v5:/var/lib/mysql -v backup:/data --privileged --name=node5 --net=net1 --ip 172.18.0.6 percona/percona-xtradb-cluster
~~~
通过客户端测试数据库集群：
* 输入数据库ip为宿主机ip，端口为映射ip，如：3307、3308等连接不同节点
* 任意节点建库、建表测试是否同步 

## 数据库集群的负载均衡
![image](/pub-images/负载均衡中间件对比.png)
使用Haproxy做负载均衡，请求被均匀分发给每个节点，单节点负载低，性能好
![image](/pub-images/pxc负载均衡.png)

### haproxy使用
1. docker pull haproxy //获取haproxy系统镜像
2. 创建haproxy配置文件: sudo vim /media/psf/LinuxShare/data/conf/haproxy.cfg，更多配置查看：https://zhang.ge/5125.html
~~~
global
	#工作目录
	chroot /usr/local/etc/haproxy
	#日志文件，使用rsyslog服务中local5日志设备（/var/log/local5），等级info
	log 127.0.0.1 local5 info
	#守护进程运行
	daemon

defaults
	log	global
	mode	http
	#日志格式
	option	httplog
	#日志中不记录负载均衡的心跳检测记录
	option	dontlognull
    #连接超时（毫秒）
	timeout connect 5000
    #客户端超时（毫秒）
	timeout client  50000
	#服务器超时（毫秒）
    timeout server  50000

#监控界面	
listen  admin_stats
	#监控界面的访问的IP和端口
	bind  0.0.0.0:8888
	#访问协议
    mode        http
	#URI相对地址
    stats uri   /dbs
	#统计报告格式
    stats realm     Global\ statistics
	#登陆帐户信息
    stats auth  admin:admin
#数据库负载均衡
listen  proxy-mysql
	#访问的IP和端口
	bind  0.0.0.0:3306  
    #网络协议
	mode  tcp
	#负载均衡算法（轮询算法）
	#轮询算法：roundrobin
	#权重算法：static-rr
	#最少连接算法：leastconn
	#请求源IP算法：source 
    balance  roundrobin
	#日志格式
    option  tcplog
	#在MySQL中创建一个没有权限的haproxy用户，密码为空。Haproxy使用这个账户对MySQL数据库心跳检测
    option  mysql-check user haproxy
    server  MySQL_1 172.18.0.2:3306 check weight 1 maxconn 2000  
    server  MySQL_2 172.18.0.3:3306 check weight 1 maxconn 2000  
	server  MySQL_3 172.18.0.4:3306 check weight 1 maxconn 2000 
	server  MySQL_4 172.18.0.5:3306 check weight 1 maxconn 2000
	server  MySQL_5 172.18.0.6:3306 check weight 1 maxconn 2000
	#使用keepalive检测死链
    option  tcpka  
~~~
3. 创建haproxy容器
~~~
#创建第1个Haproxy负载均衡服务器
docker run -it -d -p 4001:8888 -p 4002:3306 -v /media/psf/LinuxShare/data/conf:/usr/local/etc/haproxy --name h1 --privileged --net=net1 --ip 172.18.0.10 haproxy

#创建第2个Haproxy负载均衡服务器
docker run -it -d -p 4003:8888 -p 4004:3306 -v /media/psf/LinuxShare/data/conf:/usr/local/etc/haproxy --name h2 --privileged --net=net1 --ip 172.18.0.11 haproxy
~~~
4. 创建数据库haproxy用户：create user 'haproxy'@'%' identified by '';
5. 启动haproxy
~~~
docker exec -it h1 bash
haproxy -f /usr/local/etc/haproxy/haproxy.cfg

docker exec -it h2 bash
haproxy -f /usr/local/etc/haproxy/haproxy.cfg
~~~
6. 浏览器访问：
浏览器访问地址：http://宿主机ip:4001/dbs
7. 数据库访问：
ip为宿主机ip，端口4002，见第三步
8. 测试节点宕机
* docker stop node1;查看浏览器，node1节点是否宕机
* 恢复node1节点:删除node1节点，重新以从节点方式创建node1即可
~~~
docker rm node1
docker run -d -p 3307:3306 -e MYSQL_ROOT_PASSWORD=root -e CLUSTER_NAME=PXC -e XTRABACKUP_PASSWORD=root -e CLUSTER_JOIN=node2 -v v1:/var/lib/mysql -v backup:/data --privileged --name=node1 --net=net1 --ip 172.18.0.2 percona/percona-xtradb-cluster
~~~

虚拟IP地址技术
### keepalived实现双机热备
![image](/pub-images/haproxy双机热备方案.png)
* Keepalived必须安装在haproxy容器内
~~~
docker exec -it h1 bash
apt-get update
apt-get install vim
apt-get install keepalived
vim /etc/keepalived/keepalived.conf
~~~
配置文件内容为：
~~~
vrrp_instance  VI_1 {
   state  MASTER
   interface  eth0
   virtual_router_id  51
   priority  100
   advert_int  1
   authentication {
       auth_type  PASS
       auth_pass  123456
   }
   virtual_ipaddress {
       172.18.0.201
  } 
} 
~~~


~~~
virtual_server 192.168.99.150 8888 {
  delay_loop 3
  lb_algo rr
  lb_kind NAT
  persistence_timeout 50
  protocol TCP
  real_server 172.18.0.201 8888 {
    weight 1
  } 
} 
virtual_server 192.168.99.150 3306 {
  delay_loop 3
  lb_algo rr
  lb_kind NAT
  persistence_timeout 50
  protocol TCP
  real_server 172.18.0.201 3306 {
    weight 1
  } 
} 
~~~

暂停PXC集群的办法
* 在/etc/sysctl.conf文件末尾添加：net.ipv4.ip_forward=1;重启网络服务：systectl restart network

## Replication方案原理
![image](/pub-images/replication方案.png)
Replication采用异步复制，单向同步，无法保证数据的一致性

参考文章：
* https://www.cnblogs.com/zhenyuyaodidiao/p/4635458.html
* https://www.cnblogs.com/clsn/p/8150036.html
 
--sql
stop slave;
show slave status; 
 
## PXC集群安装
MySQL集群（PXC）入门：https://www.imooc.com/learn/993

 
# Redis集群
高速缓存：利用内存保存数据，读写速度远超硬盘；减少I／O操作

## Redis集群方案
* RedisCluster：官方推荐，没有中心节点，客户端与redis节点直连，不需要中间代理层；数据可被分片存储；管理方便，后续可自行增删节点
* Codis：中间件产品，存在中心节点，360公司产品
* Twemproxy：中间件产品，存在中心节点
* Redis集群中应该包含奇数个Master，至少应该有3个Master
* Redis集群中每个Master都应该有Slave
![image](/pub-images/redis主从.png)
* redis集群不配置负载均衡是因为在前后端分离项目中Spring程序实现了负载均衡

## RedisCluster架构
![image](/pub-images/rediscluster.png)

## Redis主从同步
* Redis集群中的数据库复制是通过主从同步来实现的
* 主节点（Master）把数据分发给从节点（Slave）
* 主从同步的好处在于高可用，Redis节点有冗余设计

## RedisCluster集群搭建

网络准备：
~~~
docker network create --subnet=172.19.0.0/16 net2
~~~
镜像准备：
~~~
docker pull grokzen/redis-cluster
docker pull yyyyttttwwww/redis  //课程使用
~~~
容器创建：
~~~
docker run -it -d --name r1 -p 5001:6379 --net=net2 --ip 172.19.0.2 yyyyttttwwww/redis bash
docker run -it -d --name r2 -p 5002:6379 --net=net2 --ip 172.19.0.3 yyyyttttwwww/redis bash
docker run -it -d --name r3 -p 5003:6379 --net=net2 --ip 172.19.0.4 yyyyttttwwww/redis bash
docker run -it -d --name r4 -p 5004:6379 --net=net2 --ip 172.19.0.5 yyyyttttwwww/redis bash
docker run -it -d --name r5 -p 5005:6379 --net=net2 --ip 172.19.0.6 yyyyttttwwww/redis bash
docker run -it -d --name r6 -p 5006:6379 --net=net2 --ip 172.19.0.7 yyyyttttwwww/redis bash
~~~

配置redis配置文件：(默认关闭了redis集群功能)
~~~
//逐个进入容器，如：
docker exec -it  r1  bash
//逐个配置
daemonize yes   
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 15000
appendonly yes  //开启AOF日志模式    
~~~
逐个启动redis服务
~~~
/usr/redis/src/redis-server /usr/redis/redis.conf
//客户端连接测试,如：
./redis-cli -h 172.19.0.3 -p 6379 -c
~~~
通过redis-trib.rb(redis自带,需要ruby环境)创建集群
~~~
//进入任一容器，如：
docker exec -it  r1  bash
cd /usr/redis/
mkdir cluster
cp src/redis-trib.rb cluster/
cd cluster/
//创建集群，过程中确认请输入"yes"
./redis-trib.rb create --replicas 1 172.19.0.2:6379 172.19.0.3:6379 172.19.0.4:6379 172.19.0.5:6379 172.19.0.6:6379 172.19.0.7:6379
~~~
测试集群效果
~~~
//逐个任一容器，如：
docker exec -it  r1  bash
./redis-cli -c
cluster nodes   //查看集群节点信息
~~~

# Docker Compose
* Docker-Compose用于解决容器与容器之间如何管理编排的问题
* Dockerfile 可以让用户管理一个单独的应用容器；而 Compose 则允许用户在一个模板（YAML 格式）中定义一组相关联的应用容器（被称为一个 project，即项目），例如一个 Web 服务容器再加上后端的数据库服务容器等。

Compose 中有两个重要的概念
* 服务 (service) ：一个应用的容器，实际上可以包括若干运行相同镜像的容器实例
* 项目 (project) ：由一组关联的应用容器组成的一个完整业务单元，在 docker-compose.yml 文件中定义

## Docker Compose 安装
Docker Compose 是 Docker 的独立产品，需自行安装
~~~
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v
~~~

## 基本使用
* 启动服务：docker-compose up -d   //在后台启动服务
* 查看启动的服务:docker-compose ps
* 停止服务: docker-compose stop

## 常用命令
~~~
#查看帮助
docker-compose -h

# -f  指定使用的 Compose 模板文件，默认为 docker-compose.yml，可以多次指定。
docker-compose -f docker-compose.yml up -d 

#启动所有容器，-d 将会在后台启动并运行所有的容器
docker-compose up -d

#停用移除所有容器以及网络相关
docker-compose down

#查看服务容器的输出
docker-compose logs

#列出项目中目前的所有容器
docker-compose ps

#构建（重新构建）项目中的服务容器。服务容器一旦构建后，将会带上一个标记名，例如对于 web 项目中的一个 db 容器，可能是 web_db。可以随时在项目目录下运行 docker-compose build 来重新构建服务
docker-compose build

#拉取服务依赖的镜像
docker-compose pull

#重启项目中的服务
docker-compose restart

#删除所有（停止状态的）服务容器。推荐先执行 docker-compose stop 命令来停止容器。
docker-compose rm 

#在指定服务上执行一个命令。
docker-compose run ubuntu ping docker.com

#设置指定服务运行的容器个数。通过 service=num 的参数来设置数量
docker-compose scale web=3 db=2

#启动已经存在的服务容器。
docker-compose start

#停止已经处于运行状态的容器，但不删除它。通过 docker-compose start 可以再次启动这些容器。
docker-compose stop
~~~

# Docker Swarm

# 课后作业

# 源码解析
https://www.jianshu.com/p/259d35eef3f1