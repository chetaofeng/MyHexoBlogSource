---
title: docker入门
tags:
  - docker
copyright: true
comments: true
toc: true
date: 2018-10-18 09:38:59
categories: docker
password:
---

# 简介
* 官网：https://www.docker.com/
* 中文社区：http://www.docker.org.cn/
* docker尝鲜：https://labs.play-with-docker.com/

docker虚拟机架构
![image](/pub-images/docker架构.png)

docker管理常用指令
![image](/pub-images/docker虚拟机管理指令.png)

* Docker版本分为两个：Docker Community Edition (CE)和 Docker Enterprise Edition (EE)。
* Docker是基于CS架构，系统有两个程序：docker服务端和docker客户端，是一种Linux容器管理技术 
* docker服务端是一个服务进程，管理着所有的容器;docker客户端则扮演着docker服务端的远程控制器，可以用来控制docker的服务端进程。
* 大部分情况下，docker服务端和客户端运行在一台机器上。
* Docker为容器引入了镜像，使得容器可以从预先定义好的模版（images）创建出来，并且这个模版还是分层的
* Docker容器通过镜像启动，是镜像的启动和执行阶段，采用写时复制（copy on write）

云计算中的Docker虚拟机
![image](/pub-images/云计算中的Docker虚拟机.png)

# Docker全家桶
![image](/pub-images/docker全家桶.png)

# Docker容器的能力
1. 文件系统隔离：每个容器都有自己的root文件系统
2. 进程隔离：每个容器都运行在自己的进程环境中
3. 网络隔离：容器间的虚拟网络接口和IP地址都是分开的
4. 资源隔离和分组：使用cgroups将CPU和内存之类的资源独立分配给每个Docker容器

* docker Client客户端————>向docker服务器进程发起请求，如:创建、停止、销毁容器等操作
* docker Server服务器进程—–>处理所有docker的请求，管理所有容器
* docker Registry镜像仓库——>镜像存放的中央仓库，可看作是存放二进制的软件配置管理（scm）

# docker安装
https://docs.docker.com/install/linux/docker-ce/ubuntu/

CentOS系统
~~~
yum -y update
yum -y install docker
service docker start|stop|restart
~~~

Ubuntu系统
~~~
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
~~~

macOS
~~~
brew cask install docker
~~~

下载安装完成之后docker version查看

# 免sudo使用docker命令
参考自网络：https://www.jianshu.com/p/95e397570896
~~~
sudo groupadd docker
sudo gpasswd -a ${USER} docker
sudo service docker restart
newgrp - docker
~~~

# docker加速器配置
* docker国内镜像仓库设置，官网：https://www.daocloud.io/
* 配置加速：https://www.daocloud.io/mirror
~~~
sudo curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://f1361db2.m.daocloud.io
~~~
检查文件cat /etc/docker/daemon.json ，确保格式正确，无多余逗号，有则删除,如：
~~~
{"registry-mirrors": ["http://f1361db2.m.daocloud.io"]}
~~~

# docker虚拟机安装java
* docker search java  #查找java镜像，如选择使用name为java的镜像
* docker pull java 

导出导入镜像
~~~
docker save java > /home/java.tar.gz    //save后面跟的是镜像的名称
docker load < /home/java.tar.gz
docker images
docker rmi
~~~

exit推出交互界面后也停止了容器，重新进入：docker start -i java


docker提供了一个开发，打包，运行app的平台，把app和底层infratructure隔离开来

docker底层技术支持,依赖于Linux内核特性Namespaces和Cgroups
Namespaces：做隔离pid，net，ipc，mnt，uts
Control Groups：做资源限制
Union file Systems：Container和image的分层

namespace，容器隔离的基础，保证A容器看不到B容器. 6个名空间：User,Mnt,Network,UTS,IPC,Pid
cgroups，容器资源统计和隔离。主要用到的cgroups子系统：cpu,blkio,device,freezer,memory
unionfs，典型：aufs/overlayfs，分层镜像实现的基础

