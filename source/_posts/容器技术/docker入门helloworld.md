---
title: docker入门之Hello World
tags:
  - docker
copyright: true
comments: true
toc: true
date: 2019-01-18 09:38:59
categories: docker
password:
---

# docker 版本HelloWorld
安装好docker后执行如下命令：
* docker serach hello-world
* docker pull hello-world
* docker run hello-world

# docker镜像原理
![image](/pub-images/镜像原理.png)

# docker web版本HelloWorld
* docker pull nginx
* docker run -d -p 8080:80 nginx
* 浏览器访问：http://localhost:8080/

# 自我制作镜像
## Dockerfile方式
1. 下载war包，作为镜像制作项目： https://gitee.com/GalaIO/jpress/blob/master/wars/jpress-web-newest.war
2. docker pull tomcat   //准备war项目的容器
3. 创建空目录:cd /media/psf/LinuxShare/data;sudo mkdir myDocker;cd myDocker;
4. sudo cp /media/psf/LinuxShare/soft/jpress-web-newest.war /media/psf/LinuxShare/data/myDocker/
5. 创建Dockerfile文件，sudo vim myDocker;编辑内容如下：
~~~
from tomcat

MAINTAINER xingfeng1024 xingfeng1024@163.com

COPY jpress-web-newest.war /usr/local/tomcat/webapps
~~~
6. 构建镜像：docker build -t mydocker/jpress:latest .
7. docker images查看镜像
8. docker run -d -p 8888:8080 mydocker/jpress
9. 浏览器：http://localhost:8888/jpress-web-newest 查看效果

## 打包方式
1. 在以上镜像基础上，进入镜像：docker exec -it mydocker/jpress bash
2. apt-get install vim
3. vim readme.md;  随便输入内容保存即可
4. 退出容器：Ctrl+P，Ctrl+Q
5. 制作镜像：docker commit f8ed84a63e94 mydocker/jpress-vim  //f8ed84a63e94为容器ID
6. docker images查看最新制作镜像，创建容器运行后进入发现有了vim功能

