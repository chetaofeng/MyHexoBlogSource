---
title: CentOS修改Root密码
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

# scp简介
scp是secure copy的简写，用于在Linux下进行远程拷贝文件的命令，和它类似的命令有cp，不过cp只是在本机进行拷贝不能跨服务器，而且scp传输是加密的。可能会稍微影响一下速度。

# scp作用说明
1. 我们需要获得远程服务器上的某个文件，远程服务器既没有配置ftp服务器，没有开启web服务器，也没有做共享，无法通过常规途径获得文件时，只需要通过scp命令便可轻松的达到目的
2. 我们需要将本机上的文件上传到远程服务器上，远程服务器没有开启ftp服务器或共享，无法通过常规途径上传是，只需要通过scp命令便可以轻松的达到目的。

# 使用举例
~~~
#将本地文件拷贝到服务器上
scp -rp /path/filename username@remoteIP:/path 
#将远程文件从服务器下载到本地
scp -rp username@remoteIP:/path/filename /path 

#压缩传输
tar cvzf - /path/ | ssh username@remoteip "cd /some/path/; cat -> path.tar.gz" 
#压缩传输一个目录并解压
tar cvzf - /path/ | ssh username@remoteip "cd /some/path/; tar xvzf -" 
~~~

# 脚本方式举例
~~~
#!/bin/bash  
ssh root@192.168.0.23   << remotessh  
killall -9 java  
cd /data/apache-tomcat-7.0.53/webapps/  
exit  
remotessh  
~~~
远程执行的内容在“<< remotessh ” 至“ remotessh ”之间，在远程机器上的操作就位于其中，注意的点：<< remotessh，ssh后直到遇到remotessh这样的内容结束，remotessh可以随便修改成其他形式。在结束前，加exit退出远程节点

# 参数
* -v 和大多数 linux 命令中的 -v 意思一样 , 用来显示进度 . 可以用来查看连接 , 认证 , 或是配置错误
* -C 使能压缩选项
* -4 强行使用 IPV4 地址
* -6 强行使用 IPV6 地址