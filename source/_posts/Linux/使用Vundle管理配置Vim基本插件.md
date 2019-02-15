---
title: 使用Vundle管理配置Vim基本插件
tags:
  - CentOS
copyright: true
comments: true
toc: true
date: 2018-12-19 15:29:55
categories: Linux
password:
---

# 说明
官网：https://github.com/VundleVim/Vundle.vim
> Vundle是基于Git仓库的插件管理软件。Vundle将插件的安装简化为类似yum软件安装的过程

> 其特色在于使用git来管理插件,更新方便，支持搜索，一键更新，从此只需要一个vimrc走天下

# 配置说明
1. 在Github vim-scripts 用户下的repos,只需要写出repos名称
2. 在Github其他用户下的repos, 需要写出”用户名/repos名”
3. 不在Github上的插件，需要写出git全路径

具体步骤：

1. 需要有git环境，CentOS7自带，可通过git命令查看
2. 安装Vundle：git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
3. 修改.vimrc／vimrc文件，在CentOS7中是vimrc文件，修改前先备份.
* 将以下内容放置到文件最开头，最小配置如下：
~~~
set nocompatibl 
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

call vundle#end()

filetype plugin indent on
~~~
在Plugin之后，添加自己想要安装的插件
4. 插件安装： 
~~~
# 在vim中
:PluginInstall

# 在终端
vim +PluginInstall +qall
~~~
# 命令说明
~~~
:PluginList -列举出列表中(.vimrc中)配置的所有插件
:PluginInstall -安装列表中全部插件
:PluginInstall! -更新列表中全部插件
:PluginSearch foo -查找foo插件
:PluginSearch! foo -刷新foo插件缓存
:PluginClean -清除列表中没有的插件
:PluginClean! -清除列表中没有的插件
~~~

# 常用插件说明
* rename.vim：在Vim中为文件重命名。
* vim-coffee-script：在Vim中舒心 的编写、编译Coffeescript。
* vim-mkdir：当你在Vim中新建文件的时候， 自动帮你创建不存在的目录。
* vim-surround：快速的删除、修改和添加 括号、引号、XML标签等等。
* matchit：用%去在两个对应的字符间跳转。
* tComment：快速注释、反注释代码。
* emmet-vim：Emmet的Vim版。
* tabular：快速对齐。
* snipmate.vim：快速的代码片段。
* vim-easymotion：在文件中快速定位。
* vim-instant-markdown：Vim中对 
* Markdown文档的实时预览。
* NERDTree:一个用于浏览文件系统的树形资源管理外挂,它可以让你像使用Windows档案总管一样在VIM中浏览文件系统并且打开文件或目录
* MiniBufExplorer:提供多文件同时编辑功能，并在编辑器上方显示文件的标签
* 一款状态栏增强插件，可以让你的Vim状态栏非常的美观，同时包括了buffer显示条扩展smart tab line以及集成了一些插件
* 

# 网络上配置收藏
1. https://github.com/deepzz0/dotfiles/blob/master/.vimrc
2.
~~~
if &compatible
  set nocompatible
end

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Define bundles via Github repos
Bundle 'christoomey/vim-run-interactive'
Bundle 'croaky/vim-colors-github'
Bundle 'danro/rename.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'pbrisbin/vim-mkdir'
Bundle 'scrooloose/syntastic'
Bundle 'slim-template/vim-slim'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/ctags.vim'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/tComment'
Bundle "mattn/emmet-vim"
Bundle "scrooloose/nerdtree"
Bundle "Lokaltog/vim-powerline"
Bundle "godlygeek/tabular"
Bundle "msanders/snipmate.vim"
Bundle "jelera/vim-javascript-syntax"
Bundle "altercation/vim-colors-solarized"
Bundle "othree/html5.vim"
Bundle "xsbeats/vim-blade"
Bundle "Raimondi/delimitMate"
Bundle "groenewege/vim-less"
Bundle "evanmiller/nginx-vim-syntax"
Bundle "Lokaltog/vim-easymotion"
Bundle "tomasr/molokai"

if filereadable(expand("~/.vimrc.bundles.local"))
  source ~/.vimrc.bundles.local
endif

filetype on
~~~