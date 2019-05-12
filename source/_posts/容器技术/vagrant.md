---
title: vagrant
tags:
  - vagrant
copyright: true
comments: true
toc: true
date: 2018-10-18 09:38:59
categories: docker
password:
---
 
# 简介
Vagrant是一个基于Ruby的工具，用于创建和部署虚拟化开发环境。它使用Oracle的开源VirtualBox虚拟化系统，使用 Chef创建自动化虚拟环境。

* https://www.vagrantup.com/
* https://www.virtualbox.org/
* https://app.vagrantup.com/boxes/search

* 入门：https://www.vagrantup.com/intro/getting-started/index.html
* 官方文档：https://www.vagrantup.com/docs/index.html

(1)开发环境快速部署 (2)开发环境更迭

#Vagrant的主要概念
* Provider:指的是为Vagrant提供虚拟化支持的具体软件，比如vmware或virtual box。
* Box:代表虚拟机镜像。Vagrant根据Porvider的不同提供了很多的基础镜像（通过url从s3上获取），用户可以根据自己的需求使用vagrant package制作属于自己的box。
* Project:一个目录和目录中的Vagrantfile就组成了vagrant的一个项目，项目下可以有子项目，子项目中的Vagrantfile配置将继承和重写父项目的配置。项目的虚拟机实例并不会存储在这个目录（存储在~/.vagrant.d/box下），所以可以通过git等版本管理工具来管理项目。
* Vagrantfile:Vagrant的配置文件，使用Ruby的语法描述。里面定义了项目所使用的box，网络，共享目录，provision脚本等。当vagrant up命令运行时，将读取当前目录的Vagrantfile。
* Provisioning:指的是虚拟机实例启动后，所需要完成的基础配置工作，比如说安装LAMP服务等。Vagrant支持使用shell，puppet，chef来完成provisioning工作。
* Plugin:Vagrant提供了插件机制，可以很好的扩展对宿主机OS, GuestOS，Provider，Provisioner的支持，比如vagrant的aws和openstack支持都是通过plugin来实现的。

# 初始化第一个系统
~~~
mkdir centos7
cd centos7
vagrant init centos/7
vagrant up
vagrant ssh
sudo yum update
exit
vagrant status
vagrant halt
vagrant destroy 
~~~
centos7默认账号／密码：vagrant/vagrant root/vagrant

# 常用命令
~~~
Usage: vagrant [options] <command> [<args>]

    -v, --version                    Print the version and exit.
    -h, --help                       Print this help.

Common commands:
     box             manages boxes: installation, removal, etc.
     cloud           manages everything related to Vagrant Cloud
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login           
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     upload          upload to machine via communicator
     validate        validates the Vagrantfile
     version         prints current and latest Vagrant version
     winrm           executes commands on a machine via WinRM
     winrm-config    outputs WinRM configuration to connect to the machine
~~~

~~~
vagrant box add "boxIdentity" remoteUrlorLocalFile 添加box
vagrant init "boxIdentity" 初始化box
vagrant up 启动虚拟机
vagrant ssh 登录虚拟机
vagrant box list 显示当前已添加的box列表
vagrant box remove "boxIdentity" 删除box
vagrant destroy 停止当前正在运行的虚拟机并销毁所有创建的资源
vagrant halt 关闭虚拟机
vagrant package 打包当前运行的虚拟机的环境
vagrant plugin 用于安装卸载插件
vagrant reload 重启虚拟机，主要用于重新载入配置文件
vagrant suspend 挂起虚拟机
vagrant resume 恢复挂起状态
vagrant ssh-config 输出ssh连接信息
vagrant status 输出当前虚拟机的状态
~~~ 

# Vagrantfile配置文件详解
* Vagrantfile 主要包括三个方面的配置，虚拟机的配置、SSH配置、Vagrant 的一些基础配置
* Vagrant 是使用 Ruby 开发的，所以它的配置语法也是 Ruby 的
* 修改完配置后需要执行 vagrant reload 重启 VM 使其配置生效

## 配置基本说明
~~~
Vagrant.configure("2") do |config|
    # ...
end
~~~
configure("2")描述的是使用Vagrant 2.0.x配置方式。

## box设置
~~~
config.vm.box = "centos/7"
~~~
配置Vagrant要去启用哪个box作为系统,默认名称为base

## 网络设置
Vagrant有两种方式进行网络连接.
* host-only主机模式，意思是主机与虚拟机之间的网络互访。其他人访问不到你的虚拟机。
* bridge桥接模式，此模式下VM如同局域网中的一台独立的直接虚拟机，可以被其他机器访问。
~~~
config.vm.network: private_network, ip: "11.11.11.11"
~~~
这里设置为host-only模式，且虚拟机ip设置为"11.11.11.11" 