# docker镜像与容器
![image](/pub-images/容器与镜像.png)

* docker image：是容器的基石，本身为层叠的只读文件系统，
docker通过联合加载技术一次加载多个文件系统，从外部看，只能看到一个文件系统，包含所有文件系统的文件和目录。bootfs-rootfs(如：ubuntu)-apache。。。，rootfs称为基础镜像
文件和meta data的集合（root filesystem）
分层的，并且每一层都可以添加改变删除文件，成为一个新的image
不同的image可以共享x相同的layer
image本身是read-only的
sudo docker image ls
docker history [imageID] 

## image的获取
1. 通过Dockerfile
2. 从Registry获取，如：docker pull ubuntu:14.04，https://hub.docker.com/
3. 命令行的格式为：docker search 镜像名字

## Container
docker容器可以理解为在沙盒中运行的进程。这个沙盒包含了该进程运行所必须的资源，包括文件系统、系统类库、shell 环境等等。但这个沙盒默认是不会运行任何程序的。你需要在沙盒中运行一个进程来启动某一个容器。这个进程是该容器的唯一进程，所以当该进程结束的时候，容器也会完全的停止。

通过Image创建
在Image Layer之上建立一个container layer（可读写）
类比面向对象：类和实例
Image负责app的存储和分发，Container负责运行app
container id只要能够区分出来就行，不用全部输入
docker container ls //运行的
docker container ls -a  //所有的，包括退出的和正在运行的

docker run命令有两个参数，一个是镜像名，一个是要在镜像中运行的命令。

docker run [name]   //运行container
docker run -it [name]   //交互式运行container

命令简写
docker container ls -a  == docker ps -a
docker container rm [conatinerID] == docker rm [conatinerID]
docker image ls == docker images
docker image rm [imageID] == docker rmi [imageID]

docker container ls -aq //列出所有conatinerID

构建自己的docker镜像
docker commit [containerName] [dockerhubID/imageNewName]


容器的操作
//对容器执行命令
docker exec  
docker exec -it [containerID] /bin/bash
docker inspect [imageName] //查看
docker logs [containerID]

# 通过Dockerfile创建
1. 新建空文件夹
2. 创建Dockerfile文件 
~~~
FROM [BaseImageName]    //如果没有则值为scratch
RUN yum install -y vim
~~~
3. docker build -t [dockerhubID/imageNewName] .   //.表示当前目录中查找Dockerfile
4. docker image ls查看

# Dockerfile语法梳理及最佳实践
1. FROM:尽量使用官方的iamge作为base image
2. LABEL:Metadata不可少，让大家了解到image的信息，相当于image的注释
3. RUN:为了美观，复杂的RUN请用反斜线换行，避免无用分层，合并多条命令成一行
4. WORKDIR:设定当前工作目录，如果没有则会自动创建目录；用WORKDIR，不要用RUN cd，尽量使用绝对目录
5. ADD和COPY：把本地文件（构建目录中的相对地址 ）添加到image里面，同时ADD添加的文件如果是压缩文件的话，会自动解压缩，大部分情况COPY优于ADD，添加远程文件／目录请使用crul或wget；目标路径需指定docker中的绝对路径
6. ENV：设置环境变量，尽量使用ENV增加可维护性

https://github.com/docker-library/

~~~
MAINTAINER：指定容器的相关维护信息，维护人、邮箱等
RUN：执行命令并创建新的Image Layer，是在容器构建时执行
CMD：设置容器启动后默认执行的命令和参数，是在容器运行时运行的.如果docker run指定了其他命令，CMD命令被忽略；如果定义了多个CMD，只会执行最后一个；也可以只提供参数，作为ENTRYPOINT的默认参数
ENTRYPOINT：设置容器启动时运行的命令，让容器以应用程序或者服务的形式执行；不会被忽略，一定会执行；最佳实践是写一个shell脚本作为entrypoint
EXPOSE：指定运行该镜像的容器使用的端口，但此端口并未自动打开，在使用的时候需要映射／设置端口 
VOLUME：用来向基于镜像创建的容器，一个卷是可以存在于一个或多个容器的特定目录，这个目录可以绕过联合文件系统提供共享数据、数据持久化功能
WORKDIR：用于在容器内部设置工作目录，一般使用绝对路径，如果使用相对路径，路径会一致传递下去
USER：用来指定镜像被什么用户去运行，如果不设置，默认为root用户
ONBUILD：用来为镜像添加触发器，当一个镜像被其他镜像作为基础镜像执行时，此触发器会被执行
~~~

