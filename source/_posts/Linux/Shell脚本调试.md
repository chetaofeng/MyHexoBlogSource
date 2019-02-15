---
title: Shell脚本调试
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

# 前言
> shell编程在unix/linux世界中使用得非常广泛，熟练掌握shell编程也是成为一名优秀的unix/linux开发者和系统管理员的必经之路

> 与其它高级语言相比，shell解释器缺乏相应的调试机制和调试工具的支持，其输出的错误信息又往往很不明确

# 调试方法
## 通过echo方式
~~~
功能: 最简单的调试方法，可以在任何怀疑出错的地方用echo打印变量
场合: 所有怀疑可能有问题的地方
示例: echo $VAR
~~~
## 通过test的方式
返回值为0为真,1表假
~~~
test -f /test.sh | echo $?
~~~

## 使用调试工具-bashdb
> 使用shell调试器bashdb，这是一个类似于GDB的调试工具，可以完成对shell脚本的断点设置，单步执行，变量观察等许多功能

用法：bashdb -c script.sh   或者 bashdb script.sh

## 通过trap来调试
~~~
作用: 用于捕获指定的信号并执行预定义的命令
语法: trap `command` signal
说明: signal是要捕获的信号,command是捕获到指定的信号，所要执行的命令, 可以用kill -l命令看到系统中全部可用的信号名,捕获信号后所执行的命令,可以是一条或多条合法的Shell语句,也可以是一个函数名, Shell脚本执行时，会产生三个伪信号(之所以称为伪信息，因这是shell自己产生，而非操作系统产生)，通过使用trap 捕获这三个伪信号并输出信息对调试大有帮助

Shell脚本执行时，会产生三个伪信号(之所以称为伪信息，因这是shell自己产生，而非操作系统产生)，通过使用trap 捕获这三个伪信号并输出信息对调试大有帮助.SHELL三个伪信号:

* EXIT  从一个函数中退出或整个执行完毕
* ERR   当一个命令执行不成功，返回非0状态时
* DEBUG 脚本中每一条命令执行之前
~~~

~~~
#!/bin/bash
errorTrap()
{
    echo "[LINE:$1]Error: Command or function exited with status $?"
}
foo()
{
    return 1;
}
trap 'errorTrap $LINENO' ERR
abc
foo
脚本输出:
[root@localhost:shell]# bash test.sh
test.sh: line 12: abc: command not found
[LINE:12]Error: Command or function exited with status 127
[LINE:9]Error: Command or function exited with status 1
~~~
在调试过程中，为了跟踪某些变量的值，我们常常需要在shell脚本的许多地方插入相同的echo语句来打印相关变量的值，这种做法显得烦琐而笨拙。而通过捕获DEBUG信号，我们只需要一条trap语句就可以完成对相关变量的全程跟踪。
~~~
#!/bin/bash
trap 'echo “before execute line:$LINENO, a=$a,b=$b,c=$c”' DEBUG
a=1
if [ "$a" -eq 1 ]
then
  b=2
else
  b=1
fi
c=3
echo "end"
~~~
其执行输出结果如下：
~~~
before execute line:3, a=,b=,c=
before execute line:4, a=1,b=,c=
before execute line:6, a=1,b=,c=
before execute line:10, a=1,b=2,c=
before execute line:11, a=1,b=2,c=3
end
~~~

## 使用tee命令
> 在shell脚本中管道以及输入输出重定向使用得非常多，在管道的作用下，一些命令的执行结果直接成为了下一条命令的输入。如果我们发现由管道连接起来的一批命令的执行结果并非如预期的那样，就需要逐步检查各条命令的执行结果来判断问题出在哪儿，但因为使用了管道，这些中间结果并不会显示在屏幕上，给调试带来了困难，此时我们就可以借助于tee命令了

> tee命令会从标准输入读取数据，将其内容输出到标准输出设备,同时又可将内容保存成文件
~~~
ipaddr=`/sbin/ifconfig | grep 'inet addr:' | grep -v '127.0.0.1'
| tee temp.txt | cut -d : -f3 | awk '{print $1}'`
~~~

## 使用"调试钩子"
> 在C语言程序中，我们经常使用DEBUG宏来控制是否要输出调试信息，在shell脚本中我们同样可以使用这样的机制，这样的代码块通常称之为“调试钩子”或“调试块”.如下列代码所示：
~~~
if [ “$DEBUG” = “true” ]; then
echo “debugging”  #此处可以输出调试信息
fi
~~~

## 通过选项方式
* -n:选项只做语法检查，而不执行脚本  //sh -n script_name.sh
* -x:启动调试   //sh -x script_name.sh
 > 进入调试模式后，Shell依次执行读入的语句，产生的输出中有的带加号，有的不带。带加号表示该条语句是Shell执行的；不带加号表示该语句是Shell产生的输出；前面有“++”号的行是执行trap机制中指定的命令。"+"号后面显示的是经过了变量替换之后的命令行的内容，有助于分析实际执行的是什么命令
~~~
1).在命令行提供参数：$ sh -x script.sh
2).脚本开头提供参数：#!/bin/sh -x
3).在脚本中用set命令启用or禁用参数：其中set -x表启用，set +x表禁用
~~~
* -c:该选项使Shell解析器从字符串而非文件中读取并执行命令,如：bash -c 'x=1;y=2;let z=x+y;echo "z=$z"'
* -v：区别于-x参数,该选项打印命令行的原始内容，-x参数打印出经过替换后命令行的内容，适用于仅想显示命令行的原始内容
* Ctrl + Z:中断调试，观察结果，然后再按fg键继续调试即可
* 调试代码块:-x选项是调试整个脚本的，如果脚本很大，会很不方便，还有一种方法是调试某一块代码的
~~~
set -x
...
code block
...
set +x
~~~

# shell内置的环境变量
* $LINENO：代表shell脚本的当前行号，类似于C语言中的内置宏__LINE__
* $FUNCNAME：函数的名字，它是一个数组变量，其中包含了整个调用链上所有的函数的名字，故变量${FUNCNAME[0]}代表shell脚本当前正在执行的函数的名字，而变量${FUNCNAME[1]}则代表调用函数${FUNCNAME[0]}的函数的名字，余者可以依此类推
* $PS4：

# 常见错误诊断
* xxx.sh: cannot shift
~~~
这种错误一般是参数传递有误，比如没有给参数，或者参数个数少了。因为shell脚本使用shift来获取下一个参数，如果个数不对，shift命令就会失败
~~~
* xxx.sh: ^M: not found
~~~
^M是Windows上的回车符\r在UNIX上的显示形式。这种情况多半是在Windows上编辑了shell脚本，然后拿到UNIX/Linux上执行。如下处理即可：
tr -d "\015" < oldfile.sh > newfile.sh  //\r的ASCII码是\015
~~~