## hostname设置
~~~
config.vm.hostname = "go-app"
~~~
host用于识别虚拟主机。特别在有多台虚拟机时，务必进行设置

## 同步目录
默认下，vagrant 共享的是你的项目目录（就是有vagrantfile文件的）,除了默认的/vagrant同步目录外，还可以设置额外的同步目录:
~~~
config.vm.synced_folder "d:/local/dir", "/vm/dir/"
~~~
第一个参数是本地目录，第二个参数为虚拟机目录。

## 端口转发
~~~
config.vm.network: forwarded_port, guest: 80, host: 8080
~~~
设置将主机上的8080端口forward到虚拟机的80端口上

# 单机配置
* 新建bootstrap.sh 文件
~~~
#!/usr/bin/env bash
apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
     rm -rf /var/www
     ln -fs /vagrant /var/www
fi
~~~

* 在Vagrantfile 中添加配置
~~~
Vagrant.configure("2") do |config|
      config.vm.box = "hashicorp/precise64"
      config.vm.provision :shell, path: "bootstrap.sh"
      config.vm.network :forwarded_port, guest: 80, host: 4567
end
~~~
* 启动：vagrant up
* 验证：在浏览器上：http://127.0.0.1:4567

# 配置多台虚拟机
Vagrant支持单机启动多台虚拟机，支持一个配置文件启动多台。
~~~
Vagrant.configure("2") do |config|
    config.vm.define :web do |web|
        web.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--name", "web", "--memory", "512"]
        end
        web.vm.box = "base"
        web.vm.hostname = "web"
        web.vm.network :private_network, ip : "11.11.11.1"
    end
    
    config.vm.define :db do |db|
        db.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--name", "db", "--memory", "512"]
        end
        db.vm.box = "base"
        db.vm.hostname = "db"
        db.vm.network :private_network, ip : "11.11.11.2"
    end
end
~~~
这里使用了:web和:db定义了两个VM，设置完后再使用vagrant up启动。可以通过vagrant ssh web和vagrant ss db分别登录指定虚拟机上。
验证两台虚拟机间的通信: (验证方法: 在web虚拟机上通过ssh登录到db虚拟机)

https://blog.csdn.net/xiang__liu/article/details/80878571
https://max.book118.com/html/2017/0817/128451852.shtm

# 打包分发
当你配置好开发环境后，退出并关闭虚拟机。在终端里对开发环境进行打包：vagrant package

打包完成后会在当前目录生成一个 package.box 的文件，将这个文件传给其他用户，其他用户只要添加这个 box 并用其初始化自己的开发目录就能得到一个一模一样的开发环境了。
~~~
$ vagrant box add hahaha ~/box/package.box  # 添加 package.box 镜像并命名为 hahaha
$ cd ~/dev  # 切换到项目目录
$ vagrant init hahaha  # 用 hahaha 镜像初始化。
~~~

# 集成预安装
~~~
上面这条看下来，你会发现每次都修改了一点点内容，再打包分发给其他用户其实很麻烦。为此 Vagrant 还提供了更为便捷的预安装定制。打开 Vagrantfile 文件末尾处有下面被注释的代码：

config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get install -y apache2
SHELL
没错，这段代码就是让你在初次运行 vagrant up 后，虚拟机创建过程众自动运行的初始化命令。 取消注释，把要预先安装的 php/mysql/redis 和配置之类的通通都写进去。初始化时这些程序都会根据你写好的方法安装并配置。

如果你不是初次运行，同时又修改了这里的命令，想让系统再次运行这里面的命令，你可以使用 vagrant reload --provision 进行重载。所以在这种情况下，你只要将 Vagrantfile 共享给团队的其他成员就可以了，其他成员运行相同的命令即可，是不是比打包分发要方便许多。

你还可以把要运行的命令单独写在一个文件里存放在相同的目录下，比如 bootstrap.sh：

#!/usr/bin/env bash

apt-get update
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
然后在 Vagrantfile 里这样添加：

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  ...

  config.vm.provision "shell", path: "bootstrap.sh"  # 添加这行
end
效果和直接写在 Vagrantfile 是一样的。
~~~

# 用 vagrant 快速部署 docker 虚拟机集群
* https://blog.csdn.net/pmlpml/article/details/53925542
* https://blog.csdn.net/u011781521/article/details/80291765