# 使用中间层镜像进行调试，查找错误
docker build命令只删除了中间层常见的容器，但是没有删除中间层创建的镜像

构建缓存：构建过程中会产生缓存，下次构建直接使用缓存镜像，如果不想使用构建缓存，则可通过：docker build --no-cache,或者通过dockerfile文件的ENV REFRESH_DATE修改日期，则本条语句后就不使用缓存了

docker history 镜像，用来查看镜像的构建过程
~~~
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh "]
~~~
shell格式和EXEC格式 
~~~ shell格式  
RUN apt-get install -y vim
CMD echo "Hello Docker"
ENTRYPOINT echo "Hello Docker"
~~~

~~~ exec格式
RUN ["apt-get","install","-y","vim"]
CMD ["/bin/echo", "Hello Docker"]
ENTRYPOINT ["/bin/echo", "Hello Docker"]
~~~

# 登录dockerhub
docker login:  用户名（非邮箱）／密码
1. 本地push上去，其他人就可以pull
2. 关联github，github管理Dockerfile，有修改后自动build。Create-Create Automated build
3. 通过docker的registry本地自己搭建。https://hub.docker.com/_/registry/,后期学习


# Dockerfile实战
Dockerfile是docker构建镜像的基础，也是docker区别于其他容器的重要特征，正是有了Dockerfile，docker的自动化和可移植性才成为可能。
不论是开发还是运维，学会编写Dockerfile几乎是必备的



# Docker常见命令
~~~
容器相关操作
docker create # 创建一个容器但是不启动它
docker run # 创建并启动一个容器
docker stop # 停止容器运行，发送信号SIGTERM
docker start # 启动一个停止状态的容器
docker restart # 重启一个容器
docker rm # 删除一个容器
docker kill # 发送信号给容器，默认SIGKILL
docker attach # 连接(进入)到一个正在运行的容器
docker wait # 阻塞到一个容器，直到容器停止运行
获取容器相关信息
docker ps # 显示状态为运行（Up）的容器
docker ps -a # 显示所有容器,包括运行中（Up）的和退出的(Exited)
docker inspect # 深入容器内部获取容器所有信息
docker logs # 查看容器的日志(stdout/stderr)
docker events # 得到docker服务器的实时的事件
docker port # 显示容器的端口映射
docker top # 显示容器的进程信息
docker diff # 显示容器文件系统的前后变化
导出容器
docker cp # 从容器里向外拷贝文件或目录
docker export # 将容器整个文件系统导出为一个tar包，不带layers、tag等信息
执行
docker exec # 在容器里执行一个命令，可以执行bash进入交互式
镜像操作
docker images # 显示本地所有的镜像列表
docker import # 从一个tar包创建一个镜像，往往和export结合使用
docker build # 使用Dockerfile创建镜像（推荐）
docker commit # 从容器创建镜像
docker rmi # 删除一个镜像
docker load # 从一个tar包创建一个镜像，和save配合使用
docker save # 将一个镜像保存为一个tar包，带layers和tag信息
docker history # 显示生成一个镜像的历史命令
docker tag # 为镜像起一个别名
镜像仓库(registry)操作
docker login # 登录到一个registry
docker search # 从registry仓库搜索镜像
docker pull # 从仓库下载镜像到本地
docker push # 将一个镜像push到registry仓库中  

