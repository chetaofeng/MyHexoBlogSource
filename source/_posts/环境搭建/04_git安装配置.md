---
title: git安装配置
tags:
  - git
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: 环境搭建
password:
---

# 简介
官网：https://git-scm.com/
Git是一个开源的分布式版本控制系统，用于敏捷高效地处理任何或小或大的项目。
Git 是 Linus Torvalds 为了帮助管理 Linux 内核开发而开发的一个开放源码的版本控制软件。
Git 与常用的版本控制工具 CVS, Subversion 等不同，它采用了分布式版本库的方式，不必服务器端软件支持。

详细学习，推荐：
* http://www.runoob.com/git/git-tutorial.html
* 廖雪峰大神的git教程
https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000
* git的前世今生： https://blog.csdn.net/csdnprogram/article/details/52155078

# 工作原理
## 本地
* 工作区（Working Directory）：就是你在电脑里能看到的目录
* 版本库（Repository）：工作区有一个隐藏目录.git，这个不算工作区，而是Git的版本库
Git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区，还有Git为我们自动创建的第一个分支master，以及指向master的一个指针叫HEAD。

![image](/pub-images/git.png)
我们把文件往Git版本库里添加的时候，是分两步执行的：
* 第一步是用git add把文件添加进去，实际上就是把文件修改添加到暂存区；
* 第二步是用git commit提交更改，实际上就是把暂存区的所有内容提交到当前分支。

## 远程配合
![image](/pub-images/git2.png)

# git安装
参考教程：https://git-scm.com/book/zh/v2/%E8%B5%B7%E6%AD%A5-%E5%AE%89%E8%A3%85-Git

各平台都支持安装包安装方式

## mac系统
~~~
> brew install git
> git --version //验证安装
~~~

# git全局设置
config 配置有system级别 global（用户级别） 和local（当前仓库）三个 设置先从system-》global-》local,底层配置会覆盖顶层配置 
查看git不同级别配置信息
~~~
git config --system --list
git config --global --list
git config --和local --list
~~~

git安装完成后，还需要最后一步设置，在命令行输入：

~~~
$ git config --global user.name "Your Name"
$ git config --global user.email "email@example.com"
~~~
因为Git是分布式版本控制系统，所以，每个机器都必须自报家门

# git账号关联流程
1. 生成SSHkey
ssh-keygen命令用于为“ssh”生成、管理和转换认证密钥，它支持RSA和DSA两种认证密钥.
ssh-keygen(选项)
~~~
-b：指定密钥长度； 
-e：读取openssh的私钥或者公钥文件； 
-C：添加注释； 
-f：指定用来保存密钥的文件名； 
-i：读取未加密的ssh-v2兼容的私钥/公钥文件，然后在标准输出设备上显示openssh兼容的私钥/公钥； 
-l：显示公钥文件的指纹数据； 
-N：提供一个新密语； 
-P：提供（旧）密语；
-q：静默模式； 
-t：指定要创建的密钥类型。
~~~
2. 登陆git服务器，添加public key信息
3. 测试登陆
~~~
测试是否成功,第一此输入命令，需输入yes后再次输入测试命令后出现类似"Hi..."，表示配置成功
> ssh -T git@github.com
> ssh -T git@gitee.com
> ssh -T git@gitlab.com
~~~

# git单账号关联
~~~
> ssh-keygen -t rsa -C xxxxx@gmail.com（注册github时的email）
> cat ~/.ssh/id_rsa.pub
~~~
登陆网站，如github／gitee／gitlab等，在如设置／Settings中有SSH and GPG keys中【add new keys】，将id_rsa.pub内容添加，会自动识别标题,设置完成之后测试登陆


# git多账号设置关联
多账号配置是通过.ssh文件夹下config文件实现，操作如下：
~~~
> touch ~/.ssh/config 
> chmod 600 ~/.ssh/config 

> ssh-keygen -f ~/.ssh/id_rsa.github -t rsa -C "chetaofeng@163.com"
> ssh-keygen -f ~/.ssh/id_rsa.gitee -t rsa -C "chetaofeng@163.com"
> ssh-keygen -f ~/.ssh/id_rsa.gitlab -t rsa -C "chetaofeng@163.com"
~~~

config文件内容如下：
~~~
# github
Host github.com
    HostName github.com
    PreferredAuthentications publickey
    IdentityFile ~/.ssh/id_rsa.github

# gitee
Host gitee.com
     HostName gitee.com
     PreferredAuthentications publickey
     IdentityFile ~/.ssh/id_rsa.gitee

# gitlab
Host gitlab.com
     HostName gitlab.com
     PreferredAuthentications publickey
     IdentityFile ~/.ssh/id_rsa.gitlab
~~~
* Host： 是我们在输入命令的时候的名字 比如我这里是lab  那么我使用ssh命令的时候需要使用 ssh lab 
* HostName： 是目标主机的主机名，也就是平时我们使用ssh后面跟的地址名称。
* Port：指定的端口号。
* User：指定的登陆用户名。
* IdentifyFile：指定的私钥地址。
 
# .gitignore文件
不添加到版本库的内容记录，创建项目后一定要添加.gitignore文件

# 开发环境中配置
在Jetbrains系列开发工具中，【Version Control】界面中github选项默认有，进行设置即可
![image](/pub-images/github设置.png)
gitlab／gitee没有配置选项，需先安装相应插件，如下：
![image](/pub-images/插件安装.png)

以前配置gitlab的时候，是通过Other Settings->GitLab Settings设置如下：
* GitLab Server Url: https://gitlab.com/
* GitLab API Key： https://gitlab.com/profile/account


# git项目权限管理
Git项目一般有五种身份权限，分别是：
* Owner 项目所有者，拥有所有的操作权限
* Master 项目的管理者，除更改、删除项目元信息外其它操作均可
* Developer 项目的开发人员，做一些开发工作，对受保护内容无权限
* Reporter 项目的报告者，只有项目的读权限，可以创建代码片断
* Guest 项目的游客，只能提交问题和评论内容

# 私服项目使用推荐流程
> 以下为项目owner需进行工作
1. 在私服先创建项目，添加人员并设置人员权限
2. 在本地webstorm中clone项目
3. 在clone项目中添加.gitignore文件
4. 添加.gitignore及相关需要版本控制的文件夹到版本控制（选中项后右键操作）
5. 提交项目并备注为初始提交

> 以下为项目成员需做工作
1. 在本地webstorm中clone项目
2. 创建项目分支（可一人一个，也可通过项目模块进行分支创建），如果直接在master分支，则无法成功push项目提示被rejected
3. 进行代码编写
4. 提交需管理分支
5. 在gitlab私服网页发起合并请求，并添加详细描述
6. 等待相关人员进行合并
7. 合并结束后更新master分支
8. 创建分支继续工作