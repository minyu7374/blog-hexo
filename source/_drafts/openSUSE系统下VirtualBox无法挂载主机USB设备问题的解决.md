---
title: "openSUSE系统下VirtualBox无法挂载主机USB设备问题的解决"
date: "2015-09-24T12:25:19+08:00"
categories:
tags:
---

                                            
这个问题几乎可以说是openSUSE系统下独有的问题，在网上查了很多资料，可查到的绝大部分都是说ubuntu上的相似问题，那问题很简单，其实就是他们没有将自己的的用户添加到vboxusers用户组上。而我确认自己的用户已经加入  vboxusers组、并且早就安装了 <code style="font-family:Monaco, Menlo, Consolas, 'Courier New', monospace;color:rgb(51,51,51);border:none;line-height:27.2px;text-indent:16px;">Oracle
 Extensions</code> 扩展包，后来在openSUSE的论坛上才找到真正的解决方案:
问题的关键在于 /usr/lib/udev/rules.d/60-vboxdrv.rules
 文件，该文件内容如下：
KERNEL=="vboxdrv",
 NAME="vboxdrv", OWNER="root", GROUP="vboxusers", MODE="0660"

#

#these lines below give access permission to vboxusers to properly work with usb nodes, but enabling them could be security risk (bnc#664520) !!

#if you can live with this security problem put these lines below in to the new file /etc/udev/rules.d/60-vboxdrv.rules so they will stay enabled also after package update

#SUBSYSTEM=="usb_device", ACTION=="add", RUN+="/usr/lib/udev/VBoxCreateUSBNode.sh $major $minor $attr{bDeviceClass} vboxusers"

#SUBSYSTEM=="usb", ACTION=="add", ENV{DEVTYPE}=="usb_device", RUN+="/usr/lib/udev/VBoxCreateUSBNode.sh $major $minor $attr{bDeviceClass} vboxusers"

#SUBSYSTEM=="usb_device", ACTION=="remove", RUN+="/usr/lib/udev/VBoxCreateUSBNode.sh --remove $major $minor"

#SUBSYSTEM=="usb", ACTION=="remove", ENV{DEVTYPE}=="usb_device", RUN+="/usr/lib/udev/VBoxCreateUSBNode.sh --remove $major $minor"

将被注释掉的那四行规则打开就可以了，至于它说的安全问题（security
 problem）我就先不管了。