docker system df    //查看镜像、容器、数据卷所占用的空间
docker commit -m "ubuntu with vim" -a "sgy" aa97ba3292ce sgy/ubuntu:vim
~~~

 
 

https://www.ghostcloud.cn/


服务器虚拟化 （vsphere  cas  ZStack不通厂家命名）：裸机虚拟化、半裸机虚拟化
网络虚拟化 SDN
存储虚拟化 VSAN   服务器做raid保证系统安全，然后做存储虚拟化

Mac 上的 Docker 背后应该是一个 Linux 虚机，和 Windows 版本的 Docker 是一样的原理

容器一旦被直接推出，之前安装的gcc啊vim啊啥的就会全部gg掉。如果要保存修改，就需要将当前容器封装成一个新的镜像，这样下次启动这个新的镜像后之前作出的修改还都在。

容器不适合构建那种发布周期以周或月为单位的大型单一架构企业软件，容器适合采用微服务的方式，以及探索诸如持续部署这样的技术，使得我们能安全地在一天内多次更新生产环境。

https://blog.csdn.net/xdy3008/article/details/74531125

https://www.missshi.cn/api/view/blog/5a6327c00a745f6335000004 


想看到docker容器的ip地址，只需要安装net-tools就可以了：yum install net-tools -y





如果你仅仅是想管理虚拟机，那么你应该使用vagrant。如果你想快速开发和部署应用，那么应该使用docker。
vagrant是一款管理虚拟机的工具，而docker是一款通过将应用打包到轻量级容器，而实现构建和部署的工具。两者适用范围不同。一个容器就是一个包含了应用执行所依赖的数据(包括lib，配置文件等等)。它可以保证应用在一个可重复的环境中随时执行。



数据卷：是经过特殊设计的目录，可以绕过联合文件系统ufs，为一个或多个容其提供访问。让你可以不受容器生命周期影响进行数据持久化。它们表现为容器内的空间，但实际保存在容器之外，从而允许你在不影响数据的情况下销毁、重建、修改、丢弃容器。
Docker允许你定义应用部分和数据部分，并提供工具让你将他们分开。容器是短暂和一次性的。
docker run -v ~/container_data:/data:ro -it centos,映射本地~/container_data到容器/data下,且/data的权限为ro只读，登录进去后ls查看，发现会有data目录

数据卷容器：命名的容器挂载数据卷，其他容器通过挂载这个容器实现数据共享，挂载数据卷的容器，就叫做数据卷容器。
docker run --volumes-from 数据卷容器名称
即使删除了数据卷容器，挂载了数据卷容器的容器，仍然可以访问数据卷容器的目录，数据卷容器起的作用仅仅是将挂载配置传递到待挂载容器

Docker数据卷的备份与还原：通过挂载目录压缩后放到挂载目录

Docker For Mac的Docker Daemon是运行于虚拟机(xhyve)中的, 而不是像Linux上那样作为进程运行于宿主机，因此Docker For Mac没有docker0网桥，不能实现host网络模式，host模式会使Container复用Daemon的网络栈(在xhyve虚拟机中)，而不是与Host主机网络栈，这样虽然其它容器仍然可通过xhyve网络栈进行交互，但却不是用的Host上的端口(在Host上无法访问)。bridge网络模式 -p 参数不受此影响，它能正常打开Host上的端口并映射到Container的对应Port。

# docker容器的网络连接
![image](/pub-images/docker网络.png)
docker0：是Linux的虚拟网桥（网桥是数据链路层的一种设备），Linux的虚拟网桥可以设置IP地址，相当于拥有一个隐藏的虚拟网卡
docker0地址划分：IP127.17.42.1,掩码255.255.0.0,总共提供了65534个地址
网桥操作需安装bridge-utils工具，安装之后brctl show查看网桥信息，可以添加网桥或者配置网桥信息
docker容器的IP地址在重启容器之后会变化，是不可靠的

