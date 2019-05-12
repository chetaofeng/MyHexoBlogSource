---
title: linux 配置文件启动顺序
tags:
  - Linux
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

https://www.cnblogs.com/GO-NO-1/p/9084713.html

[toc]

# 启动顺序概述
当用户打开PC的电源，BIOS开机自检，按BIOS中设置的启动设备(通常是硬盘)启动，接着启动设备上安装的引导程序lilo或grub开始引导 Linux，Linux首先进行内核的引导，接下来执行init程序，init程序调用了rc.sysinit和rc等程序，rc.sysinit和rc 当完成系统初始化和运行服务的任务后，返回init；init启动了mingetty后，打开了终端供用户登录系统，用户登录成功后进入了Shell，这 样就完成了从开机到登录的整个启动过程。

# 0.BIOS加电自检
* 首先被启动执行的就是这个BIOS（BasicInput/Output System）程序。访问硬盘先头512Bit的MBR（Master Boot Record）
* 经BIOS的控制，将MBR中的Boot Record调入内存中。这里就要说说Linux的Boot程序了，Linux的Boot程序有GRUB和LILO，而CentOS默认的Boot程序是GRUB
* 通过Boot程序，访问硬盘中的Linux内核程序
* 将内核程序调入内存中

# 1.内核的引导(核内引导)
> Red Hat可以使用lilo或grub等引导程序开始引导Linux系统，当引导程序成功完成引导任务后，Linux从它们手中接管了CPU的控制权， 然后CPU就开始执行Linux的核心映象代码，开始了Linux启动过程。

内核程序调用完成后，通过内核访问硬盘中将要用到的其他文件。
内核第一个执行的文件是/sbin/init，而这个文件的设置和定义文件是/etc/inittab这个文件，也就是说/sbin/init按照/etc/inittab的定义来执行下一步的启动

# 2.运行init
1. init是一个由内核启动的用户级进程。它的进程号是1，从这一点就能看出，init进程是系统所有进程的起点，Linux在完成核内引导以后，就开始运行init程序
2. init程序需 要读取配置文件/etc/inittab。inittab是一个不可执行的文本文件，它有若干行指令所组成
3. inittab的格式如下。其中以#开始的行是注释行，除了注释行之外，每一行都有以下格式：
~~~
id:runlevel:action:process
* id:是指入口标识符，它是一个字符串，对于getty或mingetty等其他login程序项，要求id与tty的编号相同，否则getty程序将不能正常工作。
* runlevel: 是init所处于的运行级别的标识，一般使用0－6以及S或s。
 - 0、1、6运行级别被系统保留：其中0作为shutdown动作，1作为重启至单用户模 式，6为重启；S和s意义相同，表示单用户模式，且无需inittab文件，因此也不在inittab中出现
 - runlevel可以是并列的多个值，以匹配多个运行级别，对大多数action来说，仅当runlevel与当前运行级别匹配成功才会执行
* action:描述其后的process的运行方式的。action可取的值包括：initdefault、sysinit、boot、bootwait等
* process为具体的执行程序。程序后面可以带参数
~~~

加载内核 执行init程序
~~~
* /etc/rc.d/rc.sysinit  #由init执行的第一个脚本
 - 主要做在各个运行模式中相同的初始化工作，包括： 调入keymap以及系统字体 启动swapping 设置主机名、设置NIS域名检查(fsck)并mount文件系统打开quota 装载声卡模块设置系统时钟等等
* /etc/rc.d/rc $RUNLEVEL #$RUNLEVEL为缺省的运行模式
* /etc/rc.d/rc.local #相应级别服务启动之后、在执行该文件(其实也可以把需要执行的命令写到该文件中) 
* /sbin/mingetty # 等待用户登录
~~~

# 3.系统初始化
在init的配置文件中有这么一行:si::sysinit:/etc/rc.d/rc.sysinit
,它调用执行了/etc/rc.d/rc.sysinit，而rc.sysinit是一个bash shell的脚本，它主要是完成一些系统初始化的工作，rc.sysinit是每一个运行级别都要首先运行的重要脚本。它主要完成的工作有：激活交换分 区，检查磁盘，加载硬件模块以及其它一些需要优先执行任务。

