---
title: cat和EOF的使用+action用法
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

# 简介
* cat：用于显示文本文件内容，全部输出
* EOF： “end of file”，表示文本结束符

> EOF“通常与”<<“结合使用，“<<EOF“表示后续的输入作为子命令或子shell的输入，直到遇到”EOF“，再次返回到主调shell，可将其理解为分界符（delimiter）

> 当shell看到”<<“知道其后面输入的分界符，当shell再次看到分界符时，两个分界符中间的部分将作为标准输入,其使用形式如下：

~~~
交互式程序(命令)<<EOF
command1
command2
...
EOF     //最后的”EOF“必须单独占一行，必须顶行写，前面不能用制表符或者空格
~~~

# cat+EOF的使用
> 第一种形式和第二种形式没有什么本质的区别，第一种形式将内容直接输出到标准输出（屏幕），而第二种形式将标准输出进行重定向，将本应输出到屏幕的内容重定向到文件

1. cat<<EOF
2. cat<<EOF>filename或者cat>>filename<<EOF

==说明==：关于“>”、“>>”、“<”、“<<”等的意思，请自行查看bash的介绍

# EOF与-EOF的区别

> 如果结束分解符EOF前有制表符或者空格，则EOF不会被当做结束分界符，只会继续被当做stdin来输入。
而<<-就是为了解决这一问题:

> 如果重定向的操作符是<<-，那么分界符（EOF）所在行的开头部分的制表符（Tab）都将被去除
---

# action  "" /bin/true 的用法
> action是个bash的函数.true命令啥都不做，只设置退出码为0

> 使用举例：==action “操作成功！” /bin/true==
~~~
# Run some action. Log its output.
action() {
  local STRING rc

  STRING=$1
  echo -n "$STRING "
  shift
  "$@" && success $"$STRING" || failure $"$STRING"
  rc=$?
  echo
  return $rc
}
~~~