容器互联：在同一宿主机下，docker容器是通过虚拟网桥互相连接的，默认在同一宿主机下docker允许所有容器互联。让容器之间可以相互连接主要借用了一个link的功能。 在使用纯Docker时，被连接的容器必须在同一个Docker宿主机中。不同宿主机之间的容器如果想要连接，则需要借助Swarm或Kubernetes等编排工具。
--link:链接容器，docker run -it --name cct3 --link=cct1:webtest bitchofgod/testnet （webtest为cct1的别名），然后在cct3中ping webtest即可互联
Docker在父容器中的以下两个地方写入了连接信息：
/etc/hosts文件中，--link在此文件中写入了映射信息，当docker重新启动的时候，docker会自动维护此文件中的映射 
包含连接信息的环境变量中 
如果拒绝所有容器互联，则修改docker配置，在/ect/default/docker文件中添加DOCKER_OPTS=" --icc=false"后重启docker服务即可
如果需要特定容器互联，则通过--link、--icc=false、--iptables=true来实现

docker容器与外部网络的连接
ipforward
iptables

Ctrl+p，Ctrl+q退出交互界面
docker attach containerName重新打开交互界面

CaaS(Container as a Service):镜像容器托管
从Docker到Caas
容器集群管理工具
容器调度
配置管理
服务发现 
日志／监控／报警

LaaS（基础设施） 出租计算、存储、网络、DNS等基础IT服务
PaaS（基础设施+系统平台—应用服务器应用框架 编程语言） 提供应用运行和开发环境 提供应用开发组件（邮件、消息、计费、支付）
SaaS （基础设施+系统平台+软件应用）互联网Web2.0应用 企业应用（ERP/CRM等）


通俗点讲
SaaS：软件即服务，简单来说就是把企业想要的功能开发好成应用软件，然后直接卖给用户使用。通俗点讲就是去饭店吃饭一样，什么都是店家的。
PaaS：平台即服务，简单来说就是云计算平台提供硬件、编程语言、开发库等帮助用户更好更快的开发软件。通俗来说就是点外卖，使用时店家的，但是餐桌是自己的。
IaaS：基础设施即服务，简单来说就是云服务商提供企业所需要的服务器、存储、网络给企业用。通俗来说就是买菜买面，回家自己做饭。


https://blog.csdn.net/weixin_38003389/article/details/84025762

Docker Machine：目的是简化 Docker 的安装和远程管理,是官方提供的一个工具。 
先创建Docker Machine机器

Docker Compose：Docker Compose 是 Docker 官方编排（Orchestration）项目之一，负责快速在集群中部署分布式应用。
Docker Compose允许用户通过一个单独的 docker-compose.yml 模板文件（YAML 格式）来定义一组相关联的应用容器为一个项目（project）
Compose 中有两个重要的概念：
项目 ( project )：由一组关联的应用容器组成的一个完整业务单元，在 dockercompose.yml 文件中定义。
服务 ( service )：一个应用的容器，实际上可以包括若干运行相同镜像的容器实例
运行 compose 项目：docker-compose up

# Docker Compose命令集
Docker Compose 是一个在单个服务器或主机上创建多个容器的工具，而 Docker Swarm 则可以在多个服务器或主机上创建容器集群服务，对于微服务的部署，显然 Docker Swarm 会更加适合

~~~
管理镜像：build/pull
管理服务：up/start/stop/kill/rm/scale
服务状态：ps/logs/port
一次性服务：run
~~~

https://www.jianshu.com/p/658911a8cff3

Docker Swarm:Docker集群管理工具，支持标准的Docker API,其主要作用是把若干台Docker主机抽象为一个整体，并且通过一个入口统一管理这些Docker主机上的各种Docker资源。
Swarm和Kubernetes比较类似，但是更加轻，具有的功能也较kubernetes更少一些。



# 三大主流调度框架
Swarm、Kubernetes和Mesos
 

# 参考文章
* http://www.cnblogs.com/SzeCheng/p/6822905.html
