---
title: "unzip 解压windows上zip文件乱码的问题"
date: "2017-05-26T18:03:07+08:00"
categories:
tags:
---

                                            
对于gentoo而言，只需要为unzip的use标记加入<strong>natspec </strong>重新编译即可。
我的unzip标记信息如下：
   USE="<strong>bzip2 </strong><strong>natspec </strong><strong>unicode</strong>" ABI_X86="<strong>64</strong>"

解压命令是：
   unzip -O CP936 windows中文压缩包.zip

