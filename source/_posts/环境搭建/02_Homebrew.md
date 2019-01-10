---
title: mac系统神奇：Homebrew
tags:
  - 环境搭建
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories:
password:
---

# Homebrew
Homebrew是一款Mac OS平台下的软件包管理工具，拥有安装、卸载、更新、查看、搜索等很多实用的功能。简单的一条指令，就可以实现包管理，而不用你关心各种依赖和文件路径的情况，十分方便快捷。

可以类比Homebrew的功能类似于前端技术的npm，RetHat系列的yum，Ubuntu系统的apt-get

# 安装
参考官网，使用非常简单： https://brew.sh/index_zh-cn
安装完之后可更新源： brew update/brew upgrade 

# Homebrew使用
搜索软件：brew search 软件名，如brew search wget
安装软件：brew install 软件名，如brew install wget
卸载软件：brew remove 软件名，如brew remove wget

在macOS系统上，git、node都推荐通过Homebrew安装