---
title: node安装配置
tags:
  - node
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: 环境搭建
password:
---

# 相关概念
nodejs：在项目开发时的所需要的代码库
nvm：nodejs 版本管理工具。
npm：nodejs包管理工具，在安装的 nodejs 的时候，npm也会跟着一起安装，它是包管理工具，管理nodejs中的第三方插件
yarn：Yarn是由Facebook、Google、Exponent 和 Tilde 联合推出了一个新的 JS 包管理工具 ， 是为了弥补 npm 的一些缺陷而出现的
即：一个nvm可以管理多个node版本和npm版本

# nvm安装
官网： https://github.com/creationix/nvm
安装：curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
安装完成后的提示界面会有类似一下的提示信息：
~~~
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
~~~
在~/.bash_profile中添加以上内容(如果没有这个文件则创建)后保存；通过source ~/.bash_profile使设置生效。 
安装完成后关闭终端，重新打开终端输入 nvm 验证一下是否安装成功

注：curl看系统是否已安装，如果没有安装则：sudo apt-get install curl

# nvm常用命令
nvm install stable ## 安装最新稳定版 node，当前是node v9.5.0 (npm v5.6.0)
nvm install <version> ## 安装指定版本，可模糊安装，如：安装v4.4.0，既可nvm install v4.4.0，又可nvm install 4.4
nvm uninstall <version> ## 删除已安装的指定版本，语法与install类似
nvm use <version> ## 切换使用指定的版本node
nvm ls ## 列出所有安装的版本
nvm ls-remote ## 列出所有远程服务器的版本（官方node version list）
nvm current ## 显示当前的版本
nvm alias <name> <version> ## 给不同的版本号添加别名
nvm unalias <name> ## 删除已定义的别名
nvm reinstall-packages <version> ## 在当前版本 node 环境下，重新全局安装指定版本号的 npm 包 

# nvm安装node
nvm install stable

# yarn
快速、可靠、安全的依赖管理工具
## 安装
brew install yarn
brew install yarn --without-node

# Yarn和npm命令对比
npm |	yarn
----|-------
npm install |	yarn install
npm install react --save |	yarn add react
npm uninstall react --save |	yarn remove react
npm install react --save-dev |	yarn add react --dev
npm update --save |	yarn upgrade

 