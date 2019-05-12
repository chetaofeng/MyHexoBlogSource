---
title: k8s基础
tags:
  - docker
copyright: true
comments: true
toc: true
date: 2019-03-02 09:38:59
categories: docker
password:
---

# 应用部署模式的变迁
![image](/pub-images/应用部署模式变迁.png)

# 云原生
* “云原生”是一种构建和运行应用程序的方法，它利用了云计算交付模型的优势
* “云原生”是关于如何创建和部署应用程序，和位置无关。 这意味着应用程序位于云中，而不是传统数据中心
![image](/pub-images/云原生12原则.png)
云原生应用的三大特征：
* 容器化封装：以容器为基础，提高整体开发水平，形成代码和组件重用，简化云原生应用程序的维护。在容器中运行应用程序和进程，并作为应用程序部署的独立单元，实现高水平资源隔离。
* 动态管理：通过集中式的编排调度系统来动态的管理和调度。
* 面向微服务：明确服务间的依赖，互相解耦
![image](/pub-images/云原生能力与特点.jpg)

# k8s简介
* k8s是以google内部容器编排管理容器borg为原型的开源实现
* k8s是一个容器编排管理平台；一个微服务支撑平台；一个可移植的"云平台"

## 容器编排管理平台
k8s作为容器编排管理平台提供：
* 以Pod（容器组）为基本的编排和调度单元以及声明式的对象配置模型（控制器、configmap、secret等）
* 资源配额与分配管理
* 健康检查、自愈、伸缩与滚动升级

## 微服务支撑平台
k8s作为微服务支撑平台提供：
* 服务发现、服务编排与内部路由支持
* 服务快速部署与自动负载均衡
* 提供对"有状态"服务的支持等

## 可移植的云平台
为用户提供简单且一致化的容器化应用部署、伸缩和管理机制，形成新的、通用的应用云化模型

# k8s集群初体验
![image](/pub-images/hellok8s.png)

# k8s架构介绍
![image](/pub-images/k8s架构全图.png)
## Master组件：集群大脑
![image](/pub-images/masternode.png) 
* 所有集群的控制命令都传递给Master组件并在其上执行
* 每个k8s集群至少有一套Master组件
* 每套master组件包含3个核心组件（apiserver，scheduler，controller-manager）以及集群数据配置中心etcd
### API Server
* 集群控制的唯一入口，是提供k8s集群控制的restful API的核心组件
* 集群各个组件之间数据交互和通信的中枢
* 提供集群控制的安全机制（身份认证、授权以及admission control）
### Scheduler
* 通过APIServer的Watch接口监听新建pod副本信息，并通过调度算法为该pod选择一个最合适的node
* 支持自定义调度算法provider
* 默认调度算法内置预选策略和优选策略，决策考量资源需求、服务质量、软硬件约束、亲缘性、数据局部性等指标参数
### ControllerManager
* 集群内各种资源controller的核心管理者
* 针对每一种具体的资源，都有相应的controller
* 保证其下管理的每个controller所对应的资源始终处于"期望状态"
#### Etcd
* k8s集群的祝数据库，存储着所有资源对象及状态
* 默认与Master组件部署在一个Node上
* Etcd的数据变更都是通过API Server进行
## Node组件：工作负载节点
* k8s集群由多个node共同承担工作负载，Pod被分配到某个具体的node上执行
* k8s通过node controller对node资源进行管理，支持动态增删node
* 每个集群node上都会部署kubelet和kube-proxy两个组件
![image](/pub-images/k8snode.png) 
### kubelet
* 位于集群中每个node上的非容器形式的服务进程组件，Master和Node之间的桥梁
* 处理Master下发到本node上pod的创建、启停等管理任务；向API Server注册node信息
* 监控本node节点上容器和节点资源情况，并定期向Master汇报节点资源占用情况
### kube-proxy
* 运行在集群中每个node上
* Service抽象概念的实现，将到service的请求按策略（负载均衡）算法分发到后段Pod上
* 默认使用iptables mode实现
* 支持nodeport模式，实现从外部网络访问集群内的service

# k8s基础概念
## Kubernetes对象
是一种持久化的、用于表示集群状态的实体，使用yaml文件描述，ke通过API／cubectl管理
![image](/pub-images/k8sobject.png) 

## 常用Metadata属性
1. name和UID
* 对k8s集群中所有对象都通过name和UID明确标识
* API中的对象访问路径：/API/{version}/namespaces/{namespace}/{object-kind}/name
* 在k8s集群的整个生命周期内创建的每个对象实例都具有不同的UID
2. namespace
* 用于将物理集群划分为多个虚拟集群
* namespaces之间相互隔离，因此也常被用来隔离不同用户及权限
* k8s内置3个namespaces：defalut，kube-system和kube-public，Node和PersistentVolume不属于任何namespace
3. Label
* 用来建立集群之间的灵活的、松耦合的多维关联关系
* 一个label就是一个键-值对，其key-value均由用户自己定义
* label可附着在任何对象上，每个对象可以有任意个label
* label可以将有组织目的的结构映射到集群对象上，从而形成一个与现实世界管理结构同步对应松耦合的、多维的对象管理结构
* 通过label selector查询和筛选建立对象间的关系，其关联关系示例如下图：
![image](/pub-images/label关联.png) 
4. Annotaions
* Annotaions可以将任意非标识性元数据附加到对象上
* 以键值对形式呈现
* 工具和库可以检索到Annotaions元数据
* 将数据以Annotaions附着在对象上，有利于创建一些用于部署、管理和做内部检查的共享工具或客户端

## k8s对象分类
![image](/pub-images/k8s对象分类.png) 

Pod 以Pod为中心，集群调度的基本单元，是一个有特定关系的容器集合
![image](/pub-images/pod.png) 
* Pod是集群中可以创建和部署的最小且最简的k8s对象单元
* Pod也是一种封装，它封装了应用容器、存储资源、独立网络IP以及决定容器如何运行的策略选项
* 每个Pod中预置一个pause容器，其名字空间、IPC资源、网络资源和存储资源被pod内其他容器共享。pod内所有容器紧密协作，并作为一个整体被管理、调度和运行
* pod是一个非持久化性实体