# 4.启动对应运行级别的守护进程
在rc.sysinit执行后，将返回init继续其它的动作，通常接下来会执行到/etc/rc.d/rc程序。

以运行级别3为例，init将执行配置文件inittab中的以下这行：
==l5:5:wait:/etc/rc.d/rc 5==
~~~
* 这一行表示以5为参数运行/etc/rc.d/rc，/etc/rc.d/rc是一个Shell脚本，它接受5作为参数，去执行/etc/rc.d /rc5.d/目录下的所有的rc启动脚本
* /etc/rc.d/rc5.d/目录中的这些启动脚本实际上都是一些链接文件，而不是真正的rc启动脚本， 真正的rc启动脚本实际上都是放在/etc/rc.d/init.d/目录下
* 这些rc启动脚本有着类似的用法，它们一般能接受start、stop、 restart、status等参数
* /etc/rc.d/rc5.d/中的rc启动脚本通常是K或S开头的链接文件，对于以以S开头的启动脚本，将以start参数来运行；调用的顺序按xx 从小到大来执行
* 如果发现存在相应的脚本也存在K打头的链接，而且已经处于运行态了(以/var/lock/subsys/下的文件作 为标志)，则将首先以stop为参数停止这些已经启动了的守护进程，然后再重新运行
~~~

# 5.建立终端
* rc执行完毕后，返回init。这时基本系统环境已经设置好了，各种守护进程也已经启动了。init接下来会打开6个终端，以便用户登录系统
* 通过按Alt+Fn(n对应1-6)可以在这6个终端中切换。在inittab中的以下6行就是定义了6个终端：
~~~
1:2345:respawn:/sbin/mingetty tty1
2:2345:respawn:/sbin/mingetty tty2
3:2345:respawn:/sbin/mingetty tty3
4:2345:respawn:/sbin/mingetty tty4
5:2345:respawn:/sbin/mingetty tty5
6:2345:respawn:/sbin/mingetty tty6
~~~
从 上面可以看出在2、3、4、5的运行级别中都将以respawn方式运行mingetty程序，mingetty程序能打开终端、设置模式。同时它会显示 一个文本登录界面，这个界面就是我们经常看到的登录界面，在这个登录界面中会提示用户输入用户名，而用户输入的用户将作为参数传给login程序来验证用 户的身份。

# 6.登录系统，启动完成
* 当我们看到mingetty的登录界面时，我们就可以输入用户名和密码来登录系统了
* Linux 的账号验证程序是login，login会接收mingetty传来的用户名作为用户名参数。然后login会对用户名进行分析：如果用户名不是 root，且存在/etc/nologin文件，login将输出nologin文件的内容，然后退出。这通常用来系统维护时防止非root用户登录。
* 在分析完用户名后，login将搜索/etc/passwd以及/etc/shadow来验证密码以及设置账户的其它信息
    - 对于bash来说，系统首先寻找/etc/profile脚本文件，并执行它；然后如果用户的主目录中存在.bash_profile文件，就执行它

## 登录时自动运行程序
~~~
用户登录时，bash首先自动执行系统管理员建立的全局登录script ：/etc/profile。
然后bash在用户起始目录下按顺序查找三个特殊文件中的一个：/.bash_profile、/.bash_login、 /.profile，但只执行最先找到的一个。
因此，只需根据实际需要在上述文件中加入命令就可以实现用户登录时自动运行某些程序（类似于DOS下的Autoexec.bat）
~~~

## 退出登录时自动运行程序
~~~
退出登录时，bash自动执行个人的退出登录脚本/.bash_logout。
例如，在/.bash_logout中加入命令"tar －cvzf c.source.tgz ＊.c"，则在每次退出登录时自动执行 "tar" 命令备份 ＊.c 文件。
~~~

