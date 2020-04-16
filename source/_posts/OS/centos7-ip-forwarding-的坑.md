---
title: "centos7 ip forwarding 的坑"
date: "2016-07-21T21:55:13+08:00"
categories:
- [OS, Linux]
tags:
- Linux
- CentOS
---

在Centos6上允许ip转发只需要在 ***/etc/sysctl.conf*** 里加入

`
net.ipv4.ip_forward = 1 
`

即可（reboot或用sysctl -p立即生效）

可在Centos7里这样是远远不够的。
<!-- more -->

这也导致了我在Centos７上，无论配pptp还是openvpn，都只能是正常连上服务，却不能正常上网。

确定了服务配置的没有问题后，基本锁定是转发的问题了，在网上查解决方案，恶心的百度能看到只是一些乱七八糟、没有什么水平的博客

google搜索第一页能找到我要的答案。如下：

```
in my installation of Centos 7:

cat /etc/sysctl.conf
System default settings live in /usr/lib/sysctl.d/00-system.conf. To override those settings, enter new settings here, or in an /etc/sysctl.d/.conf
 file For more information, see sysctl.conf(5) and sysctl.d(5).

so, you should add into the file

/usr/lib/sysctl.d/50-default.conf
```

也就是说，只需要再在 ***/usr/lib/sysctl.d/50-default.conf*** 文件里加入

`
net.ipv4.ip_forward = 1 
`

就可以了。