# rc.d目录
> 执行==ls -l /etc/rc.d==命令，会有刚提到的目录，说明如下：

1. init.d
* 这个不是文件，是一个目录，这个目录下面存放着各各服务的控制脚本，这下面的文件和你安装了些什么软件包有关系。
* etc/rc.d/rcX.d下的文件和这个init.d下面的文件是通过软连接相连的
2. rc
3. rc.loca
> 可以将启动命令写到这个文件中，让开机启动服务完毕之后，==最后==启动这个服务
4. rc.sysini
>这个文件是在boot的时候就被执行的脚本，它的任务是初始化系统的网络，设定hostname，欢迎信息表示，时钟设置，挂载文件系统等。
5. rcX.d
> 在察看这个文件的时候注意3点：
* ls -l 察看它们的详细信息，看看他们的link指向
* ls -l 察看它们的文件名的头字母，形式应该是这样的[S或K <数字> <名称>]的形势。==S代表启动==，==K代表停止==。
即：开机的时候，以S开头的脚本文件别执行，已被开机运行；以K开头的文件不被执行，这个文件所控制的服务也不被执行，这个文件控制的服务也不被开机运行
* 打开link指向的文件，文件头有类似“# chkconfig: 2345 10 90”一行，这一行就指定了其启动和的优先级

# 控制服务的一些工具
## chkconfig

## setup
> 是系统综合的配置工具，命令行下也可以用 

## system-config-services
> 如果你安装了gnome这样的窗口桌面系统，你也可以使用这个工具来体验下鼠标点击带来的方便。 

# Linux设置服务自启动的三种方式 
## ln -s
> ln -s                 在/etc/rc.d/rc*.d目录中建立/etc/init.d/服务的软链接(*代表0～6七个运行级别之一）

> etc/rc[0~6].d其实是/etc/rc.d/rc[0~6].d的软连接，主要是为了保持和Unix的兼容性才做此策

> 例如：etc/rc[0~6].d其实是/etc/rc.d/rc[0~6].d的软连接，主要是为了保持和Unix的兼容性才做此策

文件位于/etc/rc.d/init.d下,名为apached，如果要服务自启动，则：

* #chmod +x /etc/rc.d/init.d/apached //设置文件的属性为可执行
* #ln -s /etc/rc.d/init.d/apached /etc/rc3.d/S90apache //建立软连接,快捷方式
* #ln -s /etc/rc.d/init.d/apached /etc/rc0.d/K20apache

## chkonfig
> 命令行运行级别设置

> 如果需要自启动某些服务，只需使用chkconfig 服务名 on即可，若想关闭，将on改为off
在默认情况下，chkconfig会自启动2345这四个级别，如果想自定义可以加上--level选项

## ntsysv
> 伪图形运行级别设置

> 启动ntsysv有两种方式，一是直接在命令行中输入ntsysv，二是使用setup命令，然后选择系统服务

# 常见的守护进程
> 在每个运行级中将运行哪些守护进程，用户可以通过chkconfig或setup中的"System Services"来自行设定.

常见的守护进程:
~~~
amd：自动安装NFS守护进程
apmd:高级电源管理守护进程
arpwatch：记录日志并构建一个在LAN接口上看到的以太网地址和IP地址对数据库
autofs：自动安装管理进程automount，与NFS相关，依赖于NIS
crond：Linux下的计划任务的守护进程
named：DNS服务器
netfs：安装NFS、Samba和NetWare网络文件系统
network：激活已配置网络接口的脚本程序
nfs：打开NFS服务
portmap：RPC portmap管理器，它管理基于RPC服务的连接
sendmail：邮件服务器sendmail
smb：Samba文件共享/打印服务
syslog：一个让系统引导时起动syslog和klogd系统日志守候进程的脚本
xfs：X Window字型服务器，为本地和远程X服务器提供字型集
Xinetd：支持多种网络服务的核心守护进程，可以管理wuftp、sshd、telnet等服务
